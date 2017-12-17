#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "harp.h"

#define CL 64 // cache line - bytes

#define NI 1000*CL/sizeof(uint8_t) // number of itens
#define NJ    1*CL/sizeof(uint8_t) // number of itens

int main()
{
  uint8_t* data_in;
  uint8_t* data_out;

  data_in  = (uint8_t *) malloc (NI*sizeof(uint8_t));
  data_out = (uint8_t *) malloc (NJ*sizeof(uint8_t));

  for (uint64_t i = 0; i < NI; i++)
  {
    data_in[i] = i%4;
  }

  #pragma omp target device(HARPSIM) map(to: data_in[:NI]) map(from: data_out[:NJ])
  #pragma omp parallel use(hrw) module(smith_waterman)
  {
    data_out[0] = data_in[0];
  }

  printf("data_out = %d\n", data_out[0]);

  free(data_in);
  free(data_out);

  return 0;
}

