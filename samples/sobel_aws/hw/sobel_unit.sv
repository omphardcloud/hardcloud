module sobel_unit
(
  input              clk,
  input              rst_b,
  input              valid_in,
  input      [127:0] data_in,
  output reg [511:0] data_out,
  output reg         valid_out
);

  localparam PARALELL_UNITS = 16;
  localparam KERNEL_SIZE    = 512;

  reg [KERNEL_SIZE*8 - 1:0] row_buffer[2];

  reg [15:0] data_in_q;
  reg [15:0] row_buffer_q[2];

  always_ff @(posedge clk) begin
    if(!rst_b) begin
      valid_out <= 1'b0;
    end
    else begin
      valid_out <= valid_in;
    end
  end

  always_ff @(posedge clk) begin
    if (!rst_b) begin
      for (int i = 0; i < KERNEL_SIZE; i++) begin
        row_buffer[0][i] <= 8'h00;
        row_buffer[1][i] <= 8'h00;
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
      data_in_q       <= 0;
      row_buffer_q[0] <= 0;
      row_buffer_q[1] <= 0;
    end
    else if (valid_in) begin
      data_in_q       <= data_in[112 +: 16];
      row_buffer_q[0] <= row_buffer[0][(KERNEL_SIZE - 1)*8 - 1 -: 16];
      row_buffer_q[1] <= row_buffer[1][(KERNEL_SIZE - 1)*8 - 1 -: 16];
    end
  end

  always_ff @(posedge clk) begin
    if (!rst_b) begin
      data_out <= 0;
    end
    else if (valid_in) begin
      for (int i = 0; i < PARALELL_UNITS; i++) begin
        reg [7:0] data[3][3];
        reg [7:0] tmp;
        reg [7:0] dir_x;
        reg [7:0] dir_y;
        reg [15:0] data_x;
        reg [15:0] data_y;

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

        data_x  = -1*data[0][0];
        data_x += data[0][2];
        data_x += -2*data[1][0];
        data_x += data[1][2] << 1;
        data_x += -1*data[2][0];
        data_x += data[2][2];

        data_y  = data[0][0];
        data_y += data[0][1] << 1;
        data_y += data[0][2];
        data_y += -1*data[2][0];
        data_y += -2*data[2][1];
        data_y += -1*data[2][2];

        dir_x = data_x[7] ? ~data_x + 1 : data_x;
        dir_y = data_y[7] ? ~data_y + 1 : data_y;

        tmp = dir_x + dir_y;

        data_out[32*i +: 32] <= {8'h00, tmp, tmp, tmp};
      end
    end
  end

endmodule : sobel_unit

