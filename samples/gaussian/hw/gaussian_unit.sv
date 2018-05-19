module gaussian_unit
(
  input              clk,
  input              rst_b,
  input      [127:0] data_in,
  input              valid_in,
  output reg [127:0] data_out
);

  localparam PARALELL_UNITS =   16;
  localparam KERNEL_SIZE    = 1024;

  reg [KERNEL_SIZE*8 - 1:0] row_buffer[2];

  reg [PARALELL_UNITS - 1:0] data_in_q;
  reg [PARALELL_UNITS - 1:0] row_buffer_q[2];

  always_ff @(posedge clk) begin
    if (!rst_b) begin
      for (int i = 0; i < KERNEL_SIZE; i++) begin
        row_buffer[0][i] <= '0;
        row_buffer[1][i] <= '0;
      end
    end
    else if (valid_in) begin
      row_buffer[0] <= (row_buffer[0] << PARALELL_UNITS*8) | data_in;
      row_buffer[1] <=
        (row_buffer[1] << PARALELL_UNITS*8) |
        row_buffer[0][KERNEL_SIZE*8 - 1 -: PARALELL_UNITS*8];
    end
  end

  always_ff @(posedge clk) begin
    if (!rst_b) begin
      data_in_q       <= '0;
      row_buffer_q[0] <= '0;
      row_buffer_q[1] <= '0;
    end
    else if (valid_in) begin
      data_in_q       <= data_in[112 +: 16];
      row_buffer_q[0] <= row_buffer[0][(KERNEL_SIZE - 1)*8 - 1 -: 16];
      row_buffer_q[1] <= row_buffer[1][(KERNEL_SIZE - 1)*8 - 1 -: 16];
    end
  end

  always_ff @(posedge clk) begin
    if (!rst_b) begin
      data_out <= '0;
    end
    else if (valid_in) begin
      for (int i = 0; i < PARALELL_UNITS; i++) begin
        reg [7:0] data[3][3];
        reg [7:0] tmp;

        data[0][0] = row_buffer[1][(KERNEL_SIZE - 15)*8 - 1 + 8*(i - 0) -: 8];
        data[1][0] = row_buffer[0][(KERNEL_SIZE - 15)*8 - 1 + 8*(i - 0) -: 8];
        data[2][0] = data_in[8*(i - 0) +: 8];

        if (0 == i) begin
          data[0][1] = row_buffer_q[1][8 +: 8];
          data[1][1] = row_buffer_q[0][8 +: 8];
          data[2][1] = data_in_q[8 +: 8];
        end
        else begin
          data[0][1] = row_buffer[1][(KERNEL_SIZE - 15)*8 - 1 + 8*(i - 1) -: 8];
          data[1][1] = row_buffer[0][(KERNEL_SIZE - 15)*8 - 1 + 8*(i - 1) -: 8];
          data[2][1] = data_in[8*(i - 1) +: 8];
        end

        if ( (0 == i) | (1 == i) ) begin
          data[0][2] = row_buffer_q[1][8*i +: 8];
          data[1][2] = row_buffer_q[0][8*i +: 8];
          data[2][2] = data_in_q[8*i +: 8];
        end
        else begin
          data[0][2] = row_buffer[1][(KERNEL_SIZE - 15)*8 - 1 + 8*(i - 2) -: 8];
          data[1][2] = row_buffer[0][(KERNEL_SIZE - 15)*8 - 1 + 8*(i - 2) -: 8];
          data[2][2] = data_in[8*(i - 2) +: 8];
        end

        tmp  = data[0][0] >> 4;
        tmp += data[0][1] >> 3;
        tmp += data[0][2] >> 4;
        tmp += data[1][0] >> 3;
        tmp += data[1][1] >> 2;
        tmp += data[1][2] >> 3;
        tmp += data[2][0] >> 4;
        tmp += data[2][1] >> 3;
        tmp += data[2][2] >> 4;

        data_out[8*i +: 8] <= tmp;
      end
    end
  end

endmodule : gaussian_unit

