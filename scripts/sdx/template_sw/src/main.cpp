#include <cstdint>
#include <iostream>

#include <stdio.h>

#define SIZE   512
#define ALVEO 9008

int main()
{
  uint64_t A[SIZE];
  uint64_t B[SIZE];

  std::cout << "[HardCloud] running : loopback application\n\n";

  // initialize
  for (uint64_t i = 0; i < SIZE; i++)
    A[i] = i;

  #pragma omp target device(ALVEO) implements(loopback) map(to: A) map(from: B)
  #pragma omp parallel for
  for (uint64_t i = 0; i < SIZE; i++)
    B[i] = A[i] << 2;

  // check data
  int error_cnt = 0;
  for (uint64_t i = 0; i < SIZE; i++)
  {
    if (i << 2 != B[i])
    {
      std::cout << A[i] << ", " << B[i] << std::endl;

      error_cnt++;
    }
  }

  std::cout << "[HardCloud] result  : ";
  if (0 == error_cnt)
    std::cout << "PASS\n\n";
  else
    std::cout << "FAIL\n\n";

  return 0;
}

