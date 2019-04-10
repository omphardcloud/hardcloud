#include <stdio.h>
#include <stdlib.h>
#define CL 1024
#define NI 512*CL

int main(){
        int *A;
        int *B;

        A = (int*)malloc(NI*sizeof(int));
        B = (int*)malloc(NI*sizeof(int));
        printf("[HardCloud] running : Loopback Application\n\n");

        for (int i = 0; i < NI; i++)
        {
                A[i] = i;
                B[i] = 8;
        }

        printf("[HardCloud] offload : Loopback AFU simulation\n\n");

        #pragma omp target device(0) map(to: A[:NI]) map(from: B[:NI])
        #pragma omp parallel //for use(hrw) module(image_i)
        for (int i = 0; i < NI; i++){
                B[i] = A[i] + 1;
        }

        for(int i = 0; i < NI ; i++){
                if(B[i]!=A[i]+1){
                        printf("Test failed!\nB[%d] = %d", i, B[i]);
                        return 0;
                }
        }

        printf("[HardCloud] finish  : Loopback Application\n");

        return 0;
}


