#!/usr/bin/env bash
set -x
$RTLCONFIG --ust-trace "$1/$2.trace" pk "$2" "${@:3}"
