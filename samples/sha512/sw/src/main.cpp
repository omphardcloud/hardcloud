#include <iostream>
#include "harp.h"

#define CL 64               // cache line - bytes

#define NI 18000*CL/sizeof(int) // number of itens
#define NJ  9000*CL/sizeof(int) // number of itens

int main()
{
  int A[NI];
  int B[NJ];

  for (int i = 0; i < NI; i++)
  {
    A[i] = i;
  }

  #pragma omp target device(HARPSIM) map(to: A) map(from: B)
  #pragma omp parallel for use(hrw) module(sha512)
  for (int i = 0; i < NJ; i++)
  {
    B[0] = A[0];
  }

  for (int i = 0; i < NJ; i++)
  {
    std::cout << " idx = " << i << " : ";
    std::cout << B[i] << "\n";
  }

  return 0;
}

