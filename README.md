# Signature-Based-Scheduler

This document summarizes the our work to implement an application signature based process scheduler.  

Following is a description of different folders in the base directory:

  - linux-4.8.13 contains the base linux source code and all the changes that we have made in the kernel.
  - gem5 contains the simulator we are using to test the changes in the linux kernel. The same simulator is 
    to be used to configure and simulate different hardware platforms and evaluate performance of benchmarks. 
  - gem5\_configurations contains different simulator configurations used to do this study.
  - run\_scripts has a few bash scripts/commands used to run experiments.
  - Benchmarks folder contains the applications and benchmarks run on linux kernel to examine the behavior of scheduler.
  - Results directory contains the benchmark profiling results alongwith gem5 results.   
