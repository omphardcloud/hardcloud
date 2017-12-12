// md5.sv

module md5
(
  input  logic         clk,
  input  logic         reset,
  input  logic [511:0] data_in,
  input  logic         valid_in,
  output logic [127:0] data_out,
  output logic         valid_out
);

  Md5Core uu_md5_core
  (
    .clk       (clk),
    .reset     (reset),
    .wb        (data_in),
    .valid_in  (valid_in),
    .a0        ('h67452301), 
    .b0        ('hefcdab89), 
    .c0        ('h98badcfe), 
    .d0        ('h10325476),
    .a64       (data_out[0*32 +: 32]),
    .b64       (data_out[1*32 +: 32]),
    .c64       (data_out[2*32 +: 32]),
    .d64       (data_out[3*32 +: 32]),
    .valid_out (valid_out)
  );

endmodule : md5

