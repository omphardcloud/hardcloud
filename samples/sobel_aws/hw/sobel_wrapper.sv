// sobel_wrapper.sv

`define BUFFER_IMAGE_IN  1
`define BUFFER_IMAGE_OUT 0

module sobel_wrapper
(
  input  logic  clk,
  input  logic  reset,
  input  logic  start,
  output logic  finish,
  hc_buffers_if buffer
);

  typedef enum logic [1:0] {START, RUN, FINISH} t_sobel_wrapper_state;

  logic [ 17:0] read_offset;
  logic [ 17:0] count_write;
  logic [511:0] data_in;
  logic         valid_in;
  logic [511:0] data_out;
  logic         valid_out;

  t_sobel_wrapper_state state;

  sobel uu_sobel
  (
    .clk       (clk),
    .reset     (reset),
    .data_in   (data_in),
    .valid_in  (valid_in),
    .data_out  (data_out),
    .valid_out (valid_out)
  );

  //
  // read request
  //

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

    if (buffer.size(`BUFFER_IMAGE_IN) - 1 == read_offset) begin
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
      data_in  <= '0;
      valid_in <= '0;
    end
    else begin
      data_in  <= buffer.data();
      valid_in <= buffer.valid();
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

      if (!valid_out) begin
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
      finish      <= ((count_write == buffer.size(`BUFFER_IMAGE_OUT) - 1) & (state == FINISH)) | finish;
      count_write <= count_write + valid_out;
    end
  end

endmodule : sobel_wrapper

