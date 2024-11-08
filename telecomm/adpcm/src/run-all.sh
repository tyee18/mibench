#!/usr/bin/env bash

make clean
make

timestamp=$(date +%Y_%m_%d_%H%M%S)

if [ "$MIBENCH_FAST" = true ] ; then
    ${MIBENCH_RUN} ../bin/rawcaudio < ../data/small.pcm > $RTLCONFIG_NAME'_'$timestamp'_output_small.adpcm'
    #${MIBENCH_RUN} ../bin/rawdaudio < ../data/small.adpcm > ../output_small.pcm

else
    ${MIBENCH_RUN} ../bin/rawcaudio < ../data/large.pcm > $RTLCONFIG_NAME'_'$timestamp'_output_large.adpcm'
    #${MIBENCH_RUN} ../bin/rawdaudio < ../data/large.adpcm > ../output_large.pcm

fi
