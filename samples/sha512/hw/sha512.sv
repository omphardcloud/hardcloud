// sha512.sv

import ccip_if_pkg::*;

module sha512
(
  input  logic         clk,
  input  logic         reset,
  input  logic [511:0] block,
  input  logic         block_valid,
  output logic [511:0] digest,
  output logic         digest_valid
);

  logic [1023:0] mem_block[2];

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      digest <= '0;
    end
    else begin
      for (int i = 0; i < 512; i++) begin
        digest[i] <= block[2*i +: 1];
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      digest_valid <= '0;
    end
    else begin
      digest_valid <= block_valid;
    end
  end

endmodule : sha512

