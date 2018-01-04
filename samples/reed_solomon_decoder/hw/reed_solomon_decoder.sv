// reed_solomon_decoder.sv

module reed_solomon_decoder
(
  input  logic       clk,
  input  logic       reset,
  input  logic [7:0] data_in,
  input  logic       valid_in,
  output logic [7:0] data_out,
  output logic       valid_out
);

  bit enable;

  RS_dec  uu_rs_dec
  (
    .clk        (clk),
    .reset      (reset),
    .input_byte (data_in),
    .CE         (valid_in & enable),
    .Out_byte   (data_out),
    .CEO        (valid_out),
    .Valid_out  ()
  );

  int test_in;
  int test_out;
  always@(posedge clk or posedge reset) begin
    if (reset) begin
      test_in  = 0;
      test_out = 0;
      enable   = 1;
    end
    else begin

      test_in  = (valid_in ) ? test_in  + 1 : test_in;
      test_out = (valid_out) ? test_out + 1 : test_out;

      if (valid_in || valid_out) begin
        $display("test : %d | %d", test_in, test_out);
      end
    end
  end

endmodule : reed_solomon_decoder

