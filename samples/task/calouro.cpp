#include <omp.h>
#include <stdio.h>
#define GPU0 0
#define CPU 1
#define N 9999
int main(){
    int A = 1;
    //omp_set_num_threads(2);
    #pragma omp parallel
    #pragma omp single
    {
    	#pragma omp task depend(in: A)
        printf("Primeiro valor de A=%d",A);
        #pragma omp task depend(out: A)
        {
            printf("Secundo valor de A=%d",A);
            A =3;
        }
    }

}
