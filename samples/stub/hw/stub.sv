// stub.sv

module stub 
(
  input  logic  clk,
  input  logic  reset,
  input  logic  start,
  output logic  finish,
  hc_buffers_if buffer
);

  assign finish = (start) ? 1'b1 : 1'b0;

endmodule : stub

// taf!
