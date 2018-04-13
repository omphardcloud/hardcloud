// hc_requestor.sv

import ccip_if_pkg::*;
import hc_user_pkg::*;
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
  hc_buffers_if          core_buffer
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
        core_buffer.buffer_size[HC_MAX_BUFFER_SIZE*i +: HC_MAX_BUFFER_SIZE]
          <= '0;
      end
    end
    else begin
      for (int i = 0; i < HC_BUFFER_SIZE; i++) begin
        core_buffer.buffer_size[HC_MAX_BUFFER_SIZE*i +: HC_MAX_BUFFER_SIZE]
          <= hc_buffer[i].size;
      end
    end
  end

  //
  // read request queue
  //

  logic read_request_enq_en;
  logic read_request_deq_en;
  logic read_request_not_empty;
  logic read_request_not_full;

  t_request_size read_request_counter;

  t_request_control read_request_deq_data;

  assign read_request_enq_en =
    (e_REQUEST_READ_STREAM  == core_buffer.read_request.control.cmd) |
    (e_REQUEST_READ_INDEXED == core_buffer.read_request.control.cmd);

  hc_fifo
  #(
    .HC_FIFO_WIDTH($bits(t_request_control)),
    .HC_FIFO_DEPTH(HC_READ_REQUEST_FIFO_DEPTH)
  )
  uu_hc_read_request_fifo
  (
    .clk          (clk),
    .reset        (reset),
    .enq_data     (core_buffer.read_request.control),
    .enq_en       (read_request_enq_en),
    .not_full     (read_request_not_full),
    .deq_data     (read_request_deq_data),
    .deq_en       (read_request_deq_en),
    .not_empty    (read_request_not_empty),
    .counter      (read_request_counter),
    .dec_counter  ()
  );

  always_ff@(posedge clk) begin
    core_buffer.read_request.status.count <= read_request_counter;
    core_buffer.read_request.status.empty <= !read_request_not_empty;
    core_buffer.read_request.status.full  <=
      read_request_counter > (HC_READ_REQUEST_FIFO_DEPTH - 4);
  end

  //
  // read state FSM
  //
  t_rd_state rd_state;
  t_rd_state rd_next_state;

  t_ccip_clAddr rd_offset[HC_BUFFER_SIZE];
  t_ccip_c0_ReqMemHdr rd_hdr;

  t_request_control read_request;

  logic [10:0] read_stream_size;

  always_comb begin
    read_request_deq_en =
      !ccip_rx.c0TxAlmFull && (S_RD_IDLE == rd_state) && read_request_not_empty;
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      read_request <= '0;
    end
    else begin
      if (read_request_deq_en) begin
        read_request <= read_request_deq_data;
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      read_stream_size <= '0;
    end
    else begin
      if (S_RD_IDLE == rd_state) begin
        read_stream_size <= '0;
      end
      else if (S_RD_STREAM == rd_state) begin
        read_stream_size <= read_stream_size + !ccip_rx.c0TxAlmFull;
      end
    end
  end

  always_ff@(posedge clk or posedge reset) begin
    if (reset) begin
      ccip_c0_tx.valid <= 1'b0;

      rd_hdr = t_ccip_c0_ReqMemHdr'('0);

      for (int i = 0; i < HC_BUFFER_SIZE; i++) begin
        rd_offset[i] <= t_ccip_clAddr'('0);
      end
    end
    else begin

      rd_hdr.cl_len  = eCL_LEN_1;
      rd_hdr.address =
        hc_buffer[read_request.id].address + rd_offset[read_request.id];

      ccip_c0_tx.hdr <= rd_hdr;

      case (rd_state)
      S_RD_START:
        begin
          ccip_c0_tx.valid <= 1'b0;
        end

      S_RD_IDLE:
        begin
          ccip_c0_tx.valid <= 1'b0;
        end

      S_RD_PROCESS:
        begin
          ccip_c0_tx.valid <= 1'b0;

          if (S_RD_INDEX == t_rd_state'(read_request.cmd)) begin
            rd_offset[read_request.id] <= read_request.offset;
          end
        end

      S_RD_STREAM:
        begin
          ccip_c0_tx.valid <= !ccip_rx.c0TxAlmFull;

          rd_offset[read_request.id] <=
            t_ccip_clAddr'(rd_offset[read_request.id] + !ccip_rx.c0TxAlmFull);
        end

      S_RD_INDEX:
        begin
          ccip_c0_tx.valid <= !ccip_rx.c0TxAlmFull;

          rd_offset[read_request.id] <=
            t_ccip_clAddr'(rd_offset[read_request.id] + !ccip_rx.c0TxAlmFull);
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
        if (!ccip_rx.c0TxAlmFull && read_request_not_empty) begin
          rd_next_state = S_RD_PROCESS;
        end
      end

    S_RD_PROCESS:
      begin
        rd_next_state = t_rd_state'(read_request.cmd);
      end

    S_RD_STREAM:
      begin
        if ((read_stream_size + 1) == read_request.offset) begin
          rd_next_state = S_RD_IDLE;
        end
      end

    S_RD_INDEX:
      begin
        if (!ccip_rx.c0TxAlmFull) begin
          rd_next_state = S_RD_IDLE;
        end
      end

    endcase
  end

  //
  //  read response
  //
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      core_buffer.rx_buffer_data.cl_data <= '0;
      core_buffer.rx_buffer_data.valid   <= '0;
    end
    else begin
      if ((ccip_rx.c0.rspValid) &&
        (ccip_rx.c0.hdr.resp_type == eRSP_RDLINE)) begin

        core_buffer.rx_buffer_data.cl_data <= ccip_rx.c0.data;
        core_buffer.rx_buffer_data.valid   <= '1;
      end
      else begin
        core_buffer.rx_buffer_data.valid <= '0;
      end
    end
  end

  //
  // write state FSM
  //

  t_wr_state wr_state;
  t_wr_state wr_next_state;

  t_ccip_clAddr wr_offset[HC_BUFFER_SIZE];
  t_ccip_clAddr wr_rsp_cnt;

  t_ccip_c1_ReqMemHdr wr_hdr;

  logic write_request_enq_en;
  logic write_request_deq_en;
  logic write_request_not_empty;
  logic write_request_not_full;
  logic write_request_valid;

  logic [HC_WRITE_FIFO_DEPTH/2 - 1:0] write_request_counter;

  t_request_write_fifo write_request /* synthesis preserve */;
  t_request_write_fifo write_request_enq_data;
  t_request_write_fifo write_request_deq_data;

  assign write_request_enq_en =
    (e_REQUEST_WRITE_STREAM  == core_buffer.write_request.control.cmd) |
    (e_REQUEST_WRITE_INDEXED == core_buffer.write_request.control.cmd);

  assign write_request_enq_data.cmd    = core_buffer.write_request.control.cmd;
  assign write_request_enq_data.id     = core_buffer.write_request.control.id;
  assign write_request_enq_data.offset = core_buffer.write_request.control.offset;
  assign write_request_enq_data.data   = core_buffer.tx_buffer_data.cl_data;

  hc_fifo
  #(
    .HC_FIFO_WIDTH($bits(t_request_write_fifo)),
    .HC_FIFO_DEPTH(HC_WRITE_FIFO_DEPTH)
  )
  uu_hc_tx_fifo
  (
    .clk          (clk),
    .reset        (reset),
    .enq_data     (write_request_enq_data),
    .enq_en       (write_request_enq_en),
    .not_full     (write_request_not_full),
    .deq_data     (write_request_deq_data),
    .deq_en       (write_request_deq_en),
    .not_empty    (write_request_not_empty),
    .counter      (write_request_counter),
    .dec_counter  ()
  );

  always_ff@(posedge clk) begin
    core_buffer.write_request.status.count <= write_request_counter;
    core_buffer.write_request.status.empty <= !write_request_not_empty;
    core_buffer.write_request.status.full  <=
      write_request_counter > (HC_WRITE_FIFO_DEPTH - 5);
  end

  assign write_request_deq_en =
    !ccip_rx.c1TxAlmFull && (S_WR_STREAM == wr_state || S_WR_INDEX == wr_state);;

  always_ff @(posedge clk or posedge reset) begin
    write_request <= (reset) ? '0 : write_request_deq_data;
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      wr_hdr = t_ccip_c1_ReqMemHdr'(0);
      ccip_c1_tx.hdr   <= wr_hdr;
      ccip_c1_tx.valid <= 1'b0;
      ccip_c1_tx.data  <= t_ccip_clData'('0);

      for (int i = 0; i < HC_BUFFER_SIZE; i++) begin
        wr_offset[i] <= '0;
      end
    end
    else begin

      ccip_c1_tx.data <= write_request.data;

      if (S_WR_FINISH_1 == wr_state)
        ccip_c1_tx.data[31:0] <= 32'h1;

      case (wr_state)
      S_WR_START:
        begin
          ccip_c1_tx.valid <= 1'b0;
        end

      S_WR_IDLE:
        begin
          ccip_c1_tx.valid <= 1'b0;
        end

      S_WR_PROCESS:
        begin
          ccip_c1_tx.valid <= 1'b0;

          if (S_WR_INDEX == t_wr_state'(write_request.cmd)) begin
            wr_offset[write_request.id] <= write_request.offset;
          end
        end

      S_WR_STREAM:
        begin
          wr_hdr.address =
            hc_buffer[write_request.id].address + wr_offset[write_request.id];

          wr_offset[write_request.id] <=
            t_ccip_clAddr'(wr_offset[write_request.id] + !ccip_rx.c1TxAlmFull);

          wr_hdr.sop = 1'b1;

          ccip_c1_tx.hdr   <= wr_hdr;
          ccip_c1_tx.valid <= !ccip_rx.c1TxAlmFull;
        end

      S_WR_INDEX:
        begin
          wr_hdr.address =
            hc_buffer[write_request.id].address + wr_offset[write_request.id];

          wr_offset[write_request.id] <=
            t_ccip_clAddr'(wr_offset[write_request.id] + !ccip_rx.c1TxAlmFull);

          wr_hdr.sop = 1'b1;

          ccip_c1_tx.hdr   <= wr_hdr;
          ccip_c1_tx.valid <= !ccip_rx.c1TxAlmFull;
        end

      S_WR_FINISH_1:
        begin
          wr_hdr.address = hc_dsm_base;
          wr_hdr.sop = 1'b1;

          ccip_c1_tx.hdr   <= wr_hdr;
          ccip_c1_tx.valid <= !ccip_rx.c1TxAlmFull;
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
    S_WR_START:
      begin
        if (hc_control == HC_CONTROL_START) begin
          wr_next_state = S_WR_IDLE;
        end
      end

    S_WR_IDLE:
      begin
        if (!ccip_rx.c1TxAlmFull) begin
          if (write_request_not_empty) begin
            wr_next_state = S_WR_PROCESS;
          end
          else if (1'b1 == finish) begin
            wr_next_state = S_WR_FINISH_1;
          end
        end
      end

    S_WR_PROCESS:
      begin
        wr_next_state = t_wr_state'(write_request.cmd);
      end

    S_WR_STREAM:
      begin
        if (!ccip_rx.c1TxAlmFull) begin
          wr_next_state = S_WR_IDLE;
        end
      end

    S_WR_INDEX:
      begin
        if (!ccip_rx.c1TxAlmFull) begin
          wr_next_state = S_WR_IDLE;
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

