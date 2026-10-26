CC ?= gcc
CXX ?= g++

CPPFLAGS ?= -I.
CFLAGS ?= -std=c11 -Wall -Wextra -Wpedantic
CXXFLAGS ?= -std=c++17 -Wall -Wextra -Wpedantic
GTEST_CXXFLAGS ?=
GTEST_LIBS ?= -lgtest -lgtest_main -pthread
MISRA_CONFIG := misra.json

BUILD_DIR := build
TEST_BIN := $(BUILD_DIR)/medical_test
MEDICAL_BIN := $(BUILD_DIR)/medical
TEST_OBJECT := $(BUILD_DIR)/medical_test.o
MEDICAL_OBJECT := $(BUILD_DIR)/medical.o
COVERAGE_DIR := $(BUILD_DIR)/coverage
COVERAGE_OBJECT := $(COVERAGE_DIR)/medical.o
COVERAGE_TEST_OBJECT := $(COVERAGE_DIR)/medical_test.o
COVERAGE_TEST_BIN := $(COVERAGE_DIR)/medical_test
BUILD_STAMP := $(BUILD_DIR)/.directory
COVERAGE_STAMP := $(COVERAGE_DIR)/.directory

.PHONY: all build test coverage clean check-gtest static-analysis misra-check memcheck \
	optimized-assembly debug check thread-check main-check

all: build

build: $(MEDICAL_BIN)

$(BUILD_STAMP):
	mkdir -p $(BUILD_DIR)
	touch $@

$(COVERAGE_STAMP):
	mkdir -p $(COVERAGE_DIR)
	touch $@

$(MEDICAL_BIN): medical.c | $(BUILD_STAMP)
	$(CC) $(CPPFLAGS) $(CFLAGS) -g $< -o $@

check-gtest:
	@printf 'Checking GoogleTest... '
	@command -v $(CXX) >/dev/null || { echo 'g++ is required'; exit 1; }
	@printf '#include <gtest/gtest.h>\nint main() { return 0; }\n' | $(CXX) $(GTEST_CXXFLAGS) -x c++ - $(GTEST_LIBS) -o /tmp/gtest_link_check >/dev/null 2>&1 || { echo 'missing; install with: sudo apt-get update && sudo apt-get install -y libgtest-dev'; exit 1; }
	@rm -f /tmp/gtest_link_check
	@echo 'ok'

$(MEDICAL_OBJECT): medical.c medical.h | $(BUILD_STAMP)
	$(CC) $(CPPFLAGS) $(CFLAGS) -DUNIT_TEST -g -c $< -o $@

$(TEST_OBJECT): tests/medical_test.cpp medical.h | $(BUILD_STAMP)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(GTEST_CXXFLAGS) -g -c $< -o $@

$(TEST_BIN): check-gtest $(MEDICAL_OBJECT) $(TEST_OBJECT)
	$(CXX) $(CXXFLAGS) $(MEDICAL_OBJECT) $(TEST_OBJECT) $(GTEST_LIBS) -o $@

test: $(TEST_BIN)
	$(TEST_BIN)

main-check: $(MEDICAL_BIN)
	@printf '14\n' | $(MEDICAL_BIN) | grep -q 'Exiting System'

static-analysis:
	@command -v cppcheck >/dev/null || { echo 'cppcheck is required'; exit 1; }
	cppcheck --enable=all --inconclusive --std=c11 \
		--suppress=missingIncludeSystem medical.c medical.h

misra-check:
	@command -v cppcheck >/dev/null || { echo 'cppcheck is required'; exit 1; }
	@misra_addon="$(MISRA_ADDON)"; \
	if [ -z "$$misra_addon" ]; then \
		for candidate in \
			/usr/lib/*/cppcheck/addons/misra.py \
			/usr/share/cppcheck/addons/misra.py \
			/usr/local/share/cppcheck/addons/misra.py; do \
			if [ -f "$$candidate" ]; then misra_addon="$$candidate"; break; fi; \
		done; \
	fi; \
	if [ -z "$$misra_addon" ]; then \
		echo 'cppcheck MISRA addon (misra.py) is required'; \
		echo 'install it with the cppcheck package'; \
		exit 1; \
	fi; \
	echo "Running MISRA C:2012 verification with $$misra_addon"; \
	cppcheck --addon="$(MISRA_CONFIG)" --enable=all --inconclusive --std=c11 \
		--suppress=missingIncludeSystem --error-exitcode=1 medical.c medical.h

memcheck: $(TEST_BIN)
	valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all \
		--errors-for-leak-kinds=all --error-exitcode=1 $(TEST_BIN)

optimized-assembly:
	mkdir -p $(BUILD_DIR)/assembly
	$(CC) $(CPPFLAGS) $(CFLAGS) -O1 -S medical.c -o $(BUILD_DIR)/assembly/medical-O1.s
	$(CC) $(CPPFLAGS) $(CFLAGS) -O2 -S medical.c -o $(BUILD_DIR)/assembly/medical-O2.s
	$(CC) $(CPPFLAGS) $(CFLAGS) -O3 -S medical.c -o $(BUILD_DIR)/assembly/medical-O3.s
	@wc -c $(BUILD_DIR)/assembly/medical-O1.s \
		$(BUILD_DIR)/assembly/medical-O2.s $(BUILD_DIR)/assembly/medical-O3.s

debug:
	$(CC) $(CPPFLAGS) $(CFLAGS) -O0 -g3 -DDEBUG medical.c -o $(BUILD_DIR)/medical-debug

thread-check: $(TEST_BIN)
	@command -v valgrind >/dev/null || { echo 'valgrind is required'; exit 1; }
	valgrind --tool=helgrind --error-exitcode=1 $(TEST_BIN)

check: test main-check static-analysis

$(COVERAGE_OBJECT): medical.c medical.h | $(COVERAGE_STAMP)
	$(CC) $(CPPFLAGS) $(CFLAGS) -DUNIT_TEST -fprofile-arcs -ftest-coverage -O0 -g -c $< -o $@

$(COVERAGE_TEST_OBJECT): tests/medical_test.cpp medical.h | $(COVERAGE_STAMP)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(GTEST_CXXFLAGS) -fprofile-arcs -ftest-coverage -O0 -g -c $< -o $@

$(COVERAGE_TEST_BIN): check-gtest $(COVERAGE_OBJECT) $(COVERAGE_TEST_OBJECT)
	$(CXX) $(CXXFLAGS) -fprofile-arcs -ftest-coverage $(COVERAGE_OBJECT) $(COVERAGE_TEST_OBJECT) $(GTEST_LIBS) -o $@

coverage: $(COVERAGE_TEST_BIN)
	$(COVERAGE_TEST_BIN)
	@gcov -b -c -o $(COVERAGE_DIR) $(COVERAGE_OBJECT) > $(COVERAGE_DIR)/gcov-summary.txt
	@mv medical.c.gcov $(COVERAGE_DIR)/medical.c.gcov
	@echo 'Coverage report: $(COVERAGE_DIR)/medical.c.gcov'
	@grep -E 'Lines executed' $(COVERAGE_DIR)/gcov-summary.txt

clean:
	rm -rf $(BUILD_DIR) medical.log
