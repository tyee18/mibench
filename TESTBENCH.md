# Introduction
- TODO: write up a brief summary of why we chose MiBench over other tools, such as:
  - SpecCPU something (recommended but not exactly user-friendly, and might not have been free)
    - https://www.spec.org/cpu2017/
  - embench (not sure why this one didn't come up tbh)
    - https://github.com/embench/embench-iot
  - firesim (built into Chipyard framework, but requires FPGA hardware to run on)
- MiBench is probably the most port-able of the benchmarks to use
  - Easy to build / execute once you know the process
- How to measure performance?
  - Very rough idea: using `time` command when executing test, to determine execution time?
  - Which test(s) to pick? Probably some out of each suite just to see?

## MiBench Build Instructions / Prerequisites
### Prequisites:
- a working version of gcc, make
- MiBench benchmarks (recommended to fork from existing GitHub repository for neatness, such as https://github.com/pulp-platform/mibench)
- Don't forget to quote the original source of MiBench, from the University of Michigan at Ann Arbor (https://vhosts.eecs.umich.edu/mibench/)

### Instructions
- Each set of applications is compiled individually
  - By default, they are compiled using gcc (see each benchmark's default `Makefile` for further information)
- Instructions as follows (assumes Chipyard has already been built / established) to build and run benchmarks manually:
  1. From your MiBench repo, source the chipyard `env.sh` so that you have paths to the tools available
  1. Set your `CC` environment variable to whichever `gcc` library you plan on using for compatibility to your simulated design. In my case, I was running with a verilator simulator harness, on a Windows Subsystem for Linux (WSL), so I chose to use the `riscv64-unknown-elf-gcc`. So:
     1. In Bash: `export CC=~/chipyard/.conda-env/riscv-tools/bin/riscv64-unknown-elf-gcc`
  1. Compile whichever MiBench benchmark(s) you'd like to run with their default `Makefile`. Setting your cross-compiler (`CC`) variable ensures that the benchmarks are built to run with the Chipyard simulator.
  1. Call the executed binary to run whichever test(s) you desire. Example:
     1. `/path/to/your/simulator-chipyard.harness-LargeBoomV3Config pk ./basicmath_small`
        - Note that these runs take **HOURS**...currently working on getting timing estimates
        - Also note that the `pk` call is necessary for this to run properly...for reasons I don't quite understand yet.

## Chipyard RTL Build Instructions / Prerequisites
### Prerequisites:
- It is **HIGHLY** recommended to follow the Chipyard documentation in order to set up your environment for first-time use (https://chipyard.readthedocs.io/en/latest/index.html)
- At a minimum, you'll want to have the following available:
  - A working, compiled set of riscv-tools binaries (particularly the gcc libraries for RISCV-ELF binaries, such as `riscv64-unknown-elf-gcc`)
  - the `env.sh` file that is generated after you build the `riscv-tools` within the Chipyard framework for the first time (through running the `build-setup.sh` script at the top level of the repo)
  - A compiled simulation binary (I happen to have used my verilator compiled binary for the sake of example), such as `simulator-chipyard.harness-LargeBoomV3Config`