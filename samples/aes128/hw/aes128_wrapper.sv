// aes128_wrapper.sv

`define BUFFER_KEY_IN   1
`define BUFFER_DATA_IN  2
`define BUFFER_DATA_OUT 0

module aes128_wrapper
(
  input  logic  clk,
  input  logic  reset,
  input  logic  start,
  output logic  finish,
  hc_buffers_if buffer
);

  typedef enum logic [1:0] {START, KEY, DATA, FINISH} t_aes128_wrapper_state;

  logic [  1:0] cycle_write;

  logic [ 17:0] read_offset;
  logic [ 17:0] count_write;

  logic [511:0] cl_data_in;
  logic [511:0] cl_data_out;
  logic         cl_valid_out;

  logic [127:0] key_in;
  logic         key_valid_in;
  logic [127:0] data_in;
  logic         valid_in;
  logic [127:0] data_out;
  logic         valid_out;

  t_aes128_wrapper_state rd_state;
  t_aes128_wrapper_state rsp_state;

  aes128 uu_aes128
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

    rd_state <= START;
    read_offset <= '0;
  endfunction : read_reset

  function void read_start();
    if (start) begin
      read_offset <= '0;

      rd_state <= KEY;
    end
  endfunction : read_start

  function void read_request_key();
    if (!buffer.read_full()) begin
      buffer.read_indexed(`BUFFER_KEY_IN, 0);

      rd_state <= DATA;
    end
  endfunction : read_request_key

  function void read_request_data();
    buffer.read_indexed(`BUFFER_DATA_IN, read_offset);

    if (buffer.read_full()) begin
      buffer.read_idle();
    end
    else begin
      read_offset <= read_offset + 1;
    end

    if (buffer.size(`BUFFER_DATA_IN) - 1 == read_offset) begin
      rd_state <= FINISH;
    end
  endfunction : read_request_data

  function void read_finish();
    buffer.read_idle();
  endfunction : read_finish

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      read_reset();
    end
    else begin
      case (rd_state)
      START  : read_start();
      KEY    : read_request_key();
      DATA   : read_request_data();
      FINISH : read_finish();
      endcase
    end
  end

  //
  // read response
  //
  function void response_reset();
    key_in       <= '0;
    key_valid_in <= '0;
    data_in  <= '0;
    valid_in <= '0;

    rsp_state <= KEY;
  endfunction : response_reset

  function void response_key();
    if (buffer.valid()) begin
      key_in       <= buffer.data()[127:0];
      key_valid_in <= 1'b1;

      rsp_state <= DATA;
    end
  endfunction : response_key

  function void response_data();
    // data_in  <= buffer.data();
    // valid_in <= buffer.valid();
    if (buffer.valid()) begin
      $display("valid");
    end
    else begin
      $display("not valid");
    end
  endfunction : response_data

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      response_reset();
    end
    else begin
      case (rsp_state)
      KEY  : response_key();
      DATA : response_data();
      endcase
    end
  end

  //
  // write request
  //

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      cycle_write <= '0;
    end
    else begin
      if (valid_out) begin
        cl_data_out  <= (cl_data_out << 128) | data_out;
        cl_valid_out <= &cycle_write;
        cycle_write  <= cycle_write + 1;
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      buffer.write_idle();
    end
    else begin
      buffer.write_stream(`BUFFER_DATA_OUT, cl_data_out);

      if (!cl_valid_out) begin
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
      finish      <= ((count_write == buffer.size(`BUFFER_DATA_OUT) - 1) & (rd_state == FINISH)) | finish;
      count_write <= count_write + cl_valid_out;
    end
  end

endmodule : aes128_wrapper

