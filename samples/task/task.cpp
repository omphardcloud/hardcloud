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
    	#pragma omp task depend(out: A)
			A = 10;
	
    	#pragma omp task depend(in: A)
	    	A += 100 ;
    }
    printf("result:  %d\n", A);
}
