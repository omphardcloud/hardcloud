// loopback_stream.sv

import hc_pkg::*;

`define A 1
`define B 0

module loopback_stream
(
  input  logic  clk,
  input  logic  reset,
  input  logic  start,
  output logic  finish,
  hc_buffers_if buffer
);

  typedef enum logic {START, FINISH} t_loopback_state;

  t_loopback_state state;

  logic fifo_enq_en;
  logic fifo_deq_en;
  logic fifo_deq_en_q;
  logic fifo_empty;

  logic [10:0] count_write;

  t_buffer_data fifo_enq_data;
  t_buffer_data fifo_deq_data;
  t_buffer_data fifo_deq_data_q;

  loopback_fifo
  #(
    .LOOPBACK_FIFO_WIDTH(512),
    .LOOPBACK_FIFO_DEPTH(512)
  )
  uu_loopback_fifo
  (
    .clk          (clk),
    .reset        (reset),
    .enq_data     (fifo_enq_data),
    .enq_en       (fifo_enq_en),
    .deq_data     (fifo_deq_data),
    .deq_en       (fifo_deq_en),
    .empty        (fifo_empty),
    .full         (),
    .counter      (),
    .dec_counter  ()
  );

  //
  // read request
  //
  function void read_start();
    if (start) begin
      buffer.read_stream(`A, 512);

      state <= FINISH;
    end
  endfunction : read_start

  function void read_finish();
    buffer.read_idle();
  endfunction : read_finish

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      buffer.read_idle();

      state <= START;
    end
    else begin
      case (state)
      START  : read_start();
      FINISH : read_finish();
      endcase
    end
  end

  //
  // read response
  //
  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      fifo_enq_en   <= 1'b0;
      fifo_enq_data <= '0;
    end
    else begin
      fifo_enq_en   <= (buffer.valid()) ? 1'b1 : 1'b0;
      fifo_enq_data <= buffer.data();
    end
  end

  //
  // write request
  //
  always_comb begin
    fifo_deq_en = !fifo_empty && !buffer.write_fifo_is_full();
  end

  always_ff@(posedge clk or posedge reset) begin
    fifo_deq_en_q   <= (reset) ? 1'b0 : fifo_deq_en;
    fifo_deq_data_q <= (reset) ? '0   : fifo_deq_data;
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      buffer.write_idle();
    end
    else begin
      buffer.write_stream(`B, fifo_deq_data_q);

      if (!fifo_deq_en_q) begin
        buffer.write_idle();
      end
    end
  end

  //
  // finish
  //
  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      finish      <= '0;
      count_write <= '0;
    end
    else begin
      finish      <= (count_write >= buffer.size(0)) && (FINISH == state);
      count_write <= count_write + fifo_deq_en_q;
    end
  end

endmodule : loopback_stream

// taf!
