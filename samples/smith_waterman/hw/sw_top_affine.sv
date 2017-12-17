parameter QUERY_LENGTH = 16;
parameter SCORE_WIDTH  = 11;

module sw_top_affine
(
  input  logic rst,
  input  logic clk,
  input  logic conf_in,
  input  logic [31:0] count_in,
  input  logic [ 7:0] data_in,
  input  logic        valid_in,
  output logic [ 7:0] data_out,
  output logic        valid_out
);

  typedef enum{
    STATE_RST,
    STATE_REQ,
    STATE_RUN,
    STATE_DONE
  } t_state;

  t_state state;
  reg [31:0] done_count;
  reg [31:0] count;

  wire [512:0] m_result;
  wire i_vld;
  wire o_vld;
  reg [QUERY_LENGTH*2-1:0] query;
  reg [31:0] CL_count;

  assign query= 0;

  // ########## CONFIGURATION MACHINE ########

  always @ (posedge clk) begin: CONF
    if (rst == 1'b1) begin
      done_count <= 1;
    end
    else begin
      if (conf_in == 1'b1) begin
        done_count <= count_in;
      end
    end
  end

  reg [31:0] aux;

  // ########## DONE MACHINE ########

  reg [512:0]temp;
  reg flag;

  always @ (posedge clk) begin: DONE
    if (rst == 1'b1) begin
      aux  <= 0;
      temp <= 0;
      flag <= 0;
    end
    else begin
      if (o_vld == 1'b1) begin
        aux <= aux+1;
      end

      if(aux == done_count << 6) begin
        flag <= 1;
        aux <= 0;
        temp[SCORE_WIDTH-2:0] <= m_result[SCORE_WIDTH-2:0];
      end
    end
  end

  reg [31:0]result;
  reg gamb;

  always @ (posedge clk) begin: RESULT
    if (rst == 1'b1) begin
      data_out  <= 0;
      valid_out <= 0;
      result    <= 0;
      gamb      <= 0;
    end
    else begin
      if (flag == 1'b1 && gamb == 0) begin
        result    <= result+1;
        valid_out <= 1'b1;
        data_out  <= temp[7:0];
        temp      <= temp >> 8;

        if (result == 64) begin
          valid_out <= 1'b0;
          gamb      <= 1;
        end
      end
    end
  end

  sw_gen_affine #(
    .LENGTH(QUERY_LENGTH),
    .SCORE_WIDTH(SCORE_WIDTH)
  ) sw
  (
    .clk(clk),
    .rst(rst),
    .i_query_length(QUERY_LENGTH-1),
    .i_local(1),
    .query(query),
    .i_vld(valid_in),
    .i_data(data_in[1:0]),
    .o_vld(o_vld),
    .m_result(m_result)
  );

endmodule : sw_top_affine

