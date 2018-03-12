// loopback.sv

import hc_pkg::*;

module loopback
(
  input  logic  clk,
  input  logic  reset,
  input  logic  start,
  output logic  finish,
  hc_buffers_if buffers
);

  int state;

  // TODO(ciroceissler): implements loopback
  always@(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;

      buffers.read_idle();
      buffers.write_idle();

      for (int i = 0; i < HC_BUFFER_SIZE; i++) begin
        buffers.buffer_idle(i);
      end
    end
    else begin
      case (state)
        0:
          begin
            if (start) begin
              state <= 1;
            end
          end

        1:
          begin
            buffers.read_stream(0, t_request_cmd_size'(10));
            state <= 2;
          end

        2:
          begin
            buffers.read_idle();
          end
      endcase
    end
  end

endmodule : loopback

