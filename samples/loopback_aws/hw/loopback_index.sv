// loopback_index.sv

import hc_pkg::*;

module loopback_index
(
  input  logic  clk,
  input  logic  reset,
  input  logic  start,
  output logic  finish,
  hc_buffers_if buffer
);

  typedef enum logic [1:0] {START, RUN, FINISH} t_loopback_rd_state;

  t_loopback_rd_state rd_state;
  t_loopback_rd_state wr_state;

  logic fifo_enq_en;
  logic fifo_deq_en;
  logic fifo_deq_en_q;
  logic fifo_empty;

  logic [10:0] read_offset;
  logic [10:0] write_offset;
  logic [10:0] write_count;

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
      read_offset <= buffer.size(1) - 1;

      rd_state <= RUN;
    end
  endfunction : read_start

  function void read_request();
    buffer.read_indexed(1, read_offset);

    if (buffer.read_full()) begin
      buffer.read_idle();
    end
    else begin
      read_offset <= read_offset - 1;
    end

    if (0 == read_offset) begin
      rd_state <= FINISH;
    end
  endfunction : read_request

  function void read_finish();
    buffer.read_idle();
  endfunction : read_finish

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      buffer.read_idle();

      rd_state <= START;
    end
    else begin
      case (rd_state)
      START  : read_start();
      RUN    : read_request();
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
    fifo_deq_en = !fifo_empty && !buffer.write_fifo_is_full() && wr_state == RUN;
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
      buffer.write_indexed(0, write_offset, fifo_deq_data_q);

      if (!fifo_deq_en_q) begin
        buffer.write_idle();
      end
    end
  end

  function void write_start();
    if (start) begin
      write_offset <= buffer.size(0) - 1;

      wr_state <= RUN;
    end
  endfunction : write_start

  function void write_request();
    if (fifo_deq_en_q) begin
      write_offset <= write_offset - 1;
    end

    if ('0 == write_offset) begin
      wr_state <= FINISH;
    end
  endfunction : write_request

  function void write_finish();
    buffer.write_idle();

    finish <= 1'b1;
  endfunction : write_finish

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      finish       <= '0;
      write_offset <= '0;
      wr_state     <= START;
    end
    else begin
      case (wr_state)
      START  : write_start();
      RUN    : write_request();
      FINISH : write_finish();
      endcase
    end
  end

endmodule : loopback_index

// taf!
