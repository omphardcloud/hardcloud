parameter QUERY_LENGTH = 16;
parameter SCORE_WIDTH  = 11;

module sw_top_affine
(
  input  logic rst,
  input  logic clk,
  input  logic conf_in,
  input  logic [ 31:0] count_in,
  input  logic [  7:0] data_in,
  input  logic         valid_in,
  output logic [511:0] data_out,
  output logic         valid_out
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
    if (rst) begin
      done_count <= 1;
    end
    else begin
      if (conf_in) begin
        done_count <= count_in;
      end
    end
  end

  reg [31:0] aux;

  // ########## DONE MACHINE ########

  always @ (posedge clk) begin: DONE
    if (rst) begin
      aux       <= '0;
      data_out  <= '0;
      valid_out <= '0;
    end
    else begin
      if (o_vld) begin
        aux <= aux + 1;
      end

      if(aux == done_count << 6) begin
        aux <= '0;
        data_out[SCORE_WIDTH-2:0] <= m_result[SCORE_WIDTH-2:0];
        valid_out <= 1'b1;
      end
    end
  end

  sw_gen_affine #(
    .LENGTH(QUERY_LENGTH),
    .SCORE_WIDTH(SCORE_WIDTH)
  )
  uu_sw_gen_affine
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

