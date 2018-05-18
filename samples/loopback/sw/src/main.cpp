#include <iostream>
#include "harp.h"

#define CL 64                 // cache line - bytes
#define NI 512*CL/sizeof(int) // number of itens

int main()
{
  int A[NI];
  int B[NI];

  std::cout << "[HardCloud] running : Loopback Application\n\n";

  // initialize
  for (int i = 0; i < NI; i++)
  {
    A[i] = i;
  }

  std::cout << "[HardCloud] offload : Loopback AFU simulation\n\n";

  #pragma omp target device(HARPSIM) map(to: A) map(from: B)
  #pragma omp parallel for use(hrw) module(loopback) check
  for (int i = 0; i < NI; i++)
  {
    B[i] = A[i];
  }

  std::cout << "[HardCloud] finish  : Loopback Application\n";

  return 0;
}

