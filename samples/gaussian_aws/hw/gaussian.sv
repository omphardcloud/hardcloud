// gaussian.sv

module gaussian
(
  input  logic         clk,
  input  logic         reset,
  input  logic [511:0] data_in,
  input  logic         valid_in,
  output logic [511:0] data_out,
  output logic         valid_out
);

  logic [127:0] component_in[3];
  logic [127:0] component_out[3];

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      valid_out <= 1'b0;
    end
    else begin
      valid_out <= valid_in;
    end
  end

  always_comb begin
    for (int i = 0; i < 16; i++) begin
      component_in[0][8*i +: 8] = data_in[32*i      +: 8];
      component_in[1][8*i +: 8] = data_in[32*i +  8 +: 8];
      component_in[2][8*i +: 8] = data_in[32*i + 16 +: 8];
    end
  end

  always_comb begin
    for (int i = 0; i < 16; i++) begin
      data_out[32*i      +: 8] = component_out[0][8*i +: 8];
      data_out[32*i +  8 +: 8] = component_out[1][8*i +: 8];
      data_out[32*i + 16 +: 8] = component_out[2][8*i +: 8];
      data_out[32*i + 24 +: 8] = 8'h00;
    end
  end

  gaussian_unit uu_gaussian_r_unit
  (
    .clk       (clk),
    .rst_b     (!reset),
    .data_in   (component_in[0]),
    .valid_in  (valid_in),
    .data_out  (component_out[0])
  );

  gaussian_unit uu_gaussian_g_unit
  (
    .clk       (clk),
    .rst_b     (!reset),
    .data_in   (component_in[1]),
    .valid_in  (valid_in),
    .data_out  (component_out[1])
  );

  gaussian_unit uu_gaussian_b_unit
  (
    .clk       (clk),
    .rst_b     (!reset),
    .data_in   (component_in[2]),
    .valid_in  (valid_in),
    .data_out  (component_out[2])
  );

endmodule : gaussian

