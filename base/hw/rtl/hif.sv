// hif.sv - hardcloud interface

`ifndef HIF_SV__
`define HIF_SV__

interface hif #(
  parameter integer C_IF_AXI_IN_ADDR_WIDTH  = 64 ,
  parameter integer C_IF_AXI_IN_DATA_WIDTH  = 512,
  parameter integer C_IF_AXI_OUT_ADDR_WIDTH = 64 ,
  parameter integer C_IF_AXI_OUT_DATA_WIDTH = 512
)
(
  input clk,
  input rst
);

  import hc_pkg::*;

  typedef logic [ 31:0] t_id;
  typedef logic [  7:0] t_length;
  typedef logic [ 31:0] t_offset;
  typedef logic [ 31:0] t_size;
  typedef logic [511:0] t_data;

  //
  // ports
  //

  // AXI4 master interface if_axi_in
  logic                                 if_axi_in_awvalid ;
  logic                                 if_axi_in_awready ;
  logic [C_IF_AXI_IN_ADDR_WIDTH-1:0]    if_axi_in_awaddr  ;
  logic [8-1:0]                         if_axi_in_awlen   ;
  logic                                 if_axi_in_wvalid  ;
  logic                                 if_axi_in_wready  ;
  logic [C_IF_AXI_IN_DATA_WIDTH-1:0]    if_axi_in_wdata   ;
  logic [C_IF_AXI_IN_DATA_WIDTH/8-1:0]  if_axi_in_wstrb   ;
  logic                                 if_axi_in_wlast   ;
  logic                                 if_axi_in_bvalid  ;
  logic                                 if_axi_in_bready  ;
  logic                                 if_axi_in_arvalid ;
  logic                                 if_axi_in_arready ;
  logic [C_IF_AXI_IN_ADDR_WIDTH-1:0]    if_axi_in_araddr  ;
  logic [8-1:0]                         if_axi_in_arlen   ;
  logic                                 if_axi_in_rvalid  ;
  logic                                 if_axi_in_rready  ;
  logic [C_IF_AXI_IN_DATA_WIDTH-1:0]    if_axi_in_rdata   ;
  logic                                 if_axi_in_rlast   ;

  // AXI4 master interface if_axi_out
  logic                                 if_axi_out_awvalid;
  logic                                 if_axi_out_awready;
  logic [C_IF_AXI_OUT_ADDR_WIDTH-1:0]   if_axi_out_awaddr ;
  logic [8-1:0]                         if_axi_out_awlen  ;
  logic                                 if_axi_out_wvalid ;
  logic                                 if_axi_out_wready ;
  logic [C_IF_AXI_OUT_DATA_WIDTH-1:0]   if_axi_out_wdata  ;
  logic [C_IF_AXI_OUT_DATA_WIDTH/8-1:0] if_axi_out_wstrb  ;
  logic                                 if_axi_out_wlast  ;
  logic                                 if_axi_out_bvalid ;
  logic                                 if_axi_out_bready ;
  logic                                 if_axi_out_arvalid;
  logic                                 if_axi_out_arready;
  logic [C_IF_AXI_OUT_ADDR_WIDTH-1:0]   if_axi_out_araddr ;
  logic [8-1:0]                         if_axi_out_arlen  ;
  logic                                 if_axi_out_rvalid ;
  logic                                 if_axi_out_rready ;
  logic [C_IF_AXI_OUT_DATA_WIDTH-1:0]   if_axi_out_rdata  ;
  logic                                 if_axi_out_rlast  ;

  // SDx Control Signals
  logic                                 ap_start          ;
  logic                                 ap_idle           ;
  logic                                 ap_done           ;
  logic [32-1:0]                        ptr0_size_in      ;
  logic [32-1:0]                        ptr0_size_out     ;
  logic [64-1:0]                        ptr0_axi_in       ;
  logic [64-1:0]                        ptr0_axi_out      ;

  modport master
  (
    // AXI4 master interface if_axi_in
    output if_axi_in_awvalid ,
    input  if_axi_in_awready ,
    output if_axi_in_awaddr  ,
    output if_axi_in_awlen   ,
    output if_axi_in_wvalid  ,
    input  if_axi_in_wready  ,
    output if_axi_in_wdata   ,
    output if_axi_in_wstrb   ,
    output if_axi_in_wlast   ,
    input  if_axi_in_bvalid  ,
    output if_axi_in_bready  ,
    output if_axi_in_arvalid ,
    input  if_axi_in_arready ,
    output if_axi_in_araddr  ,
    output if_axi_in_arlen   ,
    input  if_axi_in_rvalid  ,
    output if_axi_in_rready  ,
    input  if_axi_in_rdata   ,
    input  if_axi_in_rlast   ,

    // AXI4 master interface if_axi_out
    output if_axi_out_awvalid,
    input  if_axi_out_awready,
    output if_axi_out_awaddr ,
    output if_axi_out_awlen  ,
    output if_axi_out_wvalid ,
    input  if_axi_out_wready ,
    output if_axi_out_wdata  ,
    output if_axi_out_wstrb  ,
    output if_axi_out_wlast  ,
    input  if_axi_out_bvalid ,
    output if_axi_out_bready ,
    output if_axi_out_arvalid,
    input  if_axi_out_arready,
    output if_axi_out_araddr ,
    output if_axi_out_arlen  ,
    input  if_axi_out_rvalid ,
    output if_axi_out_rready ,
    input  if_axi_out_rdata  ,
    input  if_axi_out_rlast  ,

    // Control Signals
    input  ap_start          ,
    output ap_idle           ,
    output ap_done           ,
    input  ptr0_size_in      ,
    input  ptr0_size_out     ,
    input  ptr0_axi_in       ,
    input  ptr0_axi_out      ,

    import function bit    read_addr(t_id id, t_offset offset, t_length len),
    import function bit    read_data(output t_data data),
    import function t_size read_size(t_id id),
    import function void   read_reset(),

    import function bit    write_addr(t_id id, t_offset offset, t_length len),
    import function bit    write_data(t_data data),
    import function t_size write_size(t_id id),
    import function void   write_reset()
  );

  modport slave
  (
    // AXI4 slave interface if_axi_in
    input  if_axi_in_awvalid ,
    output if_axi_in_awready ,
    input  if_axi_in_awaddr  ,
    input  if_axi_in_awlen   ,
    input  if_axi_in_wvalid  ,
    output if_axi_in_wready  ,
    input  if_axi_in_wdata   ,
    input  if_axi_in_wstrb   ,
    input  if_axi_in_wlast   ,
    output if_axi_in_bvalid  ,
    input  if_axi_in_bready  ,
    input  if_axi_in_arvalid ,
    output if_axi_in_arready ,
    input  if_axi_in_araddr  ,
    input  if_axi_in_arlen   ,
    output if_axi_in_rvalid  ,
    input  if_axi_in_rready  ,
    output if_axi_in_rdata   ,
    output if_axi_in_rlast   ,

    // AXI4 slave interface if_axi_out
    input  if_axi_out_awvalid,
    output if_axi_out_awready,
    input  if_axi_out_awaddr ,
    input  if_axi_out_awlen  ,
    input  if_axi_out_wvalid ,
    output if_axi_out_wready ,
    input  if_axi_out_wdata  ,
    input  if_axi_out_wstrb  ,
    input  if_axi_out_wlast  ,
    output if_axi_out_bvalid ,
    input  if_axi_out_bready ,
    input  if_axi_out_arvalid,
    output if_axi_out_arready,
    input  if_axi_out_araddr ,
    input  if_axi_out_arlen  ,
    output if_axi_out_rvalid ,
    input  if_axi_out_rready ,
    output if_axi_out_rdata  ,
    output if_axi_out_rlast  ,

    // Control Signals
    output ap_start          ,
    input  ap_idle           ,
    input  ap_done           ,
    output ptr0_size_in      ,
    output ptr0_size_out     ,
    output ptr0_axi_in       ,
    output ptr0_axi_out
  );

  //
  // read functions
  //

  logic [63:0] ptr0_axi_in_q;
  logic [63:0] ptr0_axi_out_q;

  function bit read_addr(t_id id, t_offset offset, t_length len);
    if_axi_in_arlen   = len - 1;
    if_axi_in_araddr  = ptr0_axi_in_q + (offset * 64);
    if_axi_in_arvalid = 1'b1;

    return if_axi_in_arready;
  endfunction : read_addr

  function bit read_data(output t_data data);
    data = if_axi_in_rdata;

    if_axi_in_rready = 1'b1;

    return (if_axi_in_rvalid && if_axi_in_rready);
  endfunction : read_data

  function t_size read_size(t_id id);
    return (ptr0_size_in >> 6);
  endfunction : read_size

  function void read_reset();
    if_axi_in_arvalid = '0;
    if_axi_in_rready  = '0;
  endfunction : read_reset

  //
  // write functions
  //

  function bit write_addr(t_id id, t_offset offset, t_length len);
    if_axi_out_awlen   = len - 1;
    if_axi_out_awaddr  = ptr0_axi_out_q + (offset * 64);
    if_axi_out_awvalid = 1'b1;

    return if_axi_out_awready;
  endfunction : write_addr

  function bit write_data(t_data data);
    if_axi_out_wvalid = 1'b1;
    if_axi_out_wdata  = data;
    if_axi_out_wstrb  = '1;
    if_axi_out_wlast  = '1;

    return if_axi_out_wready;
  endfunction : write_data

  function t_size write_size(t_id id);
    return (ptr0_size_out >> 6);
  endfunction : write_size

  function void write_reset();
    if_axi_out_awvalid = '0;
    if_axi_out_wvalid  = '0;
  endfunction : write_reset

  //
  // internal control
  //

  // fixed valuess
  assign if_axi_in_awvalid = '0 ;
  assign if_axi_in_awaddr  = '0 ;
  assign if_axi_in_awlen   = '0 ;
  assign if_axi_in_wvalid  = '0 ;
  assign if_axi_in_wdata   = '0 ;
  assign if_axi_in_wstrb   = '0 ;
  assign if_axi_in_wlast   = '0 ;
  assign if_axi_in_bready  = '1 ;

  assign if_axi_out_bready  = '1 ;
  assign if_axi_out_arvalid = '0 ;
  assign if_axi_out_araddr  = '0 ;
  assign if_axi_out_arlen   = '0 ;
  assign if_axi_out_rready  = '0 ;

  always_ff@(posedge clk) begin
    ptr0_axi_in_q  <= ptr0_axi_in;
    ptr0_axi_out_q <= ptr0_axi_out;
  end

endinterface : hif

`endif // HIF_SV__

