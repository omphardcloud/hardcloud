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
  input  logic [511:0]   digest,
  input  logic           digest_valid,
  input  logic           ready,
  input  t_if_ccip_Rx    ccip_rx,
  output t_if_ccip_c0_Tx ccip_c0_tx,
  output t_if_ccip_c1_Tx ccip_c1_tx,
  output logic [511:0]   block,
  output logic           block_valid
);

  t_block mem_block[4];

  logic prev_digest_valid;

  //
  // send data to sha512
  //

  logic [1:0]   ptr;
  t_ccip_clAddr rd_offset;
  t_ccip_clAddr rd_rsp_cnt;

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      ptr <= 2'b00;
    end
    else begin
      if ((ready == 1'b1) && (mem_block[ptr].dirty == 1'b1)) begin
        block       <= mem_block[ptr].data;
        block_valid <= 1'b1;
        ptr         <= ptr + 1;
      end
      else begin
        block_valid <= 1'b0;
      end
    end
  end

  //
  // read state FSM
  //

  t_rd_state rd_state;
  t_rd_state rd_next_state;

  t_ccip_c0_ReqMemHdr rd_hdr;

  logic [2:0] inital_requests_cnt;

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      ccip_c0_tx.valid    <= 1'b0;
      rd_offset           <= '0;
      inital_requests_cnt <= '0;

      rd_hdr = t_ccip_c0_ReqMemHdr'(0);
    end
    else begin
      case (rd_state)
      S_RD_IDLE:
        begin
          ccip_c0_tx.valid <= 1'b0;
        end

      S_RD_FETCH:
        begin
          if (!ccip_rx.c0TxAlmFull) begin
            rd_hdr.cl_len  = eCL_LEN_2;
            rd_hdr.address = hc_buffer[1].address + rd_offset;

            ccip_c0_tx.valid    <= 1'b1;
            ccip_c0_tx.hdr      <= rd_hdr;
            rd_offset           <= t_ccip_clAddr'(rd_offset + 2);

            if (inital_requests_cnt[2] == 0) begin
              inital_requests_cnt <= inital_requests_cnt + 1;
            end
          end
          else begin
            ccip_c0_tx.valid <= 1'b0;
          end
        end

      S_RD_WAIT_0:
        begin
          ccip_c0_tx.valid <= 1'b0;
        end

      S_RD_WAIT_1:
        begin
          ccip_c0_tx.valid <= 1'b0;
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
          rd_next_state = S_RD_FETCH;
        end
      end

    S_RD_FETCH:
      begin
        if (!ccip_rx.c0TxAlmFull && ((rd_offset + 2) == hc_buffer[1].size)) begin
          rd_next_state = S_RD_FINISH;
        end
        // else if (inital_requests_cnt[2] == 1 && !ccip_rx.c0TxAlmFull) begin
        else if (!ccip_rx.c0TxAlmFull) begin
          rd_next_state = S_RD_WAIT_0;
        end
      end

    S_RD_WAIT_0:
      begin
        if ((ccip_rx.c0.rspValid) &&
          (ccip_rx.c0.hdr.resp_type == eRSP_RDLINE)) begin
          rd_next_state = S_RD_WAIT_1;
        end
      end

    S_RD_WAIT_1:
      begin
        if ((ccip_rx.c0.rspValid) &&
          (ccip_rx.c0.hdr.resp_type == eRSP_RDLINE)) begin
          rd_next_state = S_RD_FETCH;
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

      rd_rsp_cnt <= '0;
    end
    else begin
      if ((ccip_rx.c0.rspValid) &&
        (ccip_rx.c0.hdr.resp_type == eRSP_RDLINE)) begin

        rd_rsp_cnt <= t_ccip_clAddr'(rd_rsp_cnt + 1);

        mem_block[{rd_rsp_cnt[1], ccip_rx.c0.hdr.cl_num[0]}].dirty <= 1'b1;
        mem_block[{rd_rsp_cnt[1], ccip_rx.c0.hdr.cl_num[0]}].data <=
          ccip_rx.c0.data;
      end

      if (block_valid) begin
        mem_block[(ptr - 1)%4].dirty <= 1'b0;
      end
    end
  end

  //
  // write state FSM
  //

  t_wr_state wr_state;
  t_wr_state wr_next_state;

  t_ccip_clAddr wr_offset;

  t_ccip_c1_ReqMemHdr wr_hdr;

  logic [31:0] digest_cnt;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      digest_cnt <= 'h0;
    end
    else begin
      if (digest_valid && (prev_digest_valid == 0)) begin
        digest_cnt <= digest_cnt + 1;
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      prev_digest_valid <= '0;
    end
    else begin
      prev_digest_valid <= digest_valid;
    end
  end

  always_ff @(posedge clk) begin
    if (reset) begin
      ccip_c1_tx.valid <= 1'b0;
      wr_offset        <= '0;

      wr_hdr = t_ccip_c1_ReqMemHdr'(0);
    end
    else begin
      case (wr_state)
      S_WR_IDLE:
        begin
          ccip_c1_tx.valid <= 1'b0;
        end

      S_WR_CHECK:
        begin
          ccip_c1_tx.valid <= 1'b0;
        end

      S_WR_DATA:
        begin
          if (!ccip_rx.c1TxAlmFull) begin
            wr_hdr.address = hc_buffer[0].address + wr_offset;
            wr_hdr.sop = 1'b1;

            ccip_c1_tx.hdr   <= wr_hdr;
            ccip_c1_tx.valid <= 1'b1;
            ccip_c1_tx.data  <= t_ccip_clData'(digest);
            wr_offset        <= t_ccip_clAddr'(wr_offset + 1);
          end
        end

      S_WR_FINISH_1:
        begin
          if (!ccip_rx.c1TxAlmFull) begin
            wr_hdr.address = hc_dsm_base + 1;
            wr_hdr.sop = 1'b1;

            ccip_c1_tx.hdr   <= wr_hdr;
            ccip_c1_tx.valid <= 1'b1;
            ccip_c1_tx.data  <= t_ccip_clData'('h1);
          end
        end

      S_WR_FINISH_2:
        begin
          ccip_c1_tx.valid <= 1'b0;
        end

      endcase
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      wr_state <= S_WR_IDLE;
    end
    else begin
      wr_state <= wr_next_state;
    end
  end

  always_comb begin
    wr_next_state = wr_state;

    case (wr_state)
      S_WR_IDLE:
        begin
          if (hc_control == HC_CONTROL_START) begin
            wr_next_state = S_WR_CHECK;
          end
        end

      S_WR_CHECK:
        begin
          if (digest_cnt == (hc_buffer[1].size >> 1)) begin
            wr_next_state = S_WR_DATA;
          end
        end

      S_WR_DATA:
        begin
          if (!ccip_rx.c1TxAlmFull) begin
            wr_next_state = S_WR_FINISH_1;
          end
        end

      S_WR_FINISH_1:
        begin
          if (!ccip_rx.c1TxAlmFull) begin
            wr_next_state = S_WR_FINISH_2;
          end
        end
    endcase
  end

endmodule : sha512_requestor

