// loopback.sv

import hc_pkg::*;

module loopback
(
  input  logic  clk,
  input  logic  reset,
  input  logic  start,
  output logic  finish,
  hc_buffers_if buffer
);

  int state;
  int size;
  int idx;

  task read_indexed();
    if (!buffer.read_full()) begin
      buffer.read_indexed(1, t_request_cmd_offset'(idx));
      idx++;
    end
    else begin
      buffer.read_idle();
    end

    if ((idx + 1) > size) begin
      state <= 3;
    end
  endtask : read_indexed

  always@(posedge clk or posedge reset) begin
    if (reset) begin
      idx   <= 0;
      state <= 0;
      size  <= 1000;

      buffer.read_idle();
      buffer.write_idle();
    end
    else begin
      case (state)
      0: state <= (start) ? 1 : 0;

`ifdef LPBK_INDEXED
      1: read_indexed();
`else
      1: begin buffer.read_stream(1, 10); state <= 3; end
      // 2: begin buffer.read_stream(1, 500); state <= 3; end
`endif // LPBK_INDEXED

      3: buffer.read_idle();
      endcase
    end
  end

  int cnt;
  t_request_cmd_offset write_offset;

  always@(posedge clk or posedge reset) begin
    if (reset) begin
      cnt          <= '0;
      write_offset <= '0;
    end
    else begin
      if (buffer.valid()) begin
        $display("lpbk read: %d | %h", cnt, buffer.data());
        cnt <= cnt + 1;

`ifdef LPBK_INDEXED
        buffer.write_indexed(0, write_offset, buffer.data());
`else
        buffer.write_stream(0, buffer.data());
`endif // LPBK_INDEXED

        write_offset <= t_request_cmd_offset'(write_offset + 1);
      end
      else begin
        buffer.write_idle();
      end

      if (cnt == 999) begin
        finish <= 1'b1;
      end
    end
  end

endmodule : loopback

