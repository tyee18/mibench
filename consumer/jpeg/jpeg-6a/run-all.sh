#!/usr/bin/env bash

./configure
make clean
make

timestamp=$(date +%Y_%m_%d_%H%M%S)

if [ "$MIBENCH_FAST" = true ] ; then
    ${MIBENCH_RUN} cjpeg -dct int -progressive -opt ../input_small.ppm > $RTLCONFIG_NAME'_'$timestamp'_jpeg-6a_output_small_encode.jpeg'
    ${MIBENCH_RUN} djpeg -dct int -ppm  ../input_small.jpg > $RTLCONFIG_NAME'_'$timestamp'_output_small_decode.ppm'

else
    ${MIBENCH_RUN} cjpeg -dct int -progressive -opt ../input_large.ppm > $RTLCONFIG_NAME'_'$timestamp'_jpeg-6a_output_large_encode.jpeg'
    ${MIBENCH_RUN} djpeg -dct int -ppm ../input_large.jpg > $RTLCONFIG_NAME'_'$timestamp'_output_large_decode.ppm'
fi
