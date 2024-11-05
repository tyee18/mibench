#!/usr/bin/env bash
set -x
time spike pk "$1" "${@:2}"
