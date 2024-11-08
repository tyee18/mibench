# Introduction

## MiBench Build Instructions / Prerequisites
### Prequisites:
- Working version of `gcc`, `make`, `perf`
- Don't forget to quote the original source of MiBench, from the University of Michigan at Ann Arbor (https://vhosts.eecs.umich.edu/mibench/)

### Build and Execution Instructions
- Each set of benchmarks is compiled individually
  - By default, they are compiled using gcc (see each benchmark's default `Makefile` for further information)
  - There are several `run-all.sh` wrappers that have been generated, which also compile and run the benchmarks automatically, so you don't have to.
- Instructions as follows (assumes Chipyard has already been built / established) to build and run benchmarks **automated**:
  - At the top level directory, there should be a `run-all.sh` script, that can loop through available test suites, build them with your choice of compiler, and run them against a selected simulator.
  - Benchmarks are timed and saved off using `time` and `perf`, for viewing later. `perf` covers a lot of good basics, such as number of cycles / instructions / branches executed, branch misses.
    - Note that if you are using a WSL distribution on Windows 10, the aforementioned hardware counters are not supported. Workarounds include running benchmarks on Windows 11, or having a physical installation of Linux / Ubuntu / your distribution of choice.
- Instructions as follows (assumes Chipyard has already been built / established) to build and run benchmarks manually:
  1. From your MiBench repo, source the chipyard `env.sh` so that you have paths to the tools available
  2. Set your `CC` environment variable to whichever `gcc` library you plan on using for compatibility to your simulated design. In my case, I was running with a verilator simulator harness, on a Windows Subsystem for Linux (WSL), so I chose to use the `riscv64-unknown-elf-gcc`. So:
     1. In Bash: `export CC=~/chipyard/.conda-env/riscv-tools/bin/riscv64-unknown-elf-gcc`
  3. Compile whichever MiBench benchmark(s) you'd like to run with their default `Makefile`. Setting your cross-compiler (`CC`) variable ensures that the benchmarks are built to run with the Chipyard simulator.
  4. Call the executed binary to run whichever test(s) you desire. Example:
     1. `/path/to/your/simulator-chipyard.harness-LargeBoomV3Config pk ./basicmath_small`
        - Note that these runs take **HOURS** if running through a simulated chip, such as `RocketChip`.
        - Also note that the `pk` call is necessary for this to run properly.

## Chipyard RTL Build Instructions / Prerequisites
### Prerequisites:
- It is **HIGHLY** recommended to follow the Chipyard documentation in order to set up your environment for first-time use (https://chipyard.readthedocs.io/en/latest/index.html)
- At a minimum, you'll want to have the following available after building Chipyard RISC-V tools for the first time:
  - A compiled version of `conda`, which should be generated when setting up Miniforge prior to cloning out and building Chipyard.
    - Note that you might need to update your personal environment variables to make sure this is sourced properly at the start of a new session.
  - A working, compiled set of `riscv-tools` binaries (particularly the gcc libraries for RISC-V elf binaries, such as `riscv64-unknown-elf-gcc`)
  - The `env.sh` file that is generated after you build the `riscv-tools` within the Chipyard framework for the first time (through running the `build-setup.sh` script at the top level of the repo)
  - A compiled simulation binary (I happen to have used my verilator compiled binary for the sake of example), such as `simulator-chipyard.harness-LargeBoomV3Config`