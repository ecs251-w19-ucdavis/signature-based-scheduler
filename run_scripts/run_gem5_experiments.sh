#!/usr/bin/env bash

cd benchmarks
bms=`find $1 -type d -links 2 | cut -f2 -d'/'`
echo $bms
cpus=( O3_Big O3_Small )

gem5_base=gem5/

cd ../$gem5_base

for bm in $bms
do
echo "running ....."
echo $bm
if test $1 = "micro"
then
    # Other categoris might not need an argument file
    args_file=../benchmarks/$1/$bm/arguments
    echo $args_file

    while IFS= read -r line
    do
    args=$line
    done <"$args_file"
fi

    for cpu in "${cpus[@]}"
    do
        
        build/X86/gem5.opt \
            -re --outdir=../results/gem5/$1/$bm/$cpu \
            ../configs/run.py \
                $cpu Inf ../benchmarks/$1/$bm/$bm "$args" &
    done
done

cd -

