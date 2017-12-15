#ifndef MD5_H
#define MD5_H

#define HASHSIZE 16
#define WORD 32
#define MASK 0xFFFFFFFF

#include <stdint.h>
#include <string.h>

typedef uint32_t WORD32;

/**
*  md5 hash function.
*  @param message: aribtary string.
*  @param len: message length.
*  @param output: buffer to receive the hash value. Its size must be
*  (at least) HASHSIZE.
*/
void md5 (const WORD32 *message, long len, WORD32 *output);

#endif // MD5_H
