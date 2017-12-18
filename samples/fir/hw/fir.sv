// fir.sv

module fir
#(
  parameter FIR_TAPS        = 40,
  parameter FIR_WIDTH       =  8,
  parameter FIR_COEFF_WIDTH = 32
)
(
  input  logic clk,
  input  logic reset,

  input  logic [FIR_WIDTH - 1:0] data_in,
  input  logic                   valid_in,
  output logic [FIR_WIDTH - 1:0] data_out,
  output logic                   valid_out
);

  logic [FIR_COEFF_WIDTH - 1:0] coeff[FIR_TAPS];

  logic [FIR_WIDTH - 1:0] data_q[FIR_TAPS];
  logic [FIR_WIDTH - 1:0] data_qq[FIR_TAPS];

  logic [FIR_WIDTH - 1:0] data_pipe0[FIR_TAPS/2];
  logic [FIR_WIDTH - 1:0] data_pipe1[FIR_TAPS/4];
  logic [FIR_WIDTH - 1:0] data_pipe2[FIR_TAPS/8];

  logic valid_pipe[5];

  assign valid_out = valid_pipe[4];

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      coeff[ 0] =  0.023;
      coeff[ 1] =  0.003;
      coeff[ 2] = -0.023;
      coeff[ 3] = -0.007;
      coeff[ 4] =  0.023;
      coeff[ 5] =  0.011;
      coeff[ 6] = -0.023;
      coeff[ 7] = -0.016;
      coeff[ 8] =  0.023;
      coeff[ 9] =  0.022;
      coeff[10] = -0.023;
      coeff[11] = -0.029;
      coeff[12] =  0.023;
      coeff[13] =  0.041;
      coeff[14] = -0.023;
      coeff[15] = -0.060;
      coeff[16] =  0.023;
      coeff[17] =  0.104;
      coeff[18] = -0.023;
      coeff[19] = -0.317;
      coeff[20] =  0.523;
      coeff[21] = -0.317;
      coeff[22] = -0.023;
      coeff[23] =  0.104;
      coeff[24] =  0.023;
      coeff[25] = -0.060;
      coeff[26] = -0.023;
      coeff[27] =  0.041;
      coeff[28] =  0.023;
      coeff[29] = -0.029;
      coeff[30] = -0.023;
      coeff[31] =  0.022;
      coeff[32] =  0.023;
      coeff[33] = -0.016;
      coeff[34] = -0.023;
      coeff[35] =  0.011;
      coeff[36] =  0.023;
      coeff[37] = -0.007;
      coeff[38] = -0.023;
      coeff[39] =  0.003;
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < 5; i++) begin
        valid_pipe[i] <= '0;
      end
    end
    else begin
      valid_pipe[0] <= valid_in;

      for (int i = 1; i < 5; i++) begin
        valid_pipe[i] <= valid_pipe[i - 1];
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < FIR_TAPS; i++) begin
        data_q[i] <= '0;
      end
    end
    else begin
      data_q[0] <= data_in;

      for (int i = 1; i < FIR_TAPS; i++) begin
        data_q[i] <= data_q[i - 1];
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < FIR_TAPS; i++) begin
        data_qq[i] <= '0;
      end
    end
    else begin
      for (int i = 0; i < FIR_TAPS; i++) begin
        data_qq[i] <= data_q[i]*coeff[i];
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < FIR_TAPS/2; i++) begin
        data_pipe0[i] <= '0;
      end
    end
    else begin
      for (int i = 0; i < FIR_TAPS/2; i++) begin
        data_pipe0[i] <= data_qq[2*i] + data_qq[2*i + 1];
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < FIR_TAPS/4; i++) begin
        data_pipe1[i] <= '0;
      end
    end
    else begin
      for (int i = 0; i < FIR_TAPS/4; i++) begin
        data_pipe1[i] <= data_pipe0[2*i] + data_pipe0[2*i + 1];
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < FIR_TAPS/8; i++) begin
        data_pipe2[i] <= '0;
      end
    end
    else begin
      for (int i = 0; i < FIR_TAPS/4; i++) begin
        data_pipe2[i] <= data_pipe1[2*i] + data_pipe1[2*i + 1];
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      data_out <= '0;
    end
    else begin
      data_out <=
        data_pipe2[0] +
        data_pipe2[1] +
        data_pipe2[2] +
        data_pipe2[3] +
        data_pipe2[4];
    end
  end

endmodule : fir

