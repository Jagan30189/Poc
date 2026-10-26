CC ?= gcc
CXX ?= g++

CPPFLAGS ?= -I.
CFLAGS ?= -std=c11 -Wall -Wextra -Wpedantic
CXXFLAGS ?= -std=c++17 -Wall -Wextra -Wpedantic
GTEST_CXXFLAGS ?=
GTEST_LIBS ?= -lgtest -lgtest_main -pthread

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

.PHONY: all build test coverage clean check-gtest

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
	rm -rf $(BUILD_DIR)
