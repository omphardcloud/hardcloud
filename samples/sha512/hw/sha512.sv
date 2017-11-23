// sha512.sv

import ccip_if_pkg::*;

module sha512
(
  input  logic         clk,
  input  logic         reset,
  input  logic [511:0] block[2],
  input  logic         block_valid,
  output logic [511:0] digest,
  output logic         digest_valid,
  output logic         ready
);

  localparam [1:0] MODE_SHA_512 = 3;

  logic          init;
  logic          next;

  logic          first_time;

  assign init = block_valid && first_time;
  assign next = block_valid && !first_time;

  sha512_core uu_sha512_core
  (
    .clk             (clk),
    .reset_n         (!reset),
    .init            (init),
    .next            (next),
    .mode            (MODE_SHA_512),
    .work_factor     (),
    .work_factor_num (),
    .block           ({block[1], block[0]}),
    .ready           (ready),
    .digest          (digest),
    .digest_valid    (digest_valid)
  );

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      first_time <= 1'b1;
    end
    else begin
      if (block_valid) begin
        first_time <= 1'b0;
      end
    end
  end

endmodule : sha512

