#!/usr/bin/env bash

# A script to run all the MiBench tests for an embedded target.

# Copyright 2012 Embecosm Limted

# Contributed by Jeremy Bennett <jeremy.bennett@embecosm.com>

# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 3 of the License, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.

# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 51
# Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.

# Currently supported options:
# automotive/basicmath
# automotive/bitcount
# automotive/qsort
# automotive/susan
# consumer/jpeg/jpeg-6a
# network/dijkstra
# office/stringsearch
# security/rjindael
# security/sha
# telecomm/adpcm
# telecomm/CRC32
# telecomm/fft

# The benchmarks to be run - multiple can be input to run in succession. E.g.,
# SRCDIRS="automotive/bitcount network/dijkstra telecomm/CRC32"
# NOTE: it is important here to specify the FULL PATH to the respective "run-all.sh" file.
# E.g., to run the JPEG test, SRCDIRS="consumer/jpeg/jpeg-6a"
SRCDIRS=""

CURRDIR=$(pwd)

# Check to see if the user has already sourced their Chipyard paths - a valid build space is needed for this
# TODO: Alternatively, for independence, save off a copy of the riscv64-unknown-elf-gcc binary here, as well as spike
if [ -z "$RISCV" ]; then
    # Source your personal Chipyard env here
    echo "Sourcing Chipyard env.sh for paths, sit tight..."
    # For now, this requires the user to copy their Chipyard-generated env.sh into the mibench kit.
    source env.sh
fi

# compiler
export CC="$RISCV/bin/riscv64-unknown-elf-gcc"

# verilator executable - this should be updated with the path to executable under test
export RTLCONFIG="$RISCV/../../sims/verilator/simulator-chipyard.harness-FastRocketConfig"

# this is only used for naming output files downstream
export RTLCONFIG_NAME="FastRocketConfig"

# user large or small tests
export MIBENCH_FAST=true

# whether we want tracing - currently not supported
export MIBENCH_TRACE=false

# command to run binaries
if [ "$MIBENCH_TRACE" = true ] ; then
    export RUNIT="rocket-wrapper-traces.sh $CURRDIR/traces"
else
    export RUNIT="rocket-wrapper.sh"
fi

# path passed to run scripts in directories
export MIBENCH_RUN="$CURRDIR/$RUNIT"

# Create an output directory for benchmark results if one doesn't exist
if [ ! -d $CURRDIR"/_Benchmark_Results" ] ; then
    echo "Creating benchmarks output directory..."
    mkdir $CURRDIR/"_Benchmark_Results"
fi

# Loop through all user-specified benchmarks
for d in ${SRCDIRS}
do
    echo ${d}
    cd ${d}
    timestamp=$(date +%Y_%m_%d_%H%M%S)
    benchmark=$(echo "$d" | sed 's/\//-/g')
    time perf stat -o $RTLCONFIG_NAME'_'$benchmark'_'$timestamp'.txt' -- ./run-all.sh > filename
    mv $RTLCONFIG_NAME* $CURRDIR"/_Benchmark_Results"
    cd ${CURRDIR}
done
