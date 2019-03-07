# Signature-Based-Scheduler

This document summarizes the on-going work to implement an application signature based process scheduler \[Add more details here\].

Following is a description of different folders in the base directory:

  - linux-4.8.13 contains the base linux source code and all the changes that we are making in the kernel.
  - gem5 contains the simulator we are using to test the changes in the linux kernel. The same simulator is
    to be used to configure and simulate different hardware platforms.
  - Benchmarks folder contains the applications and benchmarks run on linux kernel to examine the behavior of scheduler.
