#!/usr/bin/env bash

bms=`find microbenchmarks -type d -links 2 | cut -f2 -d'/'`

for bm in $bms
do 

args_file=microbenchmarks/$bm/arguments

while IFS= read -r line
do
args=$line
done <"$args_file"

        cp mica.conf microbenchmarks/$bm/
	cd microbenchmarks/$bm/  
	../../pin-3.4-97438-gf90d1f746-gcc-linux/pin -t ../../pin-3.4-97438-gf90d1f746-gcc-linux/mica.so -- ./$bm "$args"
        cd ../../ 
done

