// sha512_requestor.sv

import ccip_if_pkg::*;
import sha512_pkg::*;

module sha512_requestor
(
  input  logic           clk,
  input  logic           reset,
  input  logic [31:0]    hc_control,
  input  t_ccip_clAddr   hc_dsm_base,
  input  t_hc_buffer     hc_buffer[HC_BUFFER_SIZE],
  input  logic [511:0]   data_i,
  input  logic           valid_i,
  input  t_if_ccip_Rx    ccip_rx,
  output t_if_ccip_c0_Tx ccip_c0_tx,
  output t_if_ccip_c1_Tx ccip_c1_tx,
  output logic [511:0]   data_o,
  output logic           valid_o
);

  t_block mem_block[4];

  t_ccip_clAddr rd_cnt;
  t_ccip_clAddr rd_rsp_cnt;
  logic         rd_toggle;

  //
  // read state FSM
  //

  t_rd_state rd_state;
  t_rd_state rd_next_state;

  t_ccip_c0_ReqMemHdr rd_hdr;

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      ccip_c0_tx.valid <= 1'b0;
      rd_cnt           <= 0;

      rd_hdr = t_ccip_c0_ReqMemHdr'(0);
    end
    else begin
      case(rd_state)
      S_RD_IDLE:
        begin
          ccip_c0_tx.valid <= 1'b0;
        end

      S_RD_FETCH:
        begin
          if (!ccip_rx.c0TxAlmFull) begin
            rd_hdr.cl_len  = eCL_LEN_2;
            rd_hdr.address = hc_buffer[1].address + rd_cnt;

            ccip_c0_tx.valid <= 1'b1;
            ccip_c0_tx.hdr   <= rd_hdr;
            rd_cnt           <= t_ccip_clAddr'(rd_cnt + 2);
          end
          else begin
            ccip_c0_tx.valid <= 1'b0;
          end
        end

      S_RD_FINISH:
        begin
          ccip_c0_tx.valid <= 1'b0;
        end
      endcase
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      rd_state <= S_RD_IDLE;
    end
    else begin
      rd_state <= rd_next_state;
    end
  end

  always_comb begin
    rd_next_state = rd_state;

    case (rd_state)
    S_RD_IDLE:
      begin
        if (hc_control == HC_CONTROL_START) begin
          rd_next_state <= S_RD_FETCH;
        end
      end

    S_RD_FETCH:
      begin
        if (!ccip_rx.c0TxAlmFull && (rd_cnt + 2) == hc_buffer[1].size) begin
          rd_next_state <= S_RD_FINISH;
        end
      end
    endcase

  end

  // Receive data (read responses).
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < 4; i++) begin
        mem_block[i].dirty <= 1'b0;
        mem_block[i].data  <= '0;
      end

      rd_toggle  <= 1'b0;
      rd_rsp_cnt <= '0;
    end
    else begin
      if ((ccip_rx.c0.rspValid) &&
        (ccip_rx.c0.hdr.resp_type == eRSP_RDLINE)) begin

        for (int i = 0; i < 16; i++) begin
          // data[32*i +: 32] <= ccip_rx.c0.data[32*i +: 32] + 10;

          $display("recv data : ", i);
          $display(ccip_rx.c0.data[32*i +: 32]);
        end

        rd_rsp_cnt <= t_ccip_clAddr'(rd_rsp_cnt + 1);

        $display(ccip_rx.c0.hdr.cl_num);
      end
    end
  end

  //
  // write state FSM
  //

  t_wr_state wr_state;
  t_wr_state wr_next_state;

  t_ccip_c1_ReqMemHdr wr_hdr;

  always_ff @(posedge clk) begin
    if (reset) begin
      wr_state <= S_WR_IDLE;

      ccip_c1_tx.valid <= 1'b0;

      wr_hdr = t_ccip_c1_ReqMemHdr'(0);
    end
    else begin
      if (wr_state == S_WR_IDLE &&
        rd_rsp_cnt == hc_buffer[1].size &&
        !ccip_rx.c1TxAlmFull) begin

        wr_hdr.address = hc_dsm_base + 1;
        wr_hdr.sop = 1'b1;

        ccip_c1_tx.hdr   <= wr_hdr;
        ccip_c1_tx.valid <= 1'b1;
        ccip_c1_tx.data  <= t_ccip_clData'('h1);

        wr_state <= S_WR_FINISH;
      end
      else begin
        ccip_c1_tx.valid <= 1'b0;
      end
    end
  end

endmodule : sha512_requestor

