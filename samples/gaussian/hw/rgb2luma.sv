module rgb2luma #(parameter ADDR_LMT=20)
(
  input                       Clk_400,
  input                       Resetb,
  input      [15:0]           RdRsp_in,
  input      [1:0]            RdRspCLnum_in,
  input      [ADDR_LMT - 1:0] RdRspAddr_in,
  input                       RdRspValid_in,
  input      [511:0]          RdData_in,
  output reg [15:0]           RdRsp_out,
  output reg [1:0]            RdRspCLnum_out,
  output reg [ADDR_LMT - 1:0] RdRspAddr_out,
  output reg                  RdRspValid_out,
  output reg [511:0]          RdData_out
);

  reg [15:0]           RdRsp_q;
  reg [1:0]            RdRspCLnum_q;
  reg [ADDR_LMT - 1:0] RdRspAddr_q;
  reg                  RdRspValid_q;
  reg [511:0]          RdData_q;

  always_ff@(posedge Clk_400) begin
    RdRsp_q      <= RdRsp_in;
    RdRspCLnum_q <= RdRspCLnum_in;
    RdRspAddr_q  <= RdRspAddr_in;
    RdRspValid_q <= RdRspValid_in;
    RdData_q     <= RdData_in;

    RdRsp_out      <= RdRsp_q;
    RdRspCLnum_out <= RdRspCLnum_q;
    RdRspAddr_out  <= RdRspAddr_q;
    RdRspValid_out <= RdRspValid_q;
  end

  int itr = 0;
  always_ff@(posedge Clk_400) begin
    if (!Resetb) begin
      for (int i = 0; i < 16; i++) begin
        RdData_out[32*i  +: 32] <= 512'h0;
      end
    end
    else begin
      for (int i = 0; i < 16; i++) begin
        if (RdRspValid_q) begin
          RdData_out[32*i  +: 32] <= {
            8'h00,
            rgb2luma(RdData_q[32*i  +: 32]),
            rgb2luma(RdData_q[32*i  +: 32]),
            rgb2luma(RdData_q[32*i  +: 32])};
        end
      end
    end
  end

  function [7:0] rgb2luma;
    input  bit [31:0] data;

    begin
      return
        (data[7:0]   >> 2) + (data[7:0]   >> 5) +
        (data[15:8]  >> 1) + (data[15:8]  >> 4) +
        (data[23:16] >> 4) + (data[23:16] >> 5);
    end
  endfunction : rgb2luma

endmodule : rgb2luma

