// hc_buffer_if.sv

`ifndef HC_BUFFER_IF_SV__
`define HC_BUFFER_IF_SV__

interface hc_buffers_if();
  import ccip_if_pkg::*;
  import hc_pkg::*;

  //
  // ports
  //

  t_request read_request;
  t_request write_request;

  t_buffer rx_buffer_data;
  t_buffer tx_buffer_data;

  t_buffer_total_size buffer_size;

  //
  // read request functions
  //

  function void read_idle();
    read_request.control.cmd    <= e_REQUEST_IDLE;
    read_request.control.id     <= t_request_cmd_id'('0);
    read_request.control.offset <= t_request_cmd_offset'('0);
    read_request.control.finish <= '0;
  endfunction : read_idle

  function void read_stream(t_request_cmd_id id, t_request_cmd_offset offset);
    read_request.control.cmd    <= e_REQUEST_READ_STREAM;
    read_request.control.id     <= id;
    read_request.control.offset <= offset;
    read_request.control.finish <= '0;
  endfunction : read_stream

  function void read_indexed(t_request_cmd_id id, t_request_cmd_offset offset);
    read_request.control.cmd    <= e_REQUEST_READ_INDEXED;
    read_request.control.id     <= id;
    read_request.control.offset <= offset;
    read_request.control.finish <= '0;
  endfunction : read_indexed

  function t_request_size read_count();
    return read_request.status.count;
  endfunction : read_count

  function logic read_empty();
    return read_request.status.empty;
  endfunction : read_empty

  function logic read_full();
    return read_request.status.full;
  endfunction : read_full

  //
  // write request functions
  //

  function void write_idle();
    write_request.control.cmd    <= e_REQUEST_IDLE;
    write_request.control.id     <= t_request_cmd_id'('0);
    write_request.control.offset <= t_request_cmd_offset'('0);
    write_request.control.finish <= '0;

    tx_buffer_data.valid <= 1'b0;
  endfunction : write_idle

  function void write_stream(t_request_cmd_id id, t_buffer_data data);
    write_request.control.cmd    <= e_REQUEST_WRITE_STREAM;
    write_request.control.id     <= id;
    write_request.control.offset <= t_request_cmd_offset'('0);
    write_request.control.finish <= '0;

    tx_buffer_data.cl_data <= data;
    tx_buffer_data.valid   <= 1'b1;
  endfunction : write_stream

  function void write_indexed(
    t_request_cmd_id id,
    t_request_cmd_offset offset,
    t_buffer_data data
  );
    write_request.control.cmd    <= e_REQUEST_WRITE_INDEXED;
    write_request.control.id     <= id;
    write_request.control.offset <= offset;
    write_request.control.finish <= '0;

    tx_buffer_data.cl_data <= data;
    tx_buffer_data.valid   <= 1'b1;
  endfunction : write_indexed

  function void write_finish();
    write_request.control.cmd    <= e_REQUEST_WRITE_FINISH;
    write_request.control.id     <= 0;
    write_request.control.offset <= 0;
    write_request.control.finish <= '0;

    tx_buffer_data.cl_data <= 1;
    tx_buffer_data.valid   <= 1'b1;
  endfunction : write_finish

  function t_request_size write_count();
    return write_request.status.count;
  endfunction : write_count

  function logic write_empty();
    return write_request.status.empty;
  endfunction : write_empty

  function logic write_full();
    return write_request.status.full;
  endfunction : write_full

  //
  // buffer functions
  //
  function logic valid();
    return rx_buffer_data.valid;
  endfunction : valid

  function t_buffer_data data();
    return rx_buffer_data.cl_data;
  endfunction : data

  function t_buffer_size size(int id);
    return buffer_size[id*HC_MAX_BUFFER_SIZE +: HC_MAX_BUFFER_SIZE];
  endfunction : size

endinterface : hc_buffers_if

`endif // HC_BUFFER_IF_SV__

