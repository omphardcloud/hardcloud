#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <arpa/inet.h>

#define BYTES_IN_WORD 128

uint64_t rotr(uint64_t input, uint8_t amnt);
void doRound(uint64_t* input, uint8_t roundNumber, uint64_t word);
void getwtschedule(uint64_t *m, uint64_t *schedule);
void calculateHash(uint64_t blockcount, uint64_t* inputstring, uint64_t* buffers);
