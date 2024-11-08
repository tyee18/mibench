#!/usr/bin/env bash

make clean
make

timestamp=$(date +%Y_%m_%d_%H%M%S)

if [ "$MIBENCH_FAST" = true ] ; then
    touch $RTLCONFIG_NAME'_'$timestamp'_susan output_small.smoothing.pgm'
    ${MIBENCH_RUN} ./susan input_small.pgm $RTLCONFIG_NAME'_'$timestamp'_susan output_small.smoothing.pgm' -s > $RTLCONFIG_NAME'_'$timestamp'_susan_output_small.smoothing.txt'

    touch $RTLCONFIG_NAME'_'$timestamp'_susan output_small.edges.pgm'
    ${MIBENCH_RUN} ./susan input_small.pgm $RTLCONFIG_NAME'_'$timestamp'_susan_output_small.edges.pgm' -e > $RTLCONFIG_NAME'_'$timestamp'_susan_output_small.edges.txt'

    touch $RTLCONFIG_NAME'_'$timestamp'_susan output_small.corners.pgm'
    ${MIBENCH_RUN} ./susan input_small.pgm $RTLCONFIG_NAME'_'$timestamp'_susan_output_small.corners.pgm' -c > $RTLCONFIG_NAME'_'$timestamp'_susan_output_small.corners.txt'

else
    touch $RTLCONFIG_NAME'_'$timestamp'_susan output_large.smoothing.pgm'
    ${MIBENCH_RUN} ./susan input_large.pgm $RTLCONFIG_NAME'_'$timestamp'_susan_output_large.smoothing.pgm' -s > $RTLCONFIG_NAME'_'$timestamp'_susan_output_large.smoothing.txt'

    touch $RTLCONFIG_NAME'_'$timestamp'_susan output_small.edges.pgm'
    ${MIBENCH_RUN} ./susan input_large.pgm $RTLCONFIG_NAME'_'$timestamp'_susan_output_large.edges.pgm' -e > $RTLCONFIG_NAME'_'$timestamp'_susan_output_large.edges.txt'

    touch $RTLCONFIG_NAME'_'$timestamp'_susan output_small.corners.pgm'
    ${MIBENCH_RUN} ./susan input_large.pgm $RTLCONFIG_NAME'_'$timestamp'_susan output_large.corners.pgm' -c > $RTLCONFIG_NAME'_'$timestamp'_susan_output_large.corners.txt'
fi
