#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "harp.h"
#include "md5.h"

#define CL 64 // cache line - bytes

#define NI 4*CL/sizeof(char) // number of itens
#define NJ 1*CL/sizeof(char) // number of itens

int main()
{
  char* data_in;
  char* data_out;

  data_in  = (char *) malloc (NI*sizeof(char));
  data_out = (char *) malloc (NJ*sizeof(char));

  for (uint64_t i = 0; i < NI; i++)
  {
    data_in[i] = 0;
  }

  #pragma omp target device(HARPSIM) map(to: data_in[:NI]) map(from: data_out[:NJ])
  #pragma omp parallel for use(hrw) module(md5)
  for (uint64_t i = 0; i < NI; i += 64)
  {
    data_out[0] = data_in[0];

    md5((const char*) data_in + 64*i, 64, (char *) data_out + 16*i);
  }

  for (uint64_t i = 0; i < NJ; i += 2) {
    printf("md5[%02lu] = %02x%02x\n", i/2, data_out[i + 1] & 0xff, data_out[i + 0] & 0xff);
  }

  printf("\n");

  free(data_in);
  free(data_out);

  return 0;
}

