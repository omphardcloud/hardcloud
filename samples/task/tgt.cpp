#include <omp.h>
#include <stdio.h>
#define GPU0 0
#define GPU1 1
#define CPU 3
#define N 999
int main(){
    int A[2] = {1,2};
    omp_set_num_threads(4);
    #pragma omp parallel
    {
    printf("I am thread %d.\n", omp_get_thread_num());
    #pragma omp single
    {
    	#pragma omp target device(CPU) depend(out: A[:2]) map(tofrom:A[:2]) nowait
	    
	{
		for(int i = 0; i < N; i++)
			for(int j = 0; j < N; j++)
			  A[0] = 10;
			  A[1] = 10;
	}
	
    	#pragma omp target device(GPU0) depend(in: A[:2]) map(tofrom: A[:2]) nowait
	{
		A[0] += 100 ;
		A[1] += 100 ;
	}
	printf("\n\nNumber of threads %d\n\n", omp_get_num_threads());
    }
    }
    printf("result:  %d %d\n", A[0], A[1]);
}
