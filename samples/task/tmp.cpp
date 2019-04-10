#include <omp.h>
#include <stdio.h>
#define GPU 1
#define CPU 0
#define N 9999
int main(){
    int A;
    omp_set_num_threads(2);
    printf("\n\nNUMBER OF DEVICES: %d\n\n\n", omp_get_num_devices());
    #pragma omp parallel
    #pragma omp single
    {
    	#pragma omp target device(CPU) depend(out: A) map(tofrom:A) nowait
        for(int i = 0; i < N; i++)
        for(int j = 0; j < N; j++)
            A = 888;
        #pragma omp target device(GPU) depend(in: A) map(tofrom: A) nowait
            A +=777;  
    }
    printf("result:  %d \n", A);
}
