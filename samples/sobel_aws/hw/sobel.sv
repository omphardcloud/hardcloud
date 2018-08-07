// sobel.sv

module sobel
(
  input  logic         clk,
  input  logic         reset,
  input  logic [511:0] data_in,
  input  logic         valid_in,
  output logic [511:0] data_out,
  output logic         valid_out
);

  logic [127:0] luma_data;
  logic         luma_valid;

  rgb2luma uu_rgb2luma
  (
    .clk       (clk),
    .rst_b     (!reset),
    .data_in   (data_in),
    .valid_in  (valid_in),
    .data_out  (luma_data),
    .valid_out (luma_valid)
  );

  sobel_unit uu_sobel_unit
  (
    .clk       (clk),
    .rst_b     (!reset),
    .data_in   (luma_data),
    .valid_in  (luma_valid),
    .data_out  (data_out),
    .valid_out (valid_out)
  );

endmodule : sobel

