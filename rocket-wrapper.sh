#!/usr/bin/env bash
set -x
$RTLCONFIG pk "$1" "${@:2}"
