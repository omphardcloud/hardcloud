// This is a generated file. Use and modify at your own risk.
////////////////////////////////////////////////////////////////////////////////
// default_nettype of none prevents implicit wire declaration.
`default_nettype none
`timescale 1 ns / 1 ps

`include "hc_user_pkg.svh"
`include "hc_pkg.svh"

// Top level of the kernel. Do not modify module name, parameters or ports.
module hip_wrapper #(
  parameter integer C_S_AXI_CONTROL_ADDR_WIDTH = 12 ,
  parameter integer C_S_AXI_CONTROL_DATA_WIDTH = 32 ,
  parameter integer C_IF_AXI_IN_ADDR_WIDTH     = 64 ,
  parameter integer C_IF_AXI_IN_DATA_WIDTH     = 512,
  parameter integer C_IF_AXI_OUT_ADDR_WIDTH    = 64 ,
  parameter integer C_IF_AXI_OUT_DATA_WIDTH    = 512
)
(
  // System Signals
  input  wire                                    ap_clk               ,
  input  wire                                    ap_rst_n             ,
  //  Note: A minimum subset of AXI4 memory mapped signals are declared.  AXI
  // signals omitted from these interfaces are automatically inferred with the
  // optimal values for Xilinx SDx systems.  This allows Xilinx AXI4 Interconnects
  // within the system to be optimized by removing logic for AXI4 protocol
  // features that are not necessary. When adapting AXI4 masters within the RTL
  // kernel that have signals not declared below, it is suitable to add the
  // signals to the declarations below to connect them to the AXI4 Master.
  //
  // List of ommited signals - effect
  // -------------------------------
  // ID - Transaction ID are used for multithreading and out of order
  // transactions.  This increases complexity. This saves logic and increases Fmax
  // in the system when ommited.
  // SIZE - Default value is log2(data width in bytes). Needed for subsize bursts.
  // This saves logic and increases Fmax in the system when ommited.
  // BURST - Default value (0b01) is incremental.  Wrap and fixed bursts are not
  // recommended. This saves logic and increases Fmax in the system when ommited.
  // LOCK - Not supported in AXI4
  // CACHE - Default value (0b0011) allows modifiable transactions. No benefit to
  // changing this.
  // PROT - Has no effect in SDx systems.
  // QOS - Has no effect in SDx systems.
  // REGION - Has no effect in SDx systems.
  // USER - Has no effect in SDx systems.
  // RESP - Not useful in most SDx systems.
  //
  // AXI4 master interface if_axi_in
  output wire                                    if_axi_in_awvalid    ,
  input  wire                                    if_axi_in_awready    ,
  output wire [C_IF_AXI_IN_ADDR_WIDTH-1:0]       if_axi_in_awaddr     ,
  output wire [8-1:0]                            if_axi_in_awlen      ,
  output wire                                    if_axi_in_wvalid     ,
  input  wire                                    if_axi_in_wready     ,
  output wire [C_IF_AXI_IN_DATA_WIDTH-1:0]       if_axi_in_wdata      ,
  output wire [C_IF_AXI_IN_DATA_WIDTH/8-1:0]     if_axi_in_wstrb      ,
  output wire                                    if_axi_in_wlast      ,
  input  wire                                    if_axi_in_bvalid     ,
  output wire                                    if_axi_in_bready     ,
  output wire                                    if_axi_in_arvalid    ,
  input  wire                                    if_axi_in_arready    ,
  output wire [C_IF_AXI_IN_ADDR_WIDTH-1:0]       if_axi_in_araddr     ,
  output wire [8-1:0]                            if_axi_in_arlen      ,
  input  wire                                    if_axi_in_rvalid     ,
  output wire                                    if_axi_in_rready     ,
  input  wire [C_IF_AXI_IN_DATA_WIDTH-1:0]       if_axi_in_rdata      ,
  input  wire                                    if_axi_in_rlast      ,
  // AXI4 master interface if_axi_out
  output wire                                    if_axi_out_awvalid   ,
  input  wire                                    if_axi_out_awready   ,
  output wire [C_IF_AXI_OUT_ADDR_WIDTH-1:0]      if_axi_out_awaddr    ,
  output wire [8-1:0]                            if_axi_out_awlen     ,
  output wire                                    if_axi_out_wvalid    ,
  input  wire                                    if_axi_out_wready    ,
  output wire [C_IF_AXI_OUT_DATA_WIDTH-1:0]      if_axi_out_wdata     ,
  output wire [C_IF_AXI_OUT_DATA_WIDTH/8-1:0]    if_axi_out_wstrb     ,
  output wire                                    if_axi_out_wlast     ,
  input  wire                                    if_axi_out_bvalid    ,
  output wire                                    if_axi_out_bready    ,
  output wire                                    if_axi_out_arvalid   ,
  input  wire                                    if_axi_out_arready   ,
  output wire [C_IF_AXI_OUT_ADDR_WIDTH-1:0]      if_axi_out_araddr    ,
  output wire [8-1:0]                            if_axi_out_arlen     ,
  input  wire                                    if_axi_out_rvalid    ,
  output wire                                    if_axi_out_rready    ,
  input  wire [C_IF_AXI_OUT_DATA_WIDTH-1:0]      if_axi_out_rdata     ,
  input  wire                                    if_axi_out_rlast     ,
  // AXI4-Lite slave interface
  input  wire                                    s_axi_control_awvalid,
  output wire                                    s_axi_control_awready,
  input  wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_awaddr ,
  input  wire                                    s_axi_control_wvalid ,
  output wire                                    s_axi_control_wready ,
  input  wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_wdata  ,
  input  wire [C_S_AXI_CONTROL_DATA_WIDTH/8-1:0] s_axi_control_wstrb  ,
  input  wire                                    s_axi_control_arvalid,
  output wire                                    s_axi_control_arready,
  input  wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_araddr ,
  output wire                                    s_axi_control_rvalid ,
  input  wire                                    s_axi_control_rready ,
  output wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_rdata  ,
  output wire [2-1:0]                            s_axi_control_rresp  ,
  output wire                                    s_axi_control_bvalid ,
  input  wire                                    s_axi_control_bready ,
  output wire [2-1:0]                            s_axi_control_bresp  ,
  output wire                                    interrupt
);

  ///////////////////////////////////////////////////////////////////////////////
  // Local Parameters
  ///////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////////////////
  // Wires and Variables
  ///////////////////////////////////////////////////////////////////////////////
  (* DONT_TOUCH = "yes" *)
  reg                                 areset                         = 1'b0;
  wire                                ap_start                      ;
  wire                                ap_idle                       ;
  wire                                ap_done                       ;
  wire [32-1:0]                       ptr0_size_in                  ;
  wire [32-1:0]                       ptr0_size_out                 ;
  wire [64-1:0]                       ptr0_axi_in                   ;
  wire [64-1:0]                       ptr0_axi_out                  ;

  // Register and invert reset signal.
  always @(posedge ap_clk) begin
    areset <= ~ap_rst_n;
  end

  ///////////////////////////////////////////////////////////////////////////////
  // Begin control interface RTL.  Modifying not recommended.
  ///////////////////////////////////////////////////////////////////////////////


  // AXI4-Lite slave interface
  hardcloud_top_control_s_axi #(
    .C_ADDR_WIDTH ( C_S_AXI_CONTROL_ADDR_WIDTH ),
    .C_DATA_WIDTH ( C_S_AXI_CONTROL_DATA_WIDTH )
  )
  inst_control_s_axi (
    .aclk          ( ap_clk                ),
    .areset        ( areset                ),
    .aclk_en       ( 1'b1                  ),
    .awvalid       ( s_axi_control_awvalid ),
    .awready       ( s_axi_control_awready ),
    .awaddr        ( s_axi_control_awaddr  ),
    .wvalid        ( s_axi_control_wvalid  ),
    .wready        ( s_axi_control_wready  ),
    .wdata         ( s_axi_control_wdata   ),
    .wstrb         ( s_axi_control_wstrb   ),
    .arvalid       ( s_axi_control_arvalid ),
    .arready       ( s_axi_control_arready ),
    .araddr        ( s_axi_control_araddr  ),
    .rvalid        ( s_axi_control_rvalid  ),
    .rready        ( s_axi_control_rready  ),
    .rdata         ( s_axi_control_rdata   ),
    .rresp         ( s_axi_control_rresp   ),
    .bvalid        ( s_axi_control_bvalid  ),
    .bready        ( s_axi_control_bready  ),
    .bresp         ( s_axi_control_bresp   ),
    .interrupt     ( interrupt             ),
    .ap_start      ( ap_start              ),
    .ap_done       ( ap_done               ),
    .ap_idle       ( ap_idle               ),
    .scalar00      ( ptr0_size_in          ),
    .scalar01      ( ptr0_size_out         ),
    .axi00_ptr0    ( ptr0_axi_in           ),
    .axi01_ptr0    ( ptr0_axi_out          )
  );

  ///////////////////////////////////////////////////////////////////////////////
  // Add kernel logic here.  Modify/remove example code as necessary.
  ///////////////////////////////////////////////////////////////////////////////

  hif uu_hif(ap_clk, areset);

  had #(
    .C_IF_AXI_IN_ADDR_WIDTH  ( C_IF_AXI_IN_ADDR_WIDTH  ),
    .C_IF_AXI_IN_DATA_WIDTH  ( C_IF_AXI_IN_DATA_WIDTH  ),
    .C_IF_AXI_OUT_ADDR_WIDTH ( C_IF_AXI_OUT_ADDR_WIDTH ),
    .C_IF_AXI_OUT_DATA_WIDTH ( C_IF_AXI_OUT_DATA_WIDTH )
  )
  uu_had (
    .clk                ( ap_clk             ),
    .rst                ( areset             ),
    .if_axi_in_awvalid  ( if_axi_in_awvalid  ),
    .if_axi_in_awready  ( if_axi_in_awready  ),
    .if_axi_in_awaddr   ( if_axi_in_awaddr   ),
    .if_axi_in_awlen    ( if_axi_in_awlen    ),
    .if_axi_in_wvalid   ( if_axi_in_wvalid   ),
    .if_axi_in_wready   ( if_axi_in_wready   ),
    .if_axi_in_wdata    ( if_axi_in_wdata    ),
    .if_axi_in_wstrb    ( if_axi_in_wstrb    ),
    .if_axi_in_wlast    ( if_axi_in_wlast    ),
    .if_axi_in_bvalid   ( if_axi_in_bvalid   ),
    .if_axi_in_bready   ( if_axi_in_bready   ),
    .if_axi_in_arvalid  ( if_axi_in_arvalid  ),
    .if_axi_in_arready  ( if_axi_in_arready  ),
    .if_axi_in_araddr   ( if_axi_in_araddr   ),
    .if_axi_in_arlen    ( if_axi_in_arlen    ),
    .if_axi_in_rvalid   ( if_axi_in_rvalid   ),
    .if_axi_in_rready   ( if_axi_in_rready   ),
    .if_axi_in_rdata    ( if_axi_in_rdata    ),
    .if_axi_in_rlast    ( if_axi_in_rlast    ),
    .if_axi_out_awvalid ( if_axi_out_awvalid ),
    .if_axi_out_awready ( if_axi_out_awready ),
    .if_axi_out_awaddr  ( if_axi_out_awaddr  ),
    .if_axi_out_awlen   ( if_axi_out_awlen   ),
    .if_axi_out_wvalid  ( if_axi_out_wvalid  ),
    .if_axi_out_wready  ( if_axi_out_wready  ),
    .if_axi_out_wdata   ( if_axi_out_wdata   ),
    .if_axi_out_wstrb   ( if_axi_out_wstrb   ),
    .if_axi_out_wlast   ( if_axi_out_wlast   ),
    .if_axi_out_bvalid  ( if_axi_out_bvalid  ),
    .if_axi_out_bready  ( if_axi_out_bready  ),
    .if_axi_out_arvalid ( if_axi_out_arvalid ),
    .if_axi_out_arready ( if_axi_out_arready ),
    .if_axi_out_araddr  ( if_axi_out_araddr  ),
    .if_axi_out_arlen   ( if_axi_out_arlen   ),
    .if_axi_out_rvalid  ( if_axi_out_rvalid  ),
    .if_axi_out_rready  ( if_axi_out_rready  ),
    .if_axi_out_rdata   ( if_axi_out_rdata   ),
    .if_axi_out_rlast   ( if_axi_out_rlast   ),
    .ap_start           ( ap_start           ),
    .ap_done            ( ap_done            ),
    .ap_idle            ( ap_idle            ),
    .ptr0_size_in       ( ptr0_size_in       ),
    .ptr0_size_out      ( ptr0_size_out      ),
    .ptr0_axi_in        ( ptr0_axi_in        ),
    .ptr0_axi_out       ( ptr0_axi_out       ),
    .buffer             ( uu_hif.slave       )
  );

  hip uu_hip
  (
    .clk    (ap_clk       ),
    .reset  (areset       ),
    .start  (ap_start     ),
    .done   (ap_done      ),
    .buffer (uu_hif.master)
  );

endmodule
`default_nettype wire

