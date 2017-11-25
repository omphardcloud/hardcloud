// aes128.sv

module aes128
(
  input  logic         clk,
  input  logic         reset,
  input  logic [127:0] key_in,
  input  logic         key_valid_in,
  input  logic [127:0] data_in,
  input  logic         valid_in,
  output logic [127:0] data_out,
  output logic         valid_out
);

  aes128_core uu_aes128_core
  (
    .clk                (clk),
    .reset              (!reset),
    .cipher_key         (key_in),
    .cipherkey_valid_in (key_valid_in),
    .plain_text         (data_in),
    .data_valid_in      (valid_in),
    .cipher_text        (data_out),
    .valid_out          (valid_out)
  );

endmodule : aes128

