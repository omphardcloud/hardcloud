/*
 * main.c
 *
 *  Created on: 6 de dez de 2017
 *  Author: ramon
 */

#include<stdio.h>
#include<stdlib.h>
//#include<time.h>
#define DEBUG 1

#define A 0
#define G 1
#define C 3
#define T 2
#define GEXT 4
#define GOPEN 12
#define STREAM 640
#define QUERY_LENGTH 16


int smith(int *a, int *b, int m, int n);

int main(int argc, char **argv) {
    //clock_t begin = clock();
  int *vetA;//={A,T,G,T,T,A,A,G,G,A};
  vetA = (int *)malloc(STREAM *sizeof(int));
  if(vetA==0)
  {
      printf("ERRO: memoria nao alocada com malloc\n");
         return 1;
     }


  int *vetB;//={T,G,T,T,A,A,G,G};
  vetB = (int *)malloc(QUERY_LENGTH *sizeof(int));
  if(vetB==0)
    {
        printf("ERRO: memoria nao alocada com malloc\n");
        return 1;
    }

  int i, biggest;
  for(i=0; i< QUERY_LENGTH; i++){
      vetB[i] = 0;
  }
  for(i = 0; i < STREAM; i++){
    vetA[i]=i%4;
  }
  biggest=smith(vetA, vetB, STREAM, QUERY_LENGTH);
    //clock_t end = clock();
    //double time_spent = (double)(end-begin)/ CLOCKS_PER_SEC;
    printf("%d\n", biggest);
  //printf("%d\n%lf\n", biggest,time_spent);

}

int max(int a, int b, int c, int d){
  int bigger;
  if(a>b)
    bigger=a;
  else
    bigger=b;

  if(bigger<c) bigger = c;

  if(bigger<d) bigger = d;

  if(bigger>0) return bigger;

  return 0;
}

int s(int a, int b){
  if(a==b) return 5;
  return -4;
}

int smith(int *a, int *b, int m, int n){
  int **M;
  int **I;

    M = (int**)malloc((STREAM+1)*sizeof(int*));
    if(M==0){
        printf("ERRO: memoria nao alocada com malloc\n");
        return 1;
    }

    for(int i=0; i< STREAM+1; i++){
        M[i] = (int*)malloc((QUERY_LENGTH+1)*sizeof(int));
        if(M[i]==0){
            printf("ERRO: memoria nao alocada com malloc\n");
            return 1;
        }
    }


    I = (int**)malloc((STREAM+1)*sizeof(int*));
    if(I==0){
        printf("ERRO: memoria nao alocada com malloc\n");
        return 1;
    }

    for(int i=0; i< STREAM+1; i++){
        I[i] = (int*)malloc((QUERY_LENGTH+1)*sizeof(int));
        if(I[i]==0){
            printf("ERRO: memoria nao alocada com malloc\n");
            return 1;
        }
    }


  int biggest = 0;

  for (int i = 0; i < n+1; ++i) {
    M[0][i]=-0;
    I[0][i]=-0;
  }
  for (int i = 0; i < m+1; ++i){
    M[i][0]=-0;
    I[i][0]=-0;
  }

  for (int i = 1; i < m+1; ++i) {
    for (int j = 1; j < n+1; ++j) {
      M[i][j] = max((M[i-1][j-1]+s(a[i-1],b[j-1])), (I[i-1][j-1]+s(a[i-1],b[j-1])), 0, 0);
      I[i][j] = max((M[i][j-1]-GOPEN), (I[i][j-1]-GEXT), (M[i-1][j]-GOPEN), (I[i-1][j]-GEXT));
      if(biggest < M[i][j]) biggest = M[i][j];
    }

  }
/*  printf("MATRIZ H\n\n");
  for(int i = 0; i < X+1; i++){
    for(int j = 0; j < QUERY_LENGTH+1; j++){
      printf("%d ", M[i][j]);
    }
    printf("\n");
  }

*/
/*  printf("\n\nMATRIZ I\n\n");
  for(int i = 0; i < X+1; i++){
    for(int j = 0; j < QUERY_LENGTH+1; j++){
      printf("%d ", I[i][j]);
    }
      printf("\n");
  }*/

  return biggest;
}



