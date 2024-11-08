#!/usr/bin/env bash

make clean
make
# TODO: we only encode

timestamp=$(date +%Y_%m_%d_%H%M%S)

if [ "$MIBENCH_FAST" = true ] ; then
    touch $RTLCONFIG_NAME'_'$timestamp'_rijndael_output_small.enc'
    ${MIBENCH_RUN} ./rijndael input_small.asc $RTLCONFIG_NAME'_'$timestamp'_rijndael_output_small.enc' e \
           1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321
    # ${MIBENCH_RUN} rijndael output_small.enc output_small.dec d \
    # 	       1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321
else
    touch $RTLCONFIG_NAME'_'$timestamp'_rijndael_output_large.enc'
    ${MIBENCH_RUN} ./rijndael input_large.asc $RTLCONFIG_NAME'_'$timestamp'_rijndael_output_large.enc' e \
		   1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321
    # ${MIBENCH_RUN} rijndael output_large.enc output_large.dec d \
    # 		   1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321
fi
