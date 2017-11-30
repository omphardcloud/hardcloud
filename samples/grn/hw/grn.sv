parameter SIZE = 69;

module grn (
	input logic rst, 
	input logic clk,
	input logic start_in,
	input logic done_in,
	input logic [SIZE-1:0] conf_in,
	output logic [SIZE-1:0] conf_out,
	output logic [31:0] length_out,
	output logic [31:0] transient_out,
	output logic done_out
);


typedef enum{
	STATE_RST,
   STATE_RUN,
   STATE_FINISH,
   STATE_IDLE,
	STATE_INIT
	}
	t_state;
	
	t_state state_V1, state_V2;
	
	typedef enum logic [2:0]{
	STATE_RESET,
   STATE_TRANSIENT,
   STATE_LENGTH,
   STATE_DONE,
	STATE_BUBBLE,
	STATE_CONFIG}
	c_state;
	
c_state state_control;
	
reg [SIZE-1:0] V1;
reg [SIZE-1:0] V2;

reg [SIZE:0] atractor;

reg [31:0] count;

reg [31:0] transient;
reg [31:0] length_value;

reg stop_1;
reg stop_2;


//############ FIRST INTERATION CALCULATES 1 STEP #############

always @ (posedge clk)
  begin : FSM_1
  if (rst == 1'b1) begin
	 state_V1 <= STATE_RST;
  end
  else begin
    case(state_V1)
      STATE_RST	:	begin
								state_V1 <= STATE_INIT;
							end
		STATE_INIT	: 	begin
								if(start_in == 1'b1) begin
									V1 <= conf_in;
									count <= 32'h00000000;
									state_V1 <= STATE_RUN;
								end
							end
		
		STATE_RUN 	: 	begin
								if (stop_1 == 1'b0) begin
									//V1[0] <= V1[1] ^ V1[2];
									//V1[1] <= V1[0] | V1[3];
									//V1[2] <= V1[0] & V1[3];
									//V1[3] <= V1[2] & (~V1[3]
									
									V1[0] <= V1[40];
									V1[1] <= V1[40] & ~ V1[32];
									V1[2] <= V1[35] & ~ (V1[36] | V1[6]);
									V1[3] <= ((V1[50] | V1[33]) & V1[36]) & ~ V1[2];
									V1[4] <= ~ (V1[20] & 0);
									V1[5] <= (V1[48] | V1[31]) & ~ (V1[33] | V1[36]);
									V1[6] <= (V1[7] | V1[8]) & ~ V1[21];
									V1[7] <= V1[17] & ~ (V1[10] | V1[32]);
									V1[8] <= V1[13] & ~ (V1[21] | V1[32]);
									V1[9] <= V1[46] & ~ V1[47];
									V1[10] <= V1[31];
									V1[11] <= V1[42] & V1[52];
									V1[12] <= (V1[4] | V1[48] | V1[26]) & ~ V1[20];
									V1[13] <= V1[30];
									V1[14] <= V1[34];
									V1[15] <= V1[28];
									V1[16] <= V1[64];
									V1[17] <= V1[52] | V1[16];
									V1[18] <= V1[15];
									V1[19] <= V1[59];
									V1[20] <= ~ (V1[14] | V1[2]);
									V1[21] <= (V1[31] | V1[48]) & ~ V1[43];
									V1[22] <= ~ V1[23];
									V1[23] <= (V1[2] | (V1[42] & V1[52]));
									V1[24] <= V1[19] & ~ V1[49];
									V1[25] <= V1[1] | V1[29];
									V1[26] <= ((V1[4] | V1[15]) & V1[25]) & ~ V1[20];
									V1[27] <= (V1[33] & V1[2]) & ~ (V1[20] | V1[0]);
									V1[28] <= V1[38] | V1[40];
									V1[29] <= V1[9] | V1[51] | V1[52];
									V1[30] <= (V1[3] | V1[50] | V1[9]) & ~ V1[5];
									V1[31] <= ~ V1[22];
									V1[32] <= (V1[33] | V1[44]) & ~ (V1[20] | V1[6]);
									V1[33] <= (V1[37] | V1[25] | V1[0]) & ~ V1[27];
									V1[34] <= V1[11];
									V1[35] <= (V1[14] | V1[39]) & ~ V1[37];
									V1[36] <= V1[9] & ~ V1[2];
									V1[37] <= V1[33] & ~ (V1[31] | V1[26]);
									V1[38] <= V1[9] | V1[39];
									V1[39] <= V1[14] | V1[19];
									V1[40] <= V1[52] & ~ V1[41];
									V1[41] <= V1[31] | V1[48];
									V1[42] <= V1[47];
									V1[43] <= V1[30];
									V1[44] <= V1[51] & ~ V1[26];
									V1[45] <= V1[44] | V1[31];
									V1[46] <= V1[33] | V1[17];
									V1[47] <= V1[15] | V1[52];
									V1[48] <= V1[24];
									V1[49] <= V1[48];
									V1[50] <= V1[7] & ~ V1[5];
									V1[51] <= V1[57] & ~ V1[45];
									V1[52] <= V1[54];
									V1[53] <= (V1[62] | V1[65]) & ~ V1[59];
									V1[54] <= V1[58];
									V1[55] <= V1[60] & ~ (V1[63] | V1[57]);
									V1[56] <= (V1[61] | V1[63]) & ~ (V1[62] | V1[57] | V1[60]);
									V1[57] <= V1[53];
									V1[58] <= (V1[63] | V1[66]) & ~ V1[62];
									V1[59] <= V1[58] | V1[65] | V1[31];
									V1[60] <= V1[65] | V1[55];
									V1[61] <= V1[65] | V1[58];
									V1[62] <= V1[53] | V1[55];
									V1[63] <= V1[56] | V1[64];
									V1[64] <= V1[63] & ~ V1[57];
									V1[65] <= (V1[66] | V1[54]) & ~ V1[62];
									V1[66] <= V1[31];
									V1[67] <= (V1[18] & V1[12]) & ~ (V1[32] | V1[6]);
									V1[68] <= V1[6];			
																			
									count <= count + 1;
									state_V1 <= STATE_RUN;
								end
								else begin
									state_V1 <= STATE_INIT;
								end
								end
		STATE_IDLE	:	begin
								state_V1 <= STATE_IDLE;
							end
		default : 		begin
								state_V1 <= STATE_IDLE;
							end
    endcase
  end
 end 
  
  
 // ############ SECOND INTERATION CALCULATES 2 STEP #############

always @ (posedge clk)
  begin : FSM2
  if (rst == 1'b1) begin
	 state_V2 <= STATE_RST;
  end
  else begin
    case(state_V2)
		STATE_RST	:	begin
								state_V2 <= STATE_INIT;
							end
      STATE_INIT	:	begin
								if(start_in == 1'b1) begin
									conf_out <= conf_in;
									V2 <= conf_in;
									state_V2 <= STATE_RUN;
								end
							end
		STATE_RUN 	: 	begin
								if (stop_2 == 1'b0) begin
									//V2[0] <= (V2[0] | V2[3]) ^ 	(V2[0] & V2[3]);
									//V2[1] <= (V2[1] ^ V2[2]) | 	(V2[2] & (~ V2[3]));
									//V2[2] <= (V2[1] ^ V2[2]) & 	(V2[2] & (~ V2[3]));
									//V2[3] <= (V2[0] & V2[3]) & (~ (V2[2] & (~ V2[3])));
									//  (V1[7] | V1[8]) & ~ V1[21];
									V2[0] <= (V2[52] & ~ V2[41]);
									V2[1] <= (V2[52] & ~ V2[41]) & ~ ((V2[33] | V2[44]) & ~ (V2[20] | V2[6]));
									V2[2] <= ((V2[14] | V2[39]) & ~ V2[37]) & ~ ((V2[9] & ~ V2[2]) | ((V2[7] | V2[8]) & ~ V2[21]));
									V2[3] <= (((V2[7] & ~ V2[5]) | ((V2[37] | V2[25] | V2[0]) & ~ V2[27])) & (V2[9] & ~ V2[2])) & ~ (V2[35] & ~ (V2[36] | V2[6]));
									V2[4] <= ~ ((~ (V2[14] | V2[2])) & 0);
									V2[5] <= ((V2[24]) | (~ V2[22])) & ~ (((V2[37] | V2[25] | V2[0]) & ~ V2[27]) | (V2[9] & ~ V2[2]));
									V2[6] <= ((V2[17] & ~ (V2[10] | V2[32])) | (V2[13] & ~ (V2[21] | V2[32]))) & ~ ((V2[31] | V2[48]) & ~ V2[43]);
									V2[7] <= (V2[52] | V2[16]) & ~ ((V2[31]) | ((V2[33] | V2[44]) & ~ (V2[20] | V2[6])));
									V2[8] <= (V2[30]) & ~ (((V2[31] | V2[48]) & ~ V2[43]) | ((V2[33] | V2[44]) & ~ (V2[20] | V2[6])));
									V2[9] <= (V2[33] | V2[17]) & ~ (V2[15] | V2[52]);
									V2[10] <= (~ V2[22]);
									V2[11] <= (V2[47]) & (V2[54]);
									V2[12] <= ((~ (V2[20] & 0)) | (V2[24]) | (((V2[4] | V2[15]) & V2[25]) & ~ V2[20])) & ~ (~ (V2[14] | V2[2]));
									V2[13] <= ((V2[3] | V2[50] | V2[9]) & ~ V2[5]);
									V2[14] <= (V2[11]);
									V2[15] <= (V2[38] | V2[40]);
									V2[16] <= (V2[63] & ~ V2[57]);
									V2[17] <= (V2[54]) | (V2[64]);
									V2[18] <= (V2[28]);
									V2[19] <= (V2[58] | V2[65] | V2[31]);
									V2[20] <= ~ ((V2[34]) | (V2[35] & ~ (V2[36] | V2[6])));
									V2[21] <= ((~ V2[22]) | (V2[24])) & ~ (V2[30]);
									V2[22] <= ~ ((V2[2] | (V2[42] & V2[52])));
									V2[23] <= ((V2[35] & ~ (V2[36] | V2[6])) | ((V2[47]) & (V2[54])));
									V2[24] <= (V2[59]) & ~ (V2[48]);
									V2[25] <= (V2[40] & ~ V2[32]) | (V2[9] | V2[51] | V2[52]);
									V2[26] <= (((~ (V2[20] & 0)) | (V2[28])) & (V2[1] | V2[29])) & ~ (~ (V2[14] | V2[2]));
									V2[27] <= (((V2[37] | V2[25] | V2[0]) & ~ V2[27]) & (V2[35] & ~ (V2[36] | V2[6]))) & ~ ((~ (V2[14] | V2[2])) | (V2[40]) );
									V2[28] <= (V2[9] | V2[39]) | (V2[52] & ~ V2[41]);
									V2[29] <= (V2[46] & ~ V2[47]) | (V2[57] & ~ V2[45]) | (V2[54]);
									V2[30] <= ((((V2[50] | V2[33]) & V2[36]) & ~ V2[2]) | (V2[7] & ~ V2[5]) | (V2[46] & ~ V2[47])) & ~ ((V2[48] | V2[31]) & ~ (V2[33] | V2[36]));
									V2[31] <= ~ (~V2[23]);
									V2[32] <= (((V2[37] | V2[25] | V2[0]) & ~ V2[27]) | (V2[51] & ~ V2[26])) & ~ ((~ (V2[14] | V2[2])) | ((V2[7] | V2[8]) & ~ V2[21]));
									V2[33] <= ((V2[33] & ~ (V2[31] | V2[26])) | (V2[1] | V2[29]) | (V2[40]) ) & ~ ((V2[33] & V2[2]) & ~ (V2[20] | V2[0]));
									V2[34] <= (V2[42] & V2[52]);
									V2[35] <= ((V2[34]) | (V2[14] | V2[19])) & ~ (V2[33] & ~ (V2[31] | V2[26]));
									V2[36] <= (V2[46] & ~ V2[47]) & ~ (V2[35] & ~ (V2[36] | V2[6]));
									V2[37] <= ((V2[37] | V2[25] | V2[0]) & ~ V2[27]) & ~ ((~ V2[22]) | (((V2[4] | V2[15]) & V2[25]) & ~ V2[20]));
									V2[38] <= (V2[46] & ~ V2[47]) | (V2[14] | V2[19]);
									V2[39] <= (V2[34]) | (V2[59]);
									V2[40] <= (V2[54]) & ~ (V2[31] | V2[48]);
									V2[41] <= (~ V2[22]) | (V2[24]);
									V2[42] <= (V2[15] | V2[52]);
									V2[43] <= ((V2[3] | V2[50] | V2[9]) & ~ V2[5]);
									V2[44] <= (V2[57] & ~ V2[45]) & ~ (((V2[4] | V2[15]) & V2[25]) & ~ V2[20]);
									V2[45] <= (V2[51] & ~ V2[26]) | (~ V2[22]);
									V2[46] <= ((V2[37] | V2[25] | V2[0]) & ~ V2[27]) | (V2[52] | V2[16]);
									V2[47] <= (V2[28]) | (V2[54]);
									V2[48] <= (V2[19] & ~ V2[49]);
									V2[49] <= (V2[24]);
									V2[50] <= (V2[17] & ~ (V2[10] | V2[32])) & ~ ((V2[48] | V2[31]) & ~ (V2[33] | V2[36]));
									V2[51] <= (V2[53]) & ~ (V2[44] | V2[31]);
									V2[52] <= (V2[58]);
									V2[53] <= ((V2[53] | V2[55]) | ((V2[66] | V2[54]) & ~ V2[62])) & ~ (V2[58] | V2[65] | V2[31]);
									V2[54] <= ((V2[63] | V2[66]) & ~ V2[62]);
									V2[55] <= (V2[65] | V2[55]) & ~ ((V2[56] | V2[64]) | (V2[53]));
									V2[56] <= ((V2[65] | V2[58]) | (V2[56] | V2[64])) & ~ ((V2[53] | V2[55]) | (V2[53]) | (V2[65] | V2[55]));
									V2[57] <= ((V2[62] | V2[65]) & ~ V2[59]);
									V2[58] <= ((V2[56] | V2[64]) | (V2[31])) & ~ (V2[53] | V2[55]);
									V2[59] <= ((V2[63] | V2[66]) & ~ V2[62]) | ((V2[66] | V2[54]) & ~ V2[62]) | (~ V2[22]);
									V2[60] <= ((V2[66] | V2[54]) & ~ V2[62]) | (V2[60] & ~ (V2[63] | V2[57]));
									V2[61] <= ((V2[66] | V2[54]) & ~ V2[62]) | ((V2[63] | V2[66]) & ~ V2[62]);
									V2[62] <= ((V2[62] | V2[65]) & ~ V2[59]) | (V2[60] & ~ (V2[63] | V2[57]));
									V2[63] <= ((V2[61] | V2[63]) & ~ (V2[62] | V2[57] | V2[60])) | (V2[63] & ~ V2[57]);
									V2[64] <= (V2[56] | V2[64]) & ~ (V2[53]);
									V2[65] <= ((V2[31]) | (V2[58])) & ~ (V2[53] | V2[55]);
									V2[66] <= (~ V2[22]);
									V2[67] <= ((V2[15]) & ((V2[4] | V2[48] | V2[26]) & ~ V2[20])) & ~ (((V2[33] | V2[44]) & ~ (V2[20] | V2[6])) | ((V2[7] | V2[8]) & ~ V2[21]));
									V2[68] <= ((V2[7] | V2[8]) & ~ V2[21]);

									
									state_V2 <= STATE_RUN;
								end
								else begin
									state_V2 <= STATE_INIT;
								end
								end
		STATE_IDLE	:	begin
								state_V2 <= STATE_IDLE;
							end
		default : 		begin
								state_V2 <= STATE_IDLE;
							end
    endcase
  end 
 end
  
 // ############ CONTROL PROCESS #############

always @ (posedge clk)
  begin : FSM_C
  if (rst == 1'b1) begin
	 state_control <= STATE_RESET;
	 stop_1 <= 1'b0;
	 stop_2 <= 1'b0;
  end
  else begin
    case(state_control)
      STATE_RESET 		:	begin
										state_control <= STATE_CONFIG;
									end
							
		STATE_CONFIG		: 	begin
										if(start_in == 1'b1) begin
											state_control <= STATE_BUBBLE;
										end
									end
		
		STATE_BUBBLE		: 	begin
										state_control <= STATE_TRANSIENT;
									end
		
		STATE_TRANSIENT 	: 	begin
										if (V1 == V2) begin
											atractor <= V2;
											transient <= count;
											transient_out<= count;
											state_control <= STATE_LENGTH;
											stop_2<=1;
										end
										else begin
											state_control <= STATE_TRANSIENT;
										end
									end
		STATE_LENGTH		:	begin
										if (V1 == atractor) begin
											done_out <= 1'b1;
											stop_1<=1;
											length_out <= count - transient;
											state_control <= STATE_DONE;
										end
										else begin
											state_control <= STATE_LENGTH;
										end
									end
		
		STATE_DONE			: 	begin
										stop_1<=0;
										stop_2<=0;
										if (start_in == 1'b1) begin
											done_out <= 1'b0;
											state_control <= STATE_BUBBLE;
										end
										if (done_in == 1'b1) begin
											done_out <= 1'b0;
											state_control <= STATE_DONE;
										end
									end
		
		default 				: 	begin
										state_control <= STATE_DONE;	
									end
    endcase
	end
  end 
  endmodule 
