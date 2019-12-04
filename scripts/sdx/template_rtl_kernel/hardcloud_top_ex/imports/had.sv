// had.sv - hardcloud if / axi adapter

`default_nettype none

module had #(
  parameter integer C_IF_AXI_IN_ADDR_WIDTH  = 64 ,
  parameter integer C_IF_AXI_IN_DATA_WIDTH  = 512,
  parameter integer C_IF_AXI_OUT_ADDR_WIDTH = 64 ,
  parameter integer C_IF_AXI_OUT_DATA_WIDTH = 512
)
(
  // system signals
  input  wire                                 clk               ,
  input  wire                                 rst               ,

  // axi4 master interface if_axi_in
  output wire                                 if_axi_in_awvalid ,
  input  wire                                 if_axi_in_awready ,
  output wire [C_IF_AXI_IN_ADDR_WIDTH-1:0]    if_axi_in_awaddr  ,
  output wire [8-1:0]                         if_axi_in_awlen   ,
  output wire                                 if_axi_in_wvalid  ,
  input  wire                                 if_axi_in_wready  ,
  output wire [C_IF_AXI_IN_DATA_WIDTH-1:0]    if_axi_in_wdata   ,
  output wire [C_IF_AXI_IN_DATA_WIDTH/8-1:0]  if_axi_in_wstrb   ,
  output wire                                 if_axi_in_wlast   ,
  input  wire                                 if_axi_in_bvalid  ,
  output wire                                 if_axi_in_bready  ,
  output wire                                 if_axi_in_arvalid ,
  input  wire                                 if_axi_in_arready ,
  output wire [C_IF_AXI_IN_ADDR_WIDTH-1:0]    if_axi_in_araddr  ,
  output wire [8-1:0]                         if_axi_in_arlen   ,
  input  wire                                 if_axi_in_rvalid  ,
  output wire                                 if_axi_in_rready  ,
  input  wire [C_IF_AXI_IN_DATA_WIDTH-1:0]    if_axi_in_rdata   ,
  input  wire                                 if_axi_in_rlast   ,

  // axi4 master interface if_axi_out
  output wire                                 if_axi_out_awvalid,
  input  wire                                 if_axi_out_awready,
  output wire [C_IF_AXI_OUT_ADDR_WIDTH-1:0]   if_axi_out_awaddr ,
  output wire [8-1:0]                         if_axi_out_awlen  ,
  output wire                                 if_axi_out_wvalid ,
  input  wire                                 if_axi_out_wready ,
  output wire [C_IF_AXI_OUT_DATA_WIDTH-1:0]   if_axi_out_wdata  ,
  output wire [C_IF_AXI_OUT_DATA_WIDTH/8-1:0] if_axi_out_wstrb  ,
  output wire                                 if_axi_out_wlast  ,
  input  wire                                 if_axi_out_bvalid ,
  output wire                                 if_axi_out_bready ,
  output wire                                 if_axi_out_arvalid,
  input  wire                                 if_axi_out_arready,
  output wire [C_IF_AXI_OUT_ADDR_WIDTH-1:0]   if_axi_out_araddr ,
  output wire [8-1:0]                         if_axi_out_arlen  ,
  input  wire                                 if_axi_out_rvalid ,
  output wire                                 if_axi_out_rready ,
  input  wire [C_IF_AXI_OUT_DATA_WIDTH-1:0]   if_axi_out_rdata  ,
  input  wire                                 if_axi_out_rlast  ,

  // sdx control signals
  input  wire                                 ap_start          ,
  output wire                                 ap_idle           ,
  input  wire                                 ap_done           ,
  input  wire [32-1:0]                        ptr0_size_in      ,
  input  wire [32-1:0]                        ptr0_size_out     ,
  input  wire [64-1:0]                        ptr0_axi_in       ,
  input  wire [64-1:0]                        ptr0_axi_out      ,

  // hardcloud interface
  hif.slave                                   buffer
);

  //
  // map hif and AXI4 (if_axi_in and if_axi_out)
  //

  // AXI4 master interface if_axi_in
  assign if_axi_in_awvalid = buffer.if_axi_in_awvalid;
  assign if_axi_in_awaddr  = buffer.if_axi_in_awaddr ;
  assign if_axi_in_awlen   = buffer.if_axi_in_awlen  ;
  assign if_axi_in_wvalid  = buffer.if_axi_in_wvalid ;
  assign if_axi_in_wdata   = buffer.if_axi_in_wdata  ;
  assign if_axi_in_wstrb   = buffer.if_axi_in_wstrb  ;
  assign if_axi_in_wlast   = buffer.if_axi_in_wlast  ;
  assign if_axi_in_bready  = buffer.if_axi_in_bready ;
  assign if_axi_in_arvalid = buffer.if_axi_in_arvalid;
  assign if_axi_in_araddr  = buffer.if_axi_in_araddr ;
  assign if_axi_in_arlen   = buffer.if_axi_in_arlen  ;
  assign if_axi_in_rready  = buffer.if_axi_in_rready ;

  assign buffer.if_axi_in_awready = if_axi_in_awready;
  assign buffer.if_axi_in_wready  = if_axi_in_wready ;
  assign buffer.if_axi_in_bvalid  = if_axi_in_bvalid ;
  assign buffer.if_axi_in_arready = if_axi_in_arready;
  assign buffer.if_axi_in_rvalid  = if_axi_in_rvalid ;
  assign buffer.if_axi_in_rdata   = if_axi_in_rdata  ;
  assign buffer.if_axi_in_rlast   = if_axi_in_rlast  ;

  // AXI4 master interface if_axi_out
  assign if_axi_out_awvalid = buffer.if_axi_out_awvalid;
  assign if_axi_out_awaddr  = buffer.if_axi_out_awaddr ;
  assign if_axi_out_awlen   = buffer.if_axi_out_awlen  ;
  assign if_axi_out_wvalid  = buffer.if_axi_out_wvalid ;
  assign if_axi_out_wdata   = buffer.if_axi_out_wdata  ;
  assign if_axi_out_wstrb   = buffer.if_axi_out_wstrb  ;
  assign if_axi_out_wlast   = buffer.if_axi_out_wlast  ;
  assign if_axi_out_bready  = buffer.if_axi_out_bready ;
  assign if_axi_out_arvalid = buffer.if_axi_out_arvalid;
  assign if_axi_out_araddr  = buffer.if_axi_out_araddr ;
  assign if_axi_out_arlen   = buffer.if_axi_out_arlen  ;
  assign if_axi_out_rready  = buffer.if_axi_out_rready ;

  assign buffer.if_axi_out_awready = if_axi_out_awready ;
  assign buffer.if_axi_out_wready  = if_axi_out_wready  ;
  assign buffer.if_axi_out_bvalid  = if_axi_out_bvalid  ;
  assign buffer.if_axi_out_arready = if_axi_out_arready ;
  assign buffer.if_axi_out_rvalid  = if_axi_out_rvalid  ;
  assign buffer.if_axi_out_rdata   = if_axi_out_rdata   ;
  assign buffer.if_axi_out_rlast   = if_axi_out_rlast   ;

  assign buffer.ptr0_size_in  = ptr0_size_in  ;
  assign buffer.ptr0_size_out = ptr0_size_out ;
  assign buffer.ptr0_axi_in   = ptr0_axi_in   ;
  assign buffer.ptr0_axi_out  = ptr0_axi_out  ;

  //
  // idle control
  //

  logic ap_idle_q;

  assign ap_idle = ap_idle_q;

  always_ff@(posedge clk) begin
    ap_idle_q <= 1'b1;

    if (ap_start && !ap_done) begin
      ap_idle_q <= 1'b0;
    end

    if (rst) begin
      ap_idle_q <= 1'b0;
    end
  end

endmodule : had

`default_nettype wire

