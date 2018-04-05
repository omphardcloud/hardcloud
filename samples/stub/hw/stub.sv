// stub.sv

import hc_pkg::*;

module stub 
(
  input  logic  clk,
  input  logic  reset,
  input  logic  start,
  output logic  finish,
  hc_buffers_if buffer
);

  assign finish = 1'b1;

endmodule : stub

// taf!
