// This is a generated file. Use and modify at your own risk.
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// kernel: hardcloud_top
//
// Purpose: This is a C-model of the RTL kernel intended to be used for cpu
//          emulation.  It is designed to only be functionally equivalent to
//          the RTL Kernel.
//-----------------------------------------------------------------------------
#define WORD_SIZE 32
#define SHORT_WORD_SIZE 16
#define CHAR_WORD_SIZE 8
// Transfer size and buffer size are in words.
#define TRANSFER_SIZE_BITS WORD_SIZE*4096*8
#define BUFFER_WORD_SIZE 8192
#include <string.h>
#include <stdbool.h>
#include "hls_half.h"
#include "ap_axi_sdata.h"
#include "hls_stream.h"


// Do not modify function declaration
extern "C" void hardcloud_top (
    unsigned int scalar00,
    unsigned int scalar01,
    int* axi00_ptr0,
    int* axi01_ptr0
) {

    #pragma HLS INTERFACE m_axi port=axi00_ptr0 offset=slave bundle=m00_axi
    #pragma HLS INTERFACE m_axi port=axi01_ptr0 offset=slave bundle=m01_axi
    #pragma HLS INTERFACE s_axilite port=scalar00 bundle=control
    #pragma HLS INTERFACE s_axilite port=scalar01 bundle=control
    #pragma HLS INTERFACE s_axilite port=axi00_ptr0 bundle=control
    #pragma HLS INTERFACE s_axilite port=axi01_ptr0 bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control

// Modify contents below to match the function of the RTL Kernel
    uint data;

    // Create input and output buffers for interface m00_axi
    int m00_axi_input_buffer[BUFFER_WORD_SIZE];
    int m00_axi_output_buffer[BUFFER_WORD_SIZE];


    // length is specified in number of words.
    unsigned int m00_axi_length = 4096;


    // Assign input to a buffer
    memcpy(m00_axi_input_buffer, (int*) axi00_ptr0, m00_axi_length*sizeof(int));

    // Add 1 to input buffer and assign to output buffer.
    for (uint i = 0; i < m00_axi_length; i++) {
      m00_axi_output_buffer[i] = m00_axi_input_buffer[i]  + 1;
    }

    // assign output buffer out to memory
    memcpy((int*) axi00_ptr0, m00_axi_output_buffer, m00_axi_length*sizeof(int));


    // Create input and output buffers for interface m01_axi
    int m01_axi_input_buffer[BUFFER_WORD_SIZE];
    int m01_axi_output_buffer[BUFFER_WORD_SIZE];


    // length is specified in number of words.
    unsigned int m01_axi_length = 4096;


    // Assign input to a buffer
    memcpy(m01_axi_input_buffer, (int*) axi01_ptr0, m01_axi_length*sizeof(int));

    // Add 1 to input buffer and assign to output buffer.
    for (uint i = 0; i < m01_axi_length; i++) {
      m01_axi_output_buffer[i] = m01_axi_input_buffer[i]  + 1;
    }

    // assign output buffer out to memory
    memcpy((int*) axi01_ptr0, m01_axi_output_buffer, m01_axi_length*sizeof(int));


}

