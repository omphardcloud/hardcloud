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
  #pragma omp parallel for use(hrw) module(loopback)
  for (int i = 0; i < NI; i++)
  {
    B[i] = A[i];
  }

  // check data
  int error_cnt = 0;
  for (int i = 0; i < NI; i++)
  {
    if (i != B[i])
    {
      std::cout << i << ", " << B[i] << std::endl;

      error_cnt++;
    }
  }

  std::cout << "[HardCloud] result  : ";

  if (0 == error_cnt)
    std::cout << "PASS\n\n";
  else
    std::cout << "FAIL\n\n";

  std::cout << "[HardCloud] finish  : Loopback Application\n";

  return 0;
}

