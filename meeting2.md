### What we did this week?
1. We completed setting up test scheduler and performed tests using multi-threaded application. We observed the following results:

![Normal Scheduler](https://user-images.githubusercontent.com/8845039/53542959-aa3bc680-3ad5-11e9-9655-f490980c564d.jpeg)
Completely Fair Scheduler: It is observed that the two threads acquire CPU interchangable.

![Custom made FIFO Scheduler](https://user-images.githubusercontent.com/8845039/53542902-6c3ea280-3ad5-11e9-88ec-54654e5ccbe8.jpeg)

Custom FIFO Scheduler: It is observed that the threads follow FIFO during execution.


2. We completed test profiling some applications to make the project transition to phase 2 smoothly and here are some results   for some benchmarks:
   [Link](https://github.com/ecs251-w19-ucdavis/signature-based-scheduler/tree/master/Results/spec-benchmarks)
   
    The benchmarks show diverse behavior e.g. xalancbmk has half the amount of instruction-level parallelism compared to bzip
     so smart scheduling would help to exploit this information in heterogeneous systems. Further analysis is underway.

### What are we doing next Week?
  - Set up more heterogeneous configurations in the simulator (especially memory side) to do smart sheduling of applications       across workloads.
  - Modify scheduler to schedule workloads using application information that we have obtained from profiling.
  - Try to come up with a general methodology.
  
