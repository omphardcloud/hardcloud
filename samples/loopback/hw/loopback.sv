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

  logic [1:0] state;

  logic fifo_enq_en;
  logic fifo_deq_en;
  logic fifo_not_empty;
  logic fifo_not_full;

  t_request_size fifo_counter;

  t_buffer_data fifo_enq_data;
  t_buffer_data fifo_deq_data;

  loopback_fifo
  #(
    .LOOPBACK_FIFO_WIDTH(512),
    .LOOPBACK_FIFO_DEPTH(30)
  )
  uu_loopback_fifo
  (
    .clk          (clk),
    .reset        (reset),
    .enq_data     (fifo_enq_data),
    .enq_en       (fifo_enq_en),
    .not_full     (fifo_not_full),
    .deq_data     (fifo_deq_data),
    .deq_en       (fifo_deq_en),
    .not_empty    (fifo_not_empty),
    .counter      (fifo_counter),
    .dec_counter  ()
  );

  // read request
  always@(posedge clk or posedge reset) begin
    if (reset) begin
      state <= '0;

      buffer.read_idle();
      buffer.write_idle();
    end
    else begin
      case (state)
      0: state <= (start) ? 1 : 0;
      1: begin buffer.read_stream(1, 30); state <= 2; end
      2: buffer.read_idle();
      endcase
    end
  end

  // read response
  always@(posedge clk or posedge reset) begin
    if (reset) begin
      fifo_enq_en <= 1'b0;
    end
    else begin
      if (buffer.valid()) begin
        fifo_enq_en   <= 1'b1;
        fifo_enq_data <= buffer.data();
      end
      else begin
        fifo_enq_en <= 1'b0;
      end
    end
  end

  // write resquest
  always@(posedge clk or posedge reset) begin
    if (reset) begin
      fifo_deq_en <= 1'b0;

      buffer.write_idle();
    end
    else begin
      if (fifo_not_empty && !buffer.write_full()) begin
        fifo_deq_en <= 1'b1;

        buffer.write_stream(0, fifo_deq_data);
      end
      else begin
        fifo_deq_en <= 1'b0;

        buffer.write_idle();
      end
    end
  end

  // finish

endmodule : loopback

