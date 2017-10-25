#include <iostream>
#include "harp.h"

#define CL 1                 // cache line - bytes
#define NI 64*CL/sizeof(int) // number of itens

int main()
{
  int A[NI];
  int B[NI];
  int C[NI];
  int D[NI];
  int E[NI];
  int F[NI];
  int G[NI];
  int H[NI];

  for (int i = 0; i < NI; i++)
  {
    A[i] = i + 100;
    B[i] = i + 200;
    C[i] = i + 300;
    D[i] = i + 400;
  }

  #pragma omp target device(HARPSIM) map(to: A, B, C, D) map(from: E, F, G, H)
  #pragma omp parallel for use(hrw) module(basic)
  for (int i = 0; i < NI; i++)
  {
    E[0] = A[0];
    F[0] = B[0];
    G[0] = C[0];
    H[0] = D[0];
  }

  for (int i = 0; i < NI; i++)
  {
    std::cout << " idx = " << i << " : ";
    std::cout << E[i] << " | ";
    std::cout << F[i] << " | ";
    std::cout << G[i] << " | ";
    std::cout << H[i] << "\n";
  }

  return 0;
}

