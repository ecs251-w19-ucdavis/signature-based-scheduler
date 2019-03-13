#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <string.h>
#include <cstdlib>
#include <vector>
#include <algorithm>
#include <cmath>
#include <pthread.h>
#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <string>
#include <unistd.h>
#include <time.h>
#include <linux/unistd.h>
#include <linux/kernel.h>
#include <linux/types.h>
#include <sys/syscall.h>

using namespace std;

#define gettid() syscall(__NR_gettid)

#define TEST_SCHED 4

 /* XXX use the proper syscall numbers */
 #ifdef __x86_64__
 #define __NR_sched_setattr     314
 #define __NR_sched_getattr     315
 #endif

 #ifdef __i386__
 #define __NR_sched_setattr     351
 #define __NR_sched_getattr     352
 #endif

 #ifdef __arm__
 #define __NR_sched_setattr     380
 #define __NR_sched_getattr     381
 #endif

 static volatile int done;

 struct sched_attr {
    __u32 size;

    __u32 sched_policy;
    __u64 sched_flags;

    /* SCHED_NORMAL, SCHED_BATCH */
    __s32 sched_nice;

    /* SCHED_FIFO, SCHED_RR */
    __u32 sched_priority;

    /* SCHED_DEADLINE (nsec) */
    __u64 sched_runtime;
    __u64 sched_deadline;
    __u64 sched_period;
 };

 int sched_setattr(pid_t pid,
          const struct sched_attr *attr,
          unsigned int flags)
 {
    return syscall(__NR_sched_setattr, pid, attr, flags);
 }

 int sched_getattr(pid_t pid,
          struct sched_attr *attr,
          unsigned int size,
          unsigned int flags)
 {
    return syscall(__NR_sched_getattr, pid, attr, size, flags);
 }


typedef struct __myarg_t{
    int thread_num;

    } myarg_t;

void *worker(void *args)
{
    myarg_t *m = (myarg_t *) args;
    printf("thread: ...\n");

    struct sched_attr attr;
    int x = 0;
    int ret;
    unsigned int flags = 0;

    printf("test_sched thread started [%ld]\n", gettid());

    attr.size = sizeof(attr);
    attr.sched_flags = m->thread_num;
    attr.sched_nice = 0;
    attr.sched_priority = 0;

    attr.sched_policy = TEST_SCHED;
    attr.sched_runtime = 0;
    attr.sched_period = attr.sched_deadline = 0;

    ret = sched_setattr(0, &attr, flags);
    if (ret < 0) {
        done = 0;
        perror("sched_setattr");
        exit(-1);
    }

    for(int i=0; i<10; i++)
        printf("thread:%d, %d \n",m->thread_num,i);
    printf("test_sched thread dies [%ld]\n", gettid());
    pthread_exit(0);
    return NULL;
}

int main(int argc, char* argv[]){
    myarg_t args;
    myarg_t args2;
    pthread_t tid1;
    pthread_t tid2;
    int rc;

    args.thread_num=1;
    rc = pthread_create(&tid1,NULL,worker,&args);
    if(rc != 0)
    printf("Could not create thread \n");
    args2.thread_num=2;
    rc = pthread_create(&tid2,NULL,worker,&args2);
    if(rc != 0)
    printf("Could not create thread \n");
    pthread_join(tid1, NULL);
    pthread_join(tid2, NULL);

    return 0;
}
