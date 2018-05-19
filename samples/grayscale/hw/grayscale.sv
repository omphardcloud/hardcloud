// grayscale.sv

`define BUFFER_IMAGE_IN  1
`define BUFFER_IMAGE_OUT 0

module grayscale
(
  input  logic  clk,
  input  logic  reset,
  input  logic  start,
  output logic  finish,
  hc_buffers_if buffer
);

  typedef enum logic [1:0] {START, RUN, FINISH} t_grayscale_state;

  logic [ 17:0] read_offset;
  logic [ 17:0] count_write;
  logic [511:0] data_out;
  logic         is_write_valid;

  t_grayscale_state state;

  function [31:0] rgb2luma(input logic [31:0] data);
    logic [7:0] tmp;

    tmp  = data[7:0]   >> 2;
    tmp += data[7:0]   >> 5;
    tmp += data[15:8]  >> 1;
    tmp += data[15:8]  >> 4;
    tmp += data[23:16] >> 4;
    tmp += data[23:16] >> 5;

    return {tmp, tmp, tmp};
  endfunction : rgb2luma

  //
  // read request
  //

  // fixed image size: 512x512

  function void read_reset();
    buffer.read_idle();

    state <= START;
    read_offset <= '0;
  endfunction : read_reset

  function void read_start();
    if (start) begin
      read_offset <= '0;

      state <= RUN;
    end
  endfunction : read_start

  function void read_request();
    buffer.read_indexed(`BUFFER_IMAGE_IN, read_offset);

    if (buffer.read_full()) begin
      buffer.read_idle();
    end
    else begin
      read_offset <= read_offset + 1;
    end

    if (buffer.size(`BUFFER_IMAGE_IN) - 2 == read_offset) begin
      state <= FINISH;
    end
  endfunction : read_request

  function void read_finish();
    buffer.read_idle();
  endfunction : read_finish

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      read_reset();
    end
    else begin
      case (state)
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
      is_write_valid <= 1'b0;
    end
    else begin
      is_write_valid <= buffer.valid();
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      data_out <= '0;
    end
    else begin
      for (int i = 0; i < 16; i++) begin
        data_out[32*i +: 32] <= rgb2luma(buffer.data()[32*i +: 32]);
      end
    end
  end

  //
  // write request
  //
  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      buffer.write_idle();
    end
    else begin
      buffer.write_stream(`BUFFER_IMAGE_OUT, data_out);

      if (!is_write_valid) begin
        buffer.write_idle();
      end

      if (buffer.write_fifo_is_full()) begin
        $stop;
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
      finish      <= (count_write == buffer.size(`BUFFER_IMAGE_OUT) - 1) & (state == FINISH);
      count_write <= count_write + is_write_valid;
    end
  end

endmodule : grayscale

