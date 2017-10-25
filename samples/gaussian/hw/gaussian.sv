module gaussian #(parameter ADDR_LMT = 20)
(
  input                       Clk_400,
  input                       Resetb,
  input                       WrEn_in,
  input                       WrSop_in,
  input      [1:0]            WrLen_in,
  input      [ADDR_LMT - 1:0] WrAddr_in,
  input      [511:0]          WrDin_in,
  input      [15:0]           WrTID_in,
  output reg                  WrEn_out,
  output reg                  WrSop_out,
  output reg [1:0]            WrLen_out,
  output reg [ADDR_LMT - 1:0] WrAddr_out,
  output reg [511:0]          WrDin_out,
  output reg [15:0]           WrTID_out
);
  localparam DELAY = 1;

  reg                   WrEn[DELAY];
  reg                   WrSop[DELAY];
  reg [1:0]             WrLen[DELAY];
  reg [ADDR_LMT - 1:0]  WrAddr[DELAY];
  reg [15:0]            WrTID[DELAY];

  reg [127:0]           data_in[3];
  reg [127:0]           data_out[3];

  always_ff@(posedge Clk_400) begin
    if (!Resetb) begin
      for (int i = 0; i < 16; i++) begin
        data_in[0][8*i +: 8] <= 0;
        data_in[1][8*i +: 8] <= 0;
        data_in[2][8*i +: 8] <= 0;
      end
    end
    else begin
      if (WrEn_in) begin
        for (int i = 0; i < 16; i++) begin
          data_in[0][8*i +: 8] <= WrDin_in[32*i +: 8];
          data_in[1][8*i +: 8] <= WrDin_in[32*i +  8 +: 8];
          data_in[2][8*i +: 8] <= WrDin_in[32*i + 16 +: 8];
        end
      end
    end
  end

  always_comb begin
    for (int i = 0; i < 16; i++) begin
      WrDin_out[32*i      +: 8] = data_out[0][8*i +: 8];
      WrDin_out[32*i +  8 +: 8] = data_out[1][8*i +: 8];
      WrDin_out[32*i + 16 +: 8] = data_out[2][8*i +: 8];
      WrDin_out[32*i + 24 +: 8] = 8'h00;
    end
  end

  always_ff@(posedge Clk_400) begin
    if (!Resetb) begin
      for (int i = 0; i < DELAY; i++) begin
        WrEn[i]   <= 0;
        WrSop[i]  <= 0;
        WrLen[i]  <= 0;
        WrAddr[i] <= 0;
        WrTID[i]  <= 0;
      end
    end
    else begin
      WrEn[0]   <= WrEn_in;
      WrSop[0]  <= WrSop_in;
      WrLen[0]  <= WrLen_in;
      WrAddr[0] <= WrAddr_in;
      WrTID[0]  <= WrTID_in;

      for (int i = 1; i < DELAY; i++) begin
        WrEn[i]   <= WrEn[i - 1];
        WrSop[i]  <= WrSop[i - 1];
        WrLen[i]  <= WrLen[i - 1];
        WrAddr[i] <= WrAddr[i - 1];
        WrTID[i]  <= WrTID[i - 1];
      end
    end
  end

  always_ff@(posedge Clk_400) begin
    if (!Resetb) begin
      WrEn_out   <= 0;
      WrSop_out  <= 0;
      WrLen_out  <= 0;
      WrAddr_out <= 0;
      WrTID_out  <= 0;
    end
    else begin
      WrEn_out   <= WrEn[DELAY - 1];
      WrSop_out  <= WrSop[DELAY - 1];
      WrLen_out  <= WrLen[DELAY - 1];
      WrAddr_out <= WrAddr[DELAY - 1];
      WrTID_out  <= WrTID[DELAY - 1];
    end
  end

  gaussian_unit uu_gaussian_r_unit
  (
    .clk      (Clk_400),
    .rst_b    (Resetb),
    .valid_in (WrEn_in),
    .data_in  (data_in[0]),
    .data_out (data_out[0])
  );

  gaussian_unit uu_gaussian_g_unit
  (
    .clk      (Clk_400),
    .rst_b    (Resetb),
    .valid_in (WrEn_in),
    .data_in  (data_in[1]),
    .data_out (data_out[1])
  );

  gaussian_unit uu_gaussian_b_unit
  (
    .clk      (Clk_400),
    .rst_b    (Resetb),
    .valid_in (WrEn_in),
    .data_in  (data_in[2]),
    .data_out (data_out[2])
  );

endmodule : gaussian
