// user.sv - user stub

import hc_pkg::*;

module hip
(
    input  logic  clk,
    input  logic  reset,
    input  logic  start,
    output logic  done,

    hif.master    buffer
);

  logic single_pulse;

  always_ff@(posedge clk) begin
    done <= (start & !single_pulse) ? 1'b1 : 1'b0;

    if (start)
      single_pulse <= 1'b1;

    if (reset)
      single_pulse <= 1'b0;
  end

  always_ff@(posedge clk) begin
    buffer.read_reset();
    buffer.write_reset();
  end

endmodule : hip

// taf!

