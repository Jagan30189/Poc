# Medical Supply Management System

## Prerequisites

Linux or GitHub Codespaces with GCC, G++, Make, and GoogleTest:

```bash
sudo apt-get update
sudo apt-get install -y build-essential libgtest-dev
```

The project uses the system GoogleTest installation by default. Custom include
and library paths can be supplied with `GTEST_CXXFLAGS` and `GTEST_LIBS`.

## Build and Run

```bash
make build
./build/medical
```

## Run Tests

```bash
make test
```

The suite contains 9 GoogleTest cases covering inventory, stock, requests,
distribution, validation, capacity limits, and repeated fulfillment.

## Run Coverage

```bash
make coverage
```

This runs the tests with gcov instrumentation and writes:

- `build/coverage/medical.c.gcov`
- `build/coverage/gcov-summary.txt`

The current suite achieves more than 90% line coverage.

## Clean

```bash
make clean
```

## Package the Project

From the project root:

```bash
zip -r medical-supply-gtest.zip medical.c medical.h tests Makefile README.md .vscode \
	-x 'build/*' '*.o' '*.gcda' '*.gcno' '*.gcov'
```