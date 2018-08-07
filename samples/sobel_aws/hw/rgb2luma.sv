// rgb2luma.sv

module rgb2luma
(
  input  logic         clk,
  input  logic         rst_b,
  input  logic [511:0] data_in,
  input  logic         valid_in,
  output logic [127:0] data_out,
  output logic         valid_out
);

  always_ff@(posedge clk or negedge rst_b) begin
    if (!rst_b) begin
      valid_out <= 1'b0;
    end
    else begin
      valid_out <= valid_in;
    end
  end

  always_ff@(posedge clk or negedge rst_b) begin
    if (!rst_b) begin
      data_out <= '0;
    end
    else begin
      if (valid_in) begin
        for (int i = 0; i < 16; i++) begin
          data_out[8*i +: 8] <= func_rgb2luma(data_in[32*i +: 32]);
        end
      end
    end
  end

  function [7:0] func_rgb2luma;
    input  bit [31:0] data;

    begin
      return
        (data[7:0]   >> 2) + (data[7:0]   >> 5) +
        (data[15:8]  >> 1) + (data[15:8]  >> 4) +
        (data[23:16] >> 4) + (data[23:16] >> 5);
    end
  endfunction : func_rgb2luma

endmodule : rgb2luma

