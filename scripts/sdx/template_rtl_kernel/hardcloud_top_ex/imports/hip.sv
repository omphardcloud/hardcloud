// hip.sv - user stub

import hc_pkg::*;

module hip
(
  input  logic  clk,
  input  logic  reset,
  input  logic  start,
  output logic  done,

  hif.master    buffer
);

  logic [511:0] data;
  logic [ 31:0] state;
  logic [ 63:0] offset;
  logic [ 31:0] counter;

  always_ff@(posedge clk) begin
    bit accept;

    done <= 1'b0;

    buffer.read_reset();
    buffer.write_reset();

    case (state)
      0: begin
        if (start)
          state <= 1;
      end

      1: begin
        accept = buffer.read_addr(0, offset, 1);

        if (accept)
          state <= 2;
      end

      2: begin
        accept = buffer.read_data(data);

        if (accept)
          state <= 3;
      end

      3: begin
        accept = buffer.write_addr(1, offset, 1);

        if (accept)
          state <= 4;
      end

      4: begin
        accept = buffer.write_data(data << 2);

        if (accept) begin
          offset  <= offset + 1;
          counter <= counter + 1;

          state <= 5;
        end
      end

      5: begin
        state <= 1;

        if (counter == buffer.read_size(0)) begin
          done <= 1'b1;

          state <= 6;
        end
      end

    endcase

    if (reset) begin
      state   <= 32'd0;
      offset  <= 64'd0;
      counter <= 32'd0;

      done <= 1'b0;

      buffer.read_reset();
      buffer.write_reset();
    end
  end

endmodule : hip

// taf!

