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

  typedef enum logic [1:0] {
    START,
    READ,
    FINISH
  } t_loopback_state;

  t_loopback_state state;

  logic fifo_enq_en;
  logic fifo_deq_en;
  logic fifo_empty;
  logic fifo_full;

  logic [31:0] count_write;
  logic [31:0] count_read;

  t_buffer_data fifo_enq_data;
  t_buffer_data fifo_deq_data;

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
    .full         (fifo_full),
    .deq_data     (fifo_deq_data),
    .deq_en       (fifo_deq_en),
    .empty        (fifo_empty),
    .counter      (),
    .dec_counter  ()
  );

  // read request

  function void init_fifo();
    if (start) begin
      buffer.read_stream(1, 512);

      count_read <= count_read + 32'd512;
      state      <= READ;
    end
  endfunction : init_fifo

  function void fill_fifo();
    if ((count_read - count_write) < 256) begin
      buffer.read_stream(1, 256);

      count_read <= count_read + 32'd256;
    end
    else begin
      buffer.read_idle();
    end

    if (count_read == buffer.size(1))
      state <= FINISH;
  endfunction : fill_fifo

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      state      <= START;
      count_read <= '0;

      buffer.read_idle();
    end
    else begin
      case (state)
      START  : init_fifo();
      READ   : fill_fifo();
      FINISH : buffer.read_idle();
      endcase
    end
  end

  // read response
  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      fifo_enq_en    <= 1'b0;
    end
    else begin
      if (buffer.valid()) begin
        fifo_enq_en    <= 1'b1;
        fifo_enq_data  <= buffer.data();
      end
      else begin
        fifo_enq_en <= 1'b0;
      end
    end
  end

  // write request
  always_comb begin
    fifo_deq_en = !fifo_empty && !buffer.write_full();
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      buffer.write_idle();
    end
    else begin
      buffer.write_stream(0, fifo_deq_data);

      if (!fifo_deq_en) begin
        buffer.write_idle();
      end
    end
  end

  // finish
  assign finish = (count_write >= buffer.size(0)) && (2 == state);

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      count_write <= '0;
    end
    else begin
      if (fifo_deq_en) begin
        count_write <= count_write + 32'h1;
      end
    end
  end

endmodule : loopback

