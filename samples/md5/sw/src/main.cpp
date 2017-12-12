#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "harp.h"
#include "md5.h"

#define CL 64 // cache line - bytes

#define NI 40*CL/sizeof(uint32_t) // number of itens
#define NJ 10*CL/sizeof(uint32_t) // number of itens

int main()
{
  uint32_t* data_in;
  uint32_t* data_out;

  data_in  = (uint32_t *) malloc (NI*sizeof(uint32_t));
  data_out = (uint32_t *) malloc (NJ*sizeof(uint32_t));

  for (uint64_t i = 0; i < NI; i++)
  {
    data_in[i] = i;
  }

  #pragma omp target device(HARPSIM) map(to: data_in[:NI]) map(from: data_out[:NJ])
  #pragma omp parallel for use(hrw) module(md5)
  for (uint64_t i = 0; i < NI; i += 16)
  {
    data_out[i/4] = data_in[i];

    md5((const uint32_t*) data_in + i, 64, (uint32_t *) data_out + i/4);
  }

  for (uint64_t i = 0; i < NJ; i += 4) {
    printf("md5[%02lu] = %08x %08x %08x %08x\n", i/4, 
        data_out[i + 3] & 0xff, 
        data_out[i + 2] & 0xff, 
        data_out[i + 1] & 0xff, 
        data_out[i + 0] & 0xff);
  }

  printf("\n");

  free(data_in);
  free(data_out);

  return 0;
}

