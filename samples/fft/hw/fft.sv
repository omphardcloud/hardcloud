// fft.sv

module fft
(
  input  logic         clk,
  input  logic         reset,
  input  logic [511:0] data_in,
  input  logic         next_in,
  output logic [511:0] data_out,
  output logic         next_out
);

  localparam int FFT_SIZE = 16;

  logic [31:0] X[FFT_SIZE];
  logic [31:0] Y[FFT_SIZE];

  always_comb begin
    for (int i = 0; i < FFT_SIZE; i++) begin
      X[i] = data_in[32*i +: 32];
    end
  end

  always_comb begin
    for (int i = 0; i < FFT_SIZE; i++) begin
      data_out[32*i +: 32] = Y[i];
    end
  end

  dft_top uu_top
  (
    .clk      (clk),
    .reset    (reset),
    .next     (next_in),
    .next_out (next_out),
    .X0       (X[0]),
    .X1       (X[1]),
    .X2       (X[2]),
    .X3       (X[3]),
    .X4       (X[4]),
    .X5       (X[5]),
    .X6       (X[6]),
    .X7       (X[7]),
    .X8       (X[8]),
    .X9       (X[9]),
    .X10      (X[10]),
    .X11      (X[11]),
    .X12      (X[12]),
    .X13      (X[13]),
    .X14      (X[14]),
    .X15      (X[15]),
    .Y0       (Y[0]),
    .Y1       (Y[1]),
    .Y2       (Y[2]),
    .Y3       (Y[3]),
    .Y4       (Y[4]),
    .Y5       (Y[5]),
    .Y6       (Y[6]),
    .Y7       (Y[7]),
    .Y8       (Y[8]),
    .Y9       (Y[9]),
    .Y10      (Y[10]),
    .Y11      (Y[11]),
    .Y12      (Y[12]),
    .Y13      (Y[13]),
    .Y14      (Y[14]),
    .Y15      (Y[15])
  );

endmodule : fft

