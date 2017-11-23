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
  output logic [511:0]   block[2],
  output logic           block_valid
);

  logic prev_digest_valid;

  t_block enq_data;
  t_block deq_data[2];

  logic enq_en;
  logic not_full;
  logic deq_en;
  logic not_empty;

  logic [3:0] dec_counter;

  sha512_fifo uu_sha512_fifo
  (
    .clk         (clk),
    .reset       (reset),
    .enq_data    (enq_data),
    .enq_en      (enq_en),
    .not_full    (not_full),
    .deq_data    (deq_data),
    .deq_en      (deq_en),
    .not_empty   (not_empty),
    .dec_counter (dec_counter)
  );

  //
  // send data to sha512
  //

  t_ccip_clAddr rd_offset;
  t_ccip_clAddr rd_rsp_cnt;

  logic wait_digest_valid;

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      wait_digest_valid <= 1'b0;
    end
    else begin
      if (ready && not_empty && !wait_digest_valid) begin
        wait_digest_valid <= 1'b1;
      end
      else if (digest_valid) begin
        wait_digest_valid <= 1'b0;
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      block[0]    <= '0;
      block[1]    <= '0;
      block_valid <= '0;
      deq_en      <= '0;
    end
    else begin
      if (ready && not_empty && !wait_digest_valid) begin
        block       <= deq_data;
        block_valid <= 1'b1;
        deq_en      <= 1'b1;
      end
      else begin
        block_valid <= 1'b0;
        deq_en      <= 1'b0;
      end
    end
  end

  //
  // read state FSM
  //

  logic [31:0] cnt_request;

  t_rd_state rd_state;
  t_rd_state rd_next_state;

  t_ccip_c0_ReqMemHdr rd_hdr;

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      cnt_request <= '0;
    end
    else begin
      logic [31:0] request;
      logic [31:0] response;

      if ((rd_state == S_RD_FETCH) &&
        ((dec_counter - cnt_request) >= 2) &&
        !ccip_rx.c0TxAlmFull) begin

        request = 2;
      end
      else begin
        request = 0;
      end

      if ((ccip_rx.c0.rspValid) &&
        (ccip_rx.c0.hdr.resp_type == eRSP_RDLINE)) begin
        response = 1;
      end
      else begin
        response = 0;
      end

      cnt_request <= cnt_request + request - response;
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      ccip_c0_tx.valid    <= 1'b0;
      rd_offset           <= '0;

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
          if ((dec_counter - cnt_request) < 2) begin
            ccip_c0_tx.valid <= 1'b0;
          end
          else if (!ccip_rx.c0TxAlmFull) begin
            rd_hdr.cl_len  = eCL_LEN_2;
            rd_hdr.address = hc_buffer[1].address + rd_offset;

            ccip_c0_tx.valid    <= 1'b1;
            ccip_c0_tx.hdr      <= rd_hdr;
            rd_offset           <= t_ccip_clAddr'(rd_offset + 2);
          end
          else begin
            ccip_c0_tx.valid <= 1'b0;
          end
        end

      S_RD_WAIT:
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
        if ((dec_counter - cnt_request) < 2) begin
          rd_next_state = S_RD_WAIT;
        end
        else if (!ccip_rx.c0TxAlmFull && ((rd_offset + 2) == hc_buffer[1].size)) begin
          rd_next_state = S_RD_FINISH;
        end
      end

    S_RD_WAIT:
      begin
        if ((dec_counter - cnt_request) >= 2) begin
          rd_next_state = S_RD_FETCH;
        end
      end

    endcase
  end

  // Receive data (read responses).
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      rd_rsp_cnt <= '0;
    end
    else begin
      if ((ccip_rx.c0.rspValid) &&
        (ccip_rx.c0.hdr.resp_type == eRSP_RDLINE)) begin

        rd_rsp_cnt <= t_ccip_clAddr'(rd_rsp_cnt + 1);

        enq_en   <= 1'b1;
        enq_data <= ccip_rx.c0.data;
      end
      else begin
        enq_en <= 1'b0;
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
      wr_offset <= '0;

      wr_hdr = t_ccip_c1_ReqMemHdr'(0);
      ccip_c1_tx.hdr   <= wr_hdr;
      ccip_c1_tx.valid <= 1'b0;
      ccip_c1_tx.data  <= t_ccip_clData'('0);
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
          if (digest_cnt == hc_buffer[1].size[31:1]) begin
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

