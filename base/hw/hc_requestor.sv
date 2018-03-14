// hc_requestor.sv

import ccip_if_pkg::*;
import hc_pkg::*;

module hc_requestor
(
  input  logic           clk,
  input  logic           reset,
  input  logic           finish,
  input  logic [31:0]    hc_control,
  input  t_hc_address    hc_dsm_base,
  input  t_hc_buffer     hc_buffer[HC_BUFFER_SIZE],
  input  t_if_ccip_Rx    ccip_rx,
  output logic           start,
  output t_if_ccip_c0_Tx ccip_c0_tx,
  output t_if_ccip_c1_Tx ccip_c1_tx,
  hc_buffers_if          core_buffers
);

  //
  // start or stop control
  //

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      start <= 1'b0;
    end
    else begin
      start <= (HC_CONTROL_START == hc_control) ? 1'b1 : 1'b0;
    end
  end

  //
  // buffer size
  //

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < HC_BUFFER_SIZE; i++) begin
        core_buffers.total_size[i] <= '0;
      end
    end
    else begin
      for (int i = 0; i < HC_BUFFER_SIZE; i++) begin
        core_buffers.total_size[i] <= hc_buffer[i].size;
      end
    end
  end

  //
  // buffer queue
  //
  genvar i;
  generate
    for (i = 0; i < HC_BUFFER_TX_SIZE; i++) begin
      hc_fifo
      #(
        .HC_FIFO_WIDTH($bits(t_buffer_data)),
        .HC_FIFO_DEPTH(HC_BUFFER_TX_DEPTH)
      )
      uu_hc_tx_fifo
      (
        .clk          (clk),
        .reset        (reset),
        .enq_data     (),
        .enq_en       (),
        .not_full     (),
        .deq_data     (),
        .deq_en       (),
        .not_empty    (),
        .counter      (),
        .dec_counter  ()
      );
    end
  endgenerate

  genvar j;
  generate
    for (j = 0; j < HC_BUFFER_RX_SIZE; j++) begin
      hc_fifo
      #(
        .HC_FIFO_WIDTH($bits(t_buffer_data)),
        .HC_FIFO_DEPTH(HC_BUFFER_RX_DEPTH)
      )
      uu_hc_rx_fifo
      (
        .clk          (clk),
        .reset        (reset),
        .enq_data     (),
        .enq_en       (),
        .not_full     (),
        .deq_data     (),
        .deq_en       (),
        .not_empty    (),
        .counter      (),
        .dec_counter  ()
      );
    end
  endgenerate

  //
  // read request queue
  //

  logic read_request_enq_en;
  logic read_request_deq_en;
  logic read_request_not_empty;
  logic read_request_not_full;

  t_request_control read_request_deq_data;

  assign read_request_enq_en =
    (e_REQUEST_READ_STREAM  == core_buffers.read_request.control.cmd) |
    (e_REQUEST_READ_INDEXED == core_buffers.read_request.control.cmd);

  assign core_buffers.read_request.status.empty = !read_request_not_empty;
  assign core_buffers.read_request.status.full  = !read_request_not_full;

  hc_fifo
  #(
    .HC_FIFO_WIDTH($bits(t_request_control)),
    .HC_FIFO_DEPTH(HC_REQUEST_DEPTH)
  )
  uu_hc_read_request_fifo
  (
    .clk          (clk),
    .reset        (reset),
    .enq_data     (core_buffers.read_request.control),
    .enq_en       (read_request_enq_en),
    .not_full     (read_request_not_full),
    .deq_data     (read_request_deq_data),
    .deq_en       (read_request_deq_en),
    .not_empty    (read_request_not_empty),
    .counter      (core_buffers.read_request.status.count),
    .dec_counter  ()
  );

  //
  // read state FSM
  //

  t_request_control read_request;

  t_rd_state rd_state;
  t_rd_state rd_next_state;

  t_ccip_clAddr rd_offset;
  t_ccip_clAddr rd_rsp_cnt;

  t_ccip_c0_ReqMemHdr rd_hdr;

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      read_request <= '0;
    end
    else begin
      if ((S_RD_IDLE == rd_state) && read_request_not_empty) begin
        read_request <= read_request_deq_data;
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      read_request_deq_en <= '0;
    end
    else begin
      if (read_request_deq_en) begin
        $display("toggle dequeue");
        read_request_deq_en <= 1'b0;
      end
      if ((S_RD_IDLE == rd_state) && read_request_not_empty) begin
        $display("dequeue", read_request_deq_data.offset);
        read_request_deq_en <= 1'b1;
      end
      else begin
        read_request_deq_en <= 1'b0;
      end
    end
  end

  // if (rd_state == S_RD_STREAM && !ccip_rx.c0TxAlmFull) begin
  //   rd_offset <= t_ccip_clAddr'(rd_offset + 1);
  // end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      rd_offset <= '0;
    end
    else begin
      if (rd_state == S_RD_STREAM && !ccip_rx.c0TxAlmFull) begin
        rd_offset <= t_ccip_clAddr'(rd_offset + 1);
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      ccip_c0_tx.valid <= 1'b0;

      rd_hdr = t_ccip_c0_ReqMemHdr'(0);
    end
    else begin
      case (rd_state)
      S_RD_START:
        begin
          ccip_c0_tx.valid <= 1'b0;
        end

      S_RD_IDLE:
        begin
          ccip_c0_tx.valid <= 1'b0;
        end

      S_RD_STREAM:
        begin
          if (!ccip_rx.c0TxAlmFull) begin
            rd_hdr.cl_len  = eCL_LEN_1;
            rd_hdr.address = hc_buffer[1].address + rd_offset;

            ccip_c0_tx.valid <= 1'b1;
            ccip_c0_tx.hdr   <= rd_hdr;
          end
          else begin
            ccip_c0_tx.valid <= 1'b0;
          end
        end

      S_RD_INDEX:
        begin
          if (!ccip_rx.c0TxAlmFull) begin
            $display("index 3 - ", hc_buffer[read_request.id].address, read_request.offset);

            rd_hdr.cl_len  = eCL_LEN_1;
            rd_hdr.address =
              hc_buffer[read_request.id].address + read_request.offset;

            ccip_c0_tx.valid <= 1'b1;
            ccip_c0_tx.hdr   <= rd_hdr;
          end
          else begin
            ccip_c0_tx.valid <= 1'b0;
          end
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
    S_RD_START:
      begin
        if (HC_CONTROL_START == hc_control) begin
          rd_next_state = S_RD_IDLE;
        end
      end

    S_RD_IDLE:
      begin
        if (read_request_not_empty) begin
          if (e_REQUEST_READ_STREAM == read_request_deq_data.cmd) begin
            rd_next_state = S_RD_STREAM;
          end
          else if (e_REQUEST_READ_INDEXED == read_request_deq_data.cmd) begin
            $display("index 1", read_request_deq_data.offset);
            rd_next_state = S_RD_INDEX;
          end
        end
      end

    S_RD_STREAM:
      begin
        if (!ccip_rx.c0TxAlmFull) begin
          rd_next_state = S_RD_IDLE;
        end
      end

    S_RD_INDEX:
      begin
        if (!ccip_rx.c0TxAlmFull) begin
          $display("index 2");
          rd_next_state = S_RD_IDLE;
        end
      end

    endcase
  end

  //
  // write state FSM
  //

  t_wr_state wr_state;
  t_wr_state wr_next_state;

  t_ccip_clAddr wr_offset;
  t_ccip_clAddr wr_rsp_cnt;

  t_ccip_c1_ReqMemHdr wr_hdr;

  logic [31:0] dispatch_fifo_size;

  always_ff @(posedge clk) begin
    if (reset) begin
      wr_offset  <= '0;

      dispatch_fifo_size <= 0;

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

      S_WR_RUN:
        begin
          ccip_c1_tx.valid <= 1'b0;
        end

      S_WR_FINISH_1:
        begin
          if (!ccip_rx.c1TxAlmFull) begin
            wr_hdr.address = hc_dsm_base;
            wr_hdr.sop = 1'b1;

            ccip_c1_tx.hdr   <= wr_hdr;
            ccip_c1_tx.valid <= 1'b1;
            ccip_c1_tx.data  <= t_ccip_clData'('h1);
          end
          else begin
            ccip_c1_tx.valid <= 1'b0;
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
            wr_next_state = S_WR_RUN;
          end
        end

      S_WR_RUN:
        begin
          if ((finish == 1) && (dispatch_fifo_size == 0)) begin
            wr_next_state <= S_WR_FINISH_1;
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

endmodule : hc_requestor

