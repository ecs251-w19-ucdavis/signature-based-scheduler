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
using namespace std;

// A simple code to test FIFO scheduling on linux 

typedef struct __myarg_t{  //following the book example to pass arguments to the threads
	int thread_num;

	} myarg_t;

void *worker(void *args);



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

void *worker(void *args)
{
	myarg_t *m = (myarg_t *) args; 
    printf("thread: ...\n");
    
    for(int i=0; i<10; i++)
    printf("thread:%d, %d \n",m->thread_num,i);
    
    pthread_exit(0);
}
