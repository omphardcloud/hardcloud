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
  int size;
  int idx;

  // TODO(ciroceissler): implements loopback
  always@(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;

      size <= 100;

      idx <= 0;

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
            if (!buffers.read_full()) begin
              $display("lpbk: read idx = %d", idx);
              buffers.read_indexed(1, t_request_cmd_offset'(idx));
              idx++;
            end
            else begin
              buffers.read_idle();
            end

            if ((idx + 1) > size) begin
              state <= 2;
            end
          end

        2:
          begin
            buffers.read_idle();

            if (buffers.buffer_size(1) == 10) begin
              finish <= 1'b1;
            end
          end

      endcase
    end
  end

endmodule : loopback

