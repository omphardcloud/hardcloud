#define BUFFER_SIZE 256
#define DATA_SIZE 4096

//TRIPCOUNT identifier
const unsigned int c_len = DATA_SIZE / BUFFER_SIZE;
const unsigned int c_size = BUFFER_SIZE;

/*
  Vector Addition Kernel Implementation
  Arguments:
    in1   (input)     --> Input Vector1
    in2   (input)     --> Input Vector2
    out_r (output)    --> Output Vector
    size  (input)     --> Size of Vector in Integer
*/

extern "C" {

void hardcloud_top(
  const unsigned int *in1, // Read-Only Vector 1
  const unsigned int *in2, // Read-Only Vector 2
  unsigned int *out_r,     // Output Result
  int size                 // Size in integer
) {
#pragma HLS INTERFACE m_axi port = in1 offset = slave bundle = gmem
#pragma HLS INTERFACE m_axi port = in2 offset = slave bundle = gmem
#pragma HLS INTERFACE m_axi port = out_r offset = slave bundle = gmem
#pragma HLS INTERFACE s_axilite port = in1 bundle = control
#pragma HLS INTERFACE s_axilite port = in2 bundle = control
#pragma HLS INTERFACE s_axilite port = out_r bundle = control
#pragma HLS INTERFACE s_axilite port = size bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

  unsigned int v1_buffer[BUFFER_SIZE];   // Local memory to store vector1

  //Per iteration of this loop perform BUFFER_SIZE vector addition
  for (int i = 0; i < size; i += BUFFER_SIZE) {
    #pragma HLS LOOP_TRIPCOUNT min=c_len max=c_len
    int chunk_size = BUFFER_SIZE;

    //boundary checks
    if ((i + BUFFER_SIZE) > size)
      chunk_size = size - i;

    read1: for (int j = 0; j < chunk_size; j++) {
      #pragma HLS LOOP_TRIPCOUNT min=c_size max=c_size
      #pragma HLS PIPELINE II=1
      v1_buffer[j] = in1[i + j];
    }

    //Burst reading B and calculating C and Burst writing
    // to  Global memory
    vadd_writeC: for (int j = 0; j < chunk_size; j++) {
      #pragma HLS LOOP_TRIPCOUNT min=c_size max=c_size
      #pragma HLS PIPELINE II=1
      //perform vector addition
      out_r[i+j] = v1_buffer[j] + in2[i+j];
    }
  }
}

}
