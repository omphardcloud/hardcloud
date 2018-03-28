// hc_pkg.sv

package hc_pkg;
  import ccip_if_pkg::*;

  //
  // HardCloud user definitions
  //

  parameter HC_BUFFER_TX_SIZE = 1;
  parameter HC_BUFFER_RX_SIZE = 1;

  parameter HC_BUFFER_TX_DEPTH = 8;

  parameter HC_BUFFER_SIZE = HC_BUFFER_TX_SIZE + HC_BUFFER_RX_SIZE;

  //
  // HardCloud internal definitions
  //

  parameter HC_DSM_BASE_LOW = 16'h110; // 32b - RW  Lower 32-bits of DSM base address
  parameter HC_CONTROL      = 16'h118; // 32b - RW  Control to start n stop the test

  parameter HC_BUFFER_BASE_ADDRESS  = 16'h120;

  parameter HC_CONTROL_ASSERT_RST   = 32'h0000;
  parameter HC_CONTROL_DEASSERT_RST = 32'h0001;
  parameter HC_CONTROL_START        = 32'h0003;
  parameter HC_CONTROL_STOP         = 32'h0007;

  //
  // HardCloud csr definitions
  //

  typedef logic [31:0] t_hc_control;
  typedef logic [63:0] t_hc_address;

  typedef struct packed {
    t_hc_address address;
    logic [31:0] size;
  } t_hc_buffer;

  function logic [$clog2(HC_BUFFER_SIZE):0] hc_buffer_which(
    input t_if_ccip_c0_Rx rx_mmio_channel
  );

    t_ccip_c0_ReqMmioHdr mmio_req_hdr;

    mmio_req_hdr = t_ccip_c0_ReqMmioHdr'(rx_mmio_channel.hdr);

    return (mmio_req_hdr.address >> 2) - (HC_BUFFER_BASE_ADDRESS >> 4);
  endfunction : hc_buffer_which

  function logic [1:0] hc_buffer_sel(input t_if_ccip_c0_Rx rx_mmio_channel);
    logic is_write;
    logic has_sel;
    logic is_size_type;
    t_ccip_c0_ReqMmioHdr mmio_req_hdr;
    t_ccip_mmioAddr top_addr;

    is_write = rx_mmio_channel.mmioWrValid & (mmio_req_hdr.address < 'h400);
    mmio_req_hdr = t_ccip_c0_ReqMmioHdr'(rx_mmio_channel.hdr);
    top_addr = 16'h120 + 16'h10*HC_BUFFER_SIZE + 16'h8;

    has_sel = is_write &&
      (mmio_req_hdr.address >= HC_BUFFER_BASE_ADDRESS >> 2) &&
      (mmio_req_hdr.address <= top_addr >> 2);

    is_size_type = mmio_req_hdr.address[1];

    return {is_size_type, has_sel};
  endfunction : hc_buffer_sel

  function logic hc_control_sel(input t_if_ccip_c0_Rx rx_mmio_channel);
    logic is_write;
    t_ccip_c0_ReqMmioHdr mmio_req_hdr;

    is_write = rx_mmio_channel.mmioWrValid & (mmio_req_hdr.address < 'h400);
    mmio_req_hdr = t_ccip_c0_ReqMmioHdr'(rx_mmio_channel.hdr);

    return is_write && (mmio_req_hdr.address == HC_CONTROL >> 2);
  endfunction : hc_control_sel

  function logic hc_dsm_sel(input t_if_ccip_c0_Rx rx_mmio_channel);
    logic is_write;
    t_ccip_c0_ReqMmioHdr mmio_req_hdr;

    is_write = rx_mmio_channel.mmioWrValid & (mmio_req_hdr.address < 'h400);
    mmio_req_hdr = t_ccip_c0_ReqMmioHdr'(rx_mmio_channel.hdr);

    return is_write && (mmio_req_hdr.address == HC_DSM_BASE_LOW >> 2);
  endfunction : hc_dsm_sel

  //
  // HardCloud interface definitions
  //

  parameter HC_MAX_BUFFER_SIZE = 32;

  parameter HC_REQUEST_DEPTH = 8;

  typedef logic [(CCIP_CLDATA_WIDTH - 1):0]                 t_buffer_data;
  typedef logic [(HC_MAX_BUFFER_SIZE - 1):0]                t_buffer_size;
  typedef logic [(HC_BUFFER_SIZE*HC_MAX_BUFFER_SIZE - 1):0] t_buffer_total_size;

  typedef logic [$clog2(HC_BUFFER_SIZE):0]  t_request_cmd_id;
  typedef t_ccip_clAddr                     t_request_cmd_offset;

  typedef logic [(HC_REQUEST_DEPTH/2 - 1):0]  t_request_size;

  typedef enum logic [2:0] {
    e_REQUEST_IDLE          = 3'h0,
    e_REQUEST_READ_STREAM   = 3'h1,
    e_REQUEST_READ_INDEXED  = 3'h2,
    e_REQUEST_WRITE_STREAM  = 3'h3,
    e_REQUEST_WRITE_INDEXED = 3'h4
  } t_request_cmd;

  typedef struct packed {
    logic         valid;
    t_buffer_data cl_data;
  } t_buffer;

  typedef struct packed {
    logic          empty;
    logic          full;
    t_request_size count;
  } t_request_status;

  typedef struct packed {
    t_request_cmd        cmd;
    t_request_cmd_id     id;
    t_request_cmd_offset offset;
  } t_request_control;

  typedef struct packed {
    t_request_control control;
    t_request_status  status;
  } t_request;

  typedef struct packed {
    t_request_cmd         cmd;
    t_request_cmd_id      id;
    t_request_cmd_offset  offset;
    t_buffer_data         data;
  } t_request_write_fifo;

  //
  // HardCloud requestor definitions
  //

  typedef enum logic [1:0] {
    S_RD_IDLE        = 2'h0,
    S_RD_STREAM      = 2'h1,
    S_RD_INDEX       = 2'h2,
    S_RD_START       = 2'h3
  } t_rd_state;

  typedef enum logic [1:0] {
    S_WR_IDLE     = 2'h0,
    S_WR_SEND     = 2'h1,
    S_WR_FINISH_1 = 2'h2,
    S_WR_FINISH_2 = 2'h3
  } t_wr_state;

endpackage : hc_pkg

