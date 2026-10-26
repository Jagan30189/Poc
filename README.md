# Medical Supply Management System

## Prerequisites

Linux or GitHub Codespaces with GCC, G++, Make, cppcheck (including its MISRA
addon), and GoogleTest:

```bash
sudo apt-get update
sudo apt-get install -y build-essential cppcheck libgtest-dev
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

The suite contains 11 GoogleTest cases covering inventory, stock, requests,
distribution, validation, capacity limits, and repeated fulfillment.

The project contains 21 functions: 20 application functions covered by the
GoogleTest suite and `main`, which is covered by the `main-check` command-line
smoke test. Run all function checks with:

```bash
make check
```

## Run Static Analysis

```bash
make static-analysis
```

This runs cppcheck with all standard checks enabled, including inconclusive
results, against `medical.c` and `medical.h`. The same check is included in
`make check`.

## MISRA C Compliance Verification

```bash
make misra-check
```

This runs cppcheck's MISRA C:2012 addon against the C implementation and header
with `--error-exitcode=1`. The project deviation list in
[`misra.json`](./misra.json) records the currently accepted rules for this
hosted, interactive example; any new MISRA rule violation fails the command.
The MISRA addon is distributed with cppcheck; Debian/Ubuntu
installations normally provide it under `/usr/lib/*/cppcheck/addons/misra.py`.

Records include timestamps in `DD-MM-YYYY HH:MM:SS` format:

- Inventory records store created and last-updated dates.
- Supply requests store created and processed dates.
- Distribution history stores the distributed date.

## Run Coverage

```bash
make coverage
```

This runs the tests with gcov instrumentation and writes:

- `build/coverage/medical.c.gcov`
- `build/coverage/gcov-summary.txt`

The current suite achieves more than 90% line coverage.

## Quality and Evaluation Targets

```bash
make check                 # GoogleTest plus cppcheck
make memcheck              # Valgrind leak and invalid-access checks
make optimized-assembly   # Compare O1, O2, and O3 assembly sizes
make debug                 # Build a GDB-ready debug executable
make thread-check          # Helgrind check (when concurrent tests are added)
```

The program validates dates, rejects empty fields, checks integer overflow when
receiving stock, and writes timestamped successful operations to `medical.log`.
The log is closed after every write so it can be checked for resource leaks.

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