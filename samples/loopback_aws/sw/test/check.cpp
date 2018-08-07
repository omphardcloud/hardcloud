#include <stdio.h>
#include <cstring>

extern "C" {
  void __rtl_compare_variable(void* host_ptr, void* tgt_ptr, size_t size) {
    printf("\nuser <check> implementation\n");

    if (0 == memcmp(host_ptr, tgt_ptr, size))
      printf("user PASS!\n");
    else
      printf("user FAIL!\n");
  }
}

