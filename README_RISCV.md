# Table of Contents
- [Table of Contents](#table-of-contents)
  - [Introduction ](#introduction-)
  - [MiBench Notes ](#mibench-notes-)
    - [Prerequisites: ](#prerequisites-)
    - [Build and Execution Instructions: ](#build-and-execution-instructions-)
  - [Chipyard Build Notes ](#chipyard-build-notes-)
  - [Currently Supported Benchmarks:](#currently-supported-benchmarks)
    - [Automotive ](#automotive-)
    - [Consumer ](#consumer-)
    - [Network ](#network-)
    - [Office ](#office-)
    - [Security ](#security-)
    - [Telecomm ](#telecomm-)


## Introduction <a id="introduction-"></a>
The goal of this repository is to add compatibility between the free MiBench benchmark suite, and Chipyard RISC-V-compatible simulators. This allows others to benchmark new computer architecture implementations and compare performance to baseline designs.

## MiBench Notes <a id="mibench-notes-"></a>
### Prerequisites: <a id="prerequisites-"></a>
- Working version of `gcc`, `make`, `perf`
- Don't forget to quote the original source of MiBench, from the University of Michigan at Ann Arbor (https://vhosts.eecs.umich.edu/mibench/)

### Build and Execution Instructions: <a id="build-and-execution-instructions-"></a>
- Each set of benchmarks is compiled individually
  - By default, they are compiled using gcc (see each benchmark's default `Makefile` for further information)
  - There are several `run-all.sh` wrappers that have been generated, which also compile and run the benchmarks automatically, so you don't have to.
- Instructions as follows (assumes Chipyard has already been built / established) to build and run benchmarks **automated**:
  1. Copy your `env.sh` from your Chipyard repo into the top-level directory.
  2. Within the `run-all-rocket.sh` script, update the following variables for your testing:
     - `SRCDIRS`: which tests you want to run.
     - `RTLCONFIG`: the full path to your simulated design under test.
     - `RTLCONFIG_NAME`: the name of your simulated design under test. This can be whatever you'd like it to be.
  3. From the command line, execute `./run-all-rocket.sh`
     - Files for each benchmark should be produced and automatically moved into a folder called `_Benchmark_Results`. You should see the following:
           - `$RTLCONFIG_NAME'_'$benchmark'_'$timestamp'.txt'`: a file containing the timing data from `time` and `perf`.
           - Other files generated are artifacts of the tests themselves, and can be verified for functionality.
- Notes:
  - At the top level directory, there should be a `run-all-rocket.sh` script, that can loop through available test suites, build them with your choice of compiler, and run them against a selected simulator.
  - Benchmarks are timed and saved off using `time` and `perf`, for viewing later. `perf` covers a lot of good basics, such as number of cycles / instructions / branches executed, branch misses, but these are relative to your physical CPU, **NOT** the emulated RISC-V CPU.
    - Note that if you are using a WSL distribution on Windows 10, the aforementioned hardware counters are not supported. Workarounds include running benchmarks on Windows 11, or having a physical installation of Linux / Ubuntu / your distribution of choice.
- Instructions as follows (assumes Chipyard has already been built / established) to build and run benchmarks **manually**:
  1. From your MiBench repo, source the chipyard `env.sh` so that you have paths to the tools available
  2. Set your `CC` environment variable to whichever `gcc` library you plan on using for compatibility to your simulated design. In my case, I was running with a verilator simulator harness, on a Windows Subsystem for Linux (WSL), so I chose to use the `riscv64-unknown-elf-gcc`. So:
     1. In Bash: `export CC=~/chipyard/.conda-env/riscv-tools/bin/riscv64-unknown-elf-gcc`
  3. Compile whichever MiBench benchmark(s) you'd like to run with their default `Makefile`. Setting your cross-compiler (`CC`) variable ensures that the benchmarks are built to run with the Chipyard simulator.
  4. Call the executed binary to run whichever test(s) you desire. Example:
     1. `/path/to/your/simulator-chipyard.harness-LargeBoomV3Config pk ./basicmath_small`
        - Note that these runs take **HOURS** if running through a simulated chip, such as `RocketChip`.
        - Also note that the `pk` call is necessary for this to run properly.

## Chipyard Build Notes <a id="chipyard-build-notes-"></a>
- It is **HIGHLY** recommended to follow the Chipyard documentation in order to set up your environment for first-time use (https://chipyard.readthedocs.io/en/latest/index.html)
- At a minimum, you'll want to have the following available after building Chipyard RISC-V tools for the first time:
  - A compiled version of `conda`, which should be generated when setting up Miniforge prior to cloning out and building Chipyard.
    - Note that you might need to update your personal environment variables to make sure this is sourced properly at the start of a new session.
  - A working, compiled set of `riscv-tools` binaries (particularly the gcc libraries for RISC-V elf binaries, such as `riscv64-unknown-elf-gcc`)
  - The `env.sh` file that is generated after you build the `riscv-tools` within the Chipyard framework for the first time (through running the `build-setup.sh` script at the top level of the repo)
  - A compiled simulation binary (I happen to have used my verilator compiled binary for the sake of example), such as `simulator-chipyard.harness-LargeBoomV3Config`

## Currently Supported Benchmarks:<a id="currently-supported-benchmarks-"></a>
### Automotive <a id="automotive-"></a>
- [x] basicmath
- [x] bitcount
- [x] qsort
- [x] susan

### Consumer <a id="consumer-"></a>
- [x] jpeg
- [ ] lame
- [ ] mad
- [ ] tiff-data
- [ ] tiff-v3.5.4
- [ ] tiff2bw
- [ ] tiff2rgba
- [ ] tiffdither
- [ ] tiffmedian
- [ ] typeset

### Network <a id="network-"></a>
- [x] dijkstra
- [ ] patricia

### Office <a id="office-"></a>
- [ ] ghostscript
- [ ] ispell
- [ ] rsynth
- [ ] sphinx
- [x] stringsearch

### Security <a id="security-"></a>
- [ ] blowfish
- [ ] pgp
- [x] rijndael
- [x] sha

### Telecomm <a id="telecomm-"></a>
- [x] adpcm
- [x] CRC32
- [x] fft
- [ ] gsm