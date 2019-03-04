#include <omp.h>
#include <stdio.h>
#include <iostream>
#define GPU0 0
#define GPU1 1
#define CPU 3
#define N 99

int G = 10;

int main(){
    int A[2] = {1,2};
    int L = 11;
    omp_set_num_threads(4);
//    std::cin >> G;
//    std::cin >> L;
    #pragma omp parallel
    {
    printf("I am thread %d.\n", omp_get_thread_num());
    #pragma omp single
    {
    	#pragma omp target device(GPU0) depend(out: A[:2]) map(tofrom:A[:2]) nowait
	    
	{
		for(int i = 0; i < N; i++)
			for(int j = 0; j < N; j++)
			  A[0] = 10;
			  A[1] = 10;
//		printf("GPU ver valor de G = %d\n", G);
//		printf("CPU ver valor de L = %d\n", L);
//		G = 5;
//		L = 4;
	}
	
    	#pragma omp target device(GPU0) depend(in: A[:2]) map(tofrom: A[:2]) nowait
	{
		A[0] += 100 ;
		A[1] += 100 ;
//		printf("GPU ver valor de G = %d\n", G);
//		printf("CPU ver valor de L = %d\n", L);
	}
	printf("\n\nNumber of threads %d\n\n", omp_get_num_threads());
    }
    }
    printf("result:  %d %d\n", A[0], A[1]);
}
