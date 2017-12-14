// grn_requestor.sv

import ccip_if_pkg::*;
import grn_pkg::*;

module grn_requestor
(
  input  logic           clk,
  input  logic           reset,
  input  logic [31:0]    hc_control,
  input  t_hc_address    hc_dsm_base,
  input  t_hc_buffer     hc_buffer[HC_BUFFER_SIZE],
  input  logic [511:0]   transient_in,
  input  logic           req_write_in,
  input  logic           finish,
  input  t_if_ccip_Rx    ccip_rx,
  output t_if_ccip_c0_Tx ccip_c0_tx,
  output t_if_ccip_c1_Tx ccip_c1_tx,
  output logic           top_grn_reset,
  output logic           ack_write
);

  //
  // read state FSM
  //
  always_ff@(posedge clk) begin
    ccip_c0_tx.valid <= 1'b0;
  end

  //
  // write state FSM
  //

  t_wr_state wr_state;
  t_wr_state wr_next_state;

  t_ccip_clAddr wr_offset;
  t_ccip_clAddr wr_rsp_cnt;

  t_ccip_c1_ReqMemHdr wr_hdr;

  logic req_write;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      req_write <= 1'b0;
    end
    else begin
      if (!ccip_rx.c1TxAlmFull) begin
        req_write <= req_write_in;
      end
    end
  end

  // reset
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      top_grn_reset <= 1'b1;
    end
    else begin
      if (hc_control == HC_CONTROL_START) begin
        top_grn_reset <= 1'b0;
      end
    end
  end

  // Receive data (write responses).
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      wr_rsp_cnt <= '0;
    end
    else begin
      if ((ccip_rx.c1.rspValid) &&
        (ccip_rx.c1.hdr.resp_type == eRSP_WRLINE)) begin

        wr_rsp_cnt <= t_ccip_clAddr'(wr_rsp_cnt + 1);
      end
    end
  end

  always_ff @(posedge clk) begin
    if (reset) begin
      wr_offset <= '0;
      ack_write <= 1'b0;

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
          ack_write <= 1'b0;
        end

      S_WR_DATA:
        begin
          if (!ccip_rx.c1TxAlmFull && !req_write && req_write_in) begin
            wr_hdr.address = hc_buffer[0].address + wr_offset;
            wr_hdr.sop = 1'b1;

            ccip_c1_tx.hdr   <= wr_hdr;
            ccip_c1_tx.valid <= 1'b1;
            ccip_c1_tx.data  <= t_ccip_clData'(transient_in);
            wr_offset        <= t_ccip_clAddr'(wr_offset + 1);

            ack_write <= 1'b1;
          end
          else begin
            ccip_c1_tx.valid <= 1'b0;
            ack_write <= 1'b0;
          end
        end

      S_WR_FINISH_1:
        begin
          if (!ccip_rx.c1TxAlmFull && (wr_rsp_cnt == hc_buffer[0].size)) begin
            wr_hdr.address = hc_dsm_base;
            wr_hdr.sop = 1'b1;

            ccip_c1_tx.hdr   <= wr_hdr;
            ccip_c1_tx.valid <= 1'b1;
            ccip_c1_tx.data  <= t_ccip_clData'('h1);
          end
          else begin
            ccip_c1_tx.valid <= 1'b0;
            ack_write <= 1'b0;
          end
        end

      S_WR_FINISH_2:
        begin
          ccip_c1_tx.valid <= 1'b0;
          ack_write <= 1'b0;
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
            wr_next_state = S_WR_DATA;
          end
        end

      S_WR_DATA:
        begin
          if (!req_write && req_write_in && wr_offset == hc_buffer[0].size - 1) begin
            wr_next_state <= S_WR_FINISH_1;
          end
        end

      S_WR_FINISH_1:
        begin
          if (!ccip_rx.c1TxAlmFull && (wr_rsp_cnt == hc_buffer[0].size)) begin
            wr_next_state = S_WR_FINISH_2;
          end
        end
    endcase
  end

endmodule : grn_requestor

