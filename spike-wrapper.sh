#!/usr/bin/env bash
set -x
#time spike pk "$1" "${@:2}"
time perf stat -o spike_perf.txt -- spike pk "$1" "${@:2}" > filename
