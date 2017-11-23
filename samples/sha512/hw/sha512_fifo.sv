// sha512_fifo.sv

import sha512_pkg::*;

module sha512_fifo
#(
  parameter SHA512_FIFO_DEPTH = 8
)
(
  input  logic clk,
  input  logic reset,

  input  logic [511:0] enq_data,
  input  logic         enq_en,
  output logic         not_full,

  output logic [511:0] deq_data[2],
  input  logic         deq_en,
  output logic         not_empty,

  output logic [SHA512_FIFO_DEPTH/2 - 1:0] dec_counter
);

  logic [$clog2(SHA512_FIFO_DEPTH) - 1:0] wr_pointer;
  logic [$clog2(SHA512_FIFO_DEPTH) - 1:0] rd_pointer;
  logic [SHA512_FIFO_DEPTH/2 - 1:0] counter;

  t_block mem[SHA512_FIFO_DEPTH];

  assign not_full  = (counter == '1) ? 1'b0 : 1'b1;
  assign not_empty = (counter >=  2) ? 1'b1 : 1'b0;

  assign deq_data[1]  = mem[rd_pointer + 1];
  assign deq_data[0]  = mem[rd_pointer];

  assign dec_counter = SHA512_FIFO_DEPTH - counter;

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      wr_pointer <= '0;
    end
    else begin
      if (enq_en && not_full) begin
        wr_pointer <= wr_pointer + 1;
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      rd_pointer <= '0;
    end
    else begin
      if (deq_en && not_empty) begin
        rd_pointer <= rd_pointer + 2;
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      counter <= '0;
    end
    else begin
      if (enq_en && !deq_en && not_full) begin
        counter <= counter + 1;
      end
      else if (!enq_en && deq_en && not_empty) begin
        counter <= counter - 2;
      end
      else if (enq_en && deq_en && not_full && not_empty) begin
        counter <= counter - 1;
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < SHA512_FIFO_DEPTH; i++) begin
        mem[i] <= '0;
      end
    end
    else begin
      if (enq_en && not_full) begin
        mem[wr_pointer] <= enq_data;
      end
    end
  end

endmodule : sha512_fifo

