#include <stdio.h>
#define GPU 4
#define CPU 0
#define N 9999
#include "omp.h"
int main(){
    int A[3];
    omp_set_num_threads(2);
    printf("\n\nNUMBER OF DEVICES: %d\n\n\n", omp_get_num_devices());
    #pragma omp parallel
    #pragma omp single
    {
    	#pragma omp target device(CPU) depend(out: A[:3]) map(tofrom:A[:3]) nowait
        for(int i = 0; i < N; i++)
        for(int j = 0; j < N; j++)
            A[0] = 888;
        #pragma omp target device(GPU) depend(in: A[:3]) map(tofrom: A[:3]) nowait
            A[0] +=777;  
    }
    printf("result:  %d \n", A[0]);
}
