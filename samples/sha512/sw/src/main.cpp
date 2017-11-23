#include <stdio.h>
#include <string.h>

#include "harp.h"
#include "sha512.h"

#define CL 64 // cache line - bytes

#define NI 30000000*CL/sizeof(uint64_t) // number of itens
#define NJ 1*CL/sizeof(uint64_t) // number of itens

void sha512(uint64_t* input, uint64_t size, uint64_t* output)
{
  uint64_t buffers[] = {
    0x6A09E667F3BCC908, 0xBB67AE8584CAA73B, 0x3C6EF372FE94F82B, 0xA54FF53A5F1D36F1,
    0x510E527FADE682D1, 0x9B05688C2B3E6C1F, 0x1F83D9ABFB41BD6B, 0x5BE0CD19137E2179
  };

  calculateHash(size, input, (uint64_t*) &buffers);

  for (int i = 0; i < 8; i++)
  {
    output[i] = buffers[7 - i];
  }
}

int main()
{
  uint64_t* input;
  uint64_t output[NJ];

  input = (uint64_t *) malloc (NI*sizeof(uint64_t));

  for (uint64_t i = 0; i < NI; i++)
  {
    input[i] = i;
  }

  #pragma omp target device(HARPSIM) map(to: input[:NI]) map(from: output)
  #pragma omp parallel use(hrw) module(sha512)
  {
    output[0] = input[0];

    sha512(input, NI/16, output);
  }

  printf("Final hash: ");
  for (int i = 0; i < 8; i++) {
    printf("%016llx",(unsigned long long) output[7 - i]);
  }
  printf("\n");

  return 0;
}

