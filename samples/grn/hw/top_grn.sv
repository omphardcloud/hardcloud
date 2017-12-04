module top_grn
#(
  parameter BLOCKS_NUMBER = 16,
  parameter VECTOR_SIZE   = 69,
  parameter TOTAL_STATES  = 96
)
(
  input  logic rst,
  input  logic clk,
  input  logic ack_write,
  output logic req_write,
  output logic finish,
  output logic [511:0] transient
);

  typedef enum logic [2:0]{
   STATE_RST,
   STATE_RUN,
   STATE_FINISH,
   STATE_START1,
   STATE_START2,
   STATE_HANDLE,
   STATE_DONE,
   STATE_SET
  } t_state;

  t_state state;

  typedef enum logic [2:0]{
   STATE_WAIT,
   STATE_RELEASE,
   STATE_WRITE
  } t2_state;

  t2_state state_aux;


  wire done_in[BLOCKS_NUMBER-1:0];
  wire [31:0] length_out[BLOCKS_NUMBER];
  wire [31:0] transient_wire[BLOCKS_NUMBER];
  wire [VECTOR_SIZE - 1:0] conf_out[BLOCKS_NUMBER];

  logic request_signal;
  logic release_signal;
  logic done_out[BLOCKS_NUMBER];
  logic start_block[BLOCKS_NUMBER];
  logic [31:0] blocks_running;
  logic [31:0] transient_reg[BLOCKS_NUMBER];
  logic [31:0] block_ID;
  logic [31:0] buffer;
  logic [VECTOR_SIZE - 1:0] conf_init[BLOCKS_NUMBER];

  genvar i;
  generate
    for (i=0; i<BLOCKS_NUMBER; i=i+1) begin : gen_grn
      grn block (
        .clk           (clk),
        .rst           (rst),
        .start_in      (start_block[i]),
        .done_in       (done_out[i]),
        .conf_in       (conf_init[i]),
        .conf_out      (conf_out[i]),
        .length_out    (length_out[i]),
        .transient_out (transient_wire[i]),
        .done_out      (done_in[i])
      );
    end
  endgenerate

  always @ (posedge clk) begin
    transient_reg <= transient_wire;
  end

  always @ (posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
      transient      <= '0;
      buffer         <= '0;
      release_signal <= '0;
      req_write      <= 1'b0;

      state_aux <= STATE_WAIT;
    end
    else begin
      case(state_aux)
        STATE_WAIT:
          begin
            if(request_signal==1'b1) begin
              transient[buffer*32     +: 32]<= transient_reg[block_ID];
              transient[(buffer+1)*32 +: 32] <= conf_out[block_ID];

              if(buffer < 14) begin
                buffer         <= buffer + 2;
                release_signal <= 1;

                state_aux <= STATE_RELEASE;
              end
              else begin
                buffer         <= '0;
                release_signal <= 1'b1;
                req_write      <= 1'b1;

                state_aux <= STATE_WRITE;
              end
            end
          end

        STATE_RELEASE:
          begin
            release_signal <= 1'b0;

            state_aux <= STATE_WAIT;
          end

        STATE_WRITE:
          begin
            release_signal <= 1'b0;

            if(ack_write == 1'b1) begin
              req_write <= 1'b0;

              state_aux <= STATE_WAIT;
            end
          end
      endcase
    end
  end

  logic [31:0] states_count;

  always @ (posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
      blocks_running <= '0;
      request_signal <= '0;
      states_count   <= '0;
      finish         <= '0;

      for (int i = 0; i < BLOCKS_NUMBER; i++) begin
        start_block[i] <= '0;
        done_out[i]    <= '0;
        conf_init[i]   <= '0;
      end

      state <= STATE_RST;
    end
    else begin
      case(state)
      STATE_RST:
        begin
          state <= STATE_START1;
        end

      STATE_START1:
        begin
          for (int x = 0; x < BLOCKS_NUMBER; x = x + 1) begin
             conf_init[x]   <= x;
             start_block[x] <= 1;
           end

           states_count   <= BLOCKS_NUMBER;
           blocks_running <= BLOCKS_NUMBER;

           state <= STATE_START2;
        end

      STATE_START2:
        begin
          for (int x = 0; x < BLOCKS_NUMBER; x = x + 1) begin
            start_block[x] <= 1'b0; // TODO
          end

          state <= STATE_RUN;
        end

      STATE_RUN:
        begin
          state <= STATE_RUN;

          for (int x = 0; x < BLOCKS_NUMBER; x = x+1) begin
             if(done_in[x]==1'b1) begin //TODO
               request_signal <= 1'b1;
               state          <= STATE_HANDLE;
               block_ID       <= x;
             end
          end
        end

      STATE_HANDLE:
        begin
          if(release_signal == 1'b1) begin
            request_signal <= 1'b0;

            if(states_count == TOTAL_STATES) begin
              if (blocks_running == 1) begin
                state <= STATE_FINISH;
              end
              else begin
                blocks_running     <= blocks_running - 1;
                done_out[block_ID] <= 1;

                state <= STATE_DONE;
              end
            end
            else begin
              conf_init[block_ID]   <= states_count;
              start_block[block_ID] <= 1;
              states_count          <= states_count + 1;

              state <= STATE_SET;
            end
          end
        end

      STATE_DONE:
        begin // TODO
          done_out[block_ID] <= 0;

          state <= STATE_RUN;
        end

      STATE_SET:
        begin
           start_block[block_ID] <= 0;

           state <= STATE_RUN;
        end

      STATE_FINISH:
        begin
          finish <= 1'b1;
        end

      default:
        begin
          state <= STATE_FINISH;
        end

      endcase
    end
  end

endmodule : top_grn

