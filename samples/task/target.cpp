#include <omp.h>
#include <stdio.h>
#define GPU0 0
#define GPU1 1
#define CPU 3
#define N 99
int main(){
    int A ;
    #pragma omp parallel
    #pragma omp single
    {
    	#pragma omp target device(GPU0) map(from:A)
			A = 10;
	
    	#pragma omp target device(GPU0) map(tofrom:A)
	    	A += 100 ;
    }
    printf("result:  %d\n", A);
}
