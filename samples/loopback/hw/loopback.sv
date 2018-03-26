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

  logic         data_valid;
  t_buffer_data data_out;

  loopback_fifo
  #(
    .LOOPBACK_FIFO_WIDTH(512),
    .LOOPBACK_FIFO_DEPTH(10)
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
    end
    else begin
      case (state)
      0: state <= (start) ? 1 : 0;
      1: begin buffer.read_stream(1, 512); state <= 2; end
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

  // dequeue data from fifo
  always@(posedge clk or posedge reset) begin
    if (reset) begin
      fifo_deq_en <= 1'b0;
      data_valid  <= 1'b0;
      data_out    <= '0;
    end
    else begin
      if (fifo_not_empty && !buffer.write_full()) begin
        fifo_deq_en <= 1'b1;
        data_valid  <= 1'b1;
        data_out    <= fifo_deq_data;
      end
      else begin
        fifo_deq_en <= 1'b0;
        data_valid  <= 1'b0;
      end
    end
  end

  // write resquest
  always@(posedge clk or posedge reset) begin
    if (reset) begin
      buffer.write_idle();
    end
    else begin
      if (data_valid && !buffer.write_full()) begin
        buffer.write_stream(0, data_out);
      end
      else begin
        buffer.write_idle();
      end
    end
  end

  // finish

endmodule : loopback

