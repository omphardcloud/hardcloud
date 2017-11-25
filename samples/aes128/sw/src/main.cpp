#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "harp.h"
#include "aes.h"

#define CL 64 // cache line - bytes

#define NUM_WORDS 2*CL/sizeof(uint64_t) // number of itens

void aes128(const uint64_t* key, const uint64_t* pt, uint64_t* ct, uint64_t size)
{
  uint8_t roundkeys[AES_ROUND_KEY_SIZE];

  aes_key_schedule_128((uint8_t*) key, roundkeys);

  for (uint64_t i = 0; i < size; i++) {
    aes_encrypt_128(roundkeys, (uint8_t *) pt + 16*i, (uint8_t *) ct + 16*i);
  }
}

void debug(uint64_t* key, uint64_t* pt)
{
  for (int i = 0; i < 8; i++)
  {
    key[i] = 0;
  }

  pt[1] = 0xf34481ec3cc627ba;
  pt[0] = 0xcd5dc3fb08f273e6;

  pt[3] = 0x9798c4640bad75c7;
  pt[2] = 0xc3227db910174e72;

  pt[5] = 0x96ab5c2ff612d9df;
  pt[4] = 0xaae8c31f30c42168;

  pt[7] = 0x6a118a874519e64e;
  pt[6] = 0x9963798a503f1d35;

  pt[9] = 0xcb9fceec81286ca3;
  pt[8] = 0xe989bd979b0cb284;

  pt[11] = 0xb26aeb1874e47ca8;
  pt[10] = 0x358ff22378f09144;

  pt[13] = 0x58c8e00b2631686d;
  pt[12] = 0x54eab84b91f0aca1;

  pt[15] = 0x0000000000000000;
  pt[14] = 0x0000000000000000;
}

int main()
{
  uint64_t key[8];
  uint64_t* pt;
  uint64_t* ct;

  pt = (uint64_t *) malloc (NUM_WORDS*sizeof(uint64_t));
  ct = (uint64_t *) malloc (NUM_WORDS*sizeof(uint64_t));

  for (uint64_t i = 0; i < 8; i++)
  {
    key[i] = rand();
  }

  for (uint64_t i = 0; i < NUM_WORDS; i++)
  {
    pt[i] = rand();
  }

  #pragma omp target device(HARPSIM) map(to: key, pt) map(from: ct)
  #pragma omp parallel use(hrw) module(aes128)
  {
    ct[0] = key[0];
    ct[0] = pt[0];

    aes128(key, pt, ct, NUM_WORDS/2);
  }

  for (uint64_t i = 0; i < NUM_WORDS; i += 2)
  {
    printf("ct[%lu] = %016lx%016lx\n", i/2, ct[i + 1], ct[i]);
  }

  printf("\n");

  free(pt);
  free(ct);

  return 0;
}

