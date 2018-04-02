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
    .HC_FIFO_DEPTH(HC_REQUEST_DEPTH)
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
      read_request_counter > (HC_REQUEST_DEPTH - 4);
  end

  //
  // read state FSM
  //
  t_rd_state rd_state;
  t_rd_state rd_next_state;

  t_ccip_clAddr rd_offset;
  t_ccip_c0_ReqMemHdr rd_hdr;

  t_request_control read_request;

  logic [9:0] read_stream_size;

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

      rd_offset <= t_ccip_clAddr'('0);
    end
    else begin

      rd_hdr.cl_len  = eCL_LEN_1;
      rd_hdr.address = hc_buffer[read_request.id].address + rd_offset;

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
            rd_offset <= read_request.offset;
          end
        end

      S_RD_STREAM:
        begin
          ccip_c0_tx.valid <= !ccip_rx.c0TxAlmFull;

          rd_offset <= t_ccip_clAddr'(rd_offset + !ccip_rx.c0TxAlmFull);
        end

      S_RD_INDEX:
        begin
          ccip_c0_tx.valid <= !ccip_rx.c0TxAlmFull;

          rd_offset <= t_ccip_clAddr'(rd_offset + !ccip_rx.c0TxAlmFull);
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
        rd_next_state = S_RD_IDLE;
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

        $display("read = %h", ccip_rx.c0.data);
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

  t_ccip_clAddr wr_offset;
  t_ccip_clAddr wr_rsp_cnt;

  t_ccip_c1_ReqMemHdr wr_hdr;

  logic write_request_enq_en;
  logic write_request_deq_en;
  logic write_request_not_empty;
  logic write_request_not_full;
  logic write_request_valid;

  logic [HC_BUFFER_TX_DEPTH/2 - 1:0] write_request_counter;

  t_request_write_fifo write_request;
  t_request_write_fifo write_request_enq_data;
  t_request_write_fifo write_request_deq_data;

  assign write_request_enq_en =
    (e_REQUEST_WRITE_STREAM  == core_buffer.write_request.control.cmd) |
    (e_REQUEST_WRITE_INDEXED == core_buffer.write_request.control.cmd);

  assign write_request_enq_data.cmd    = core_buffer.write_request.control.cmd;
  assign write_request_enq_data.id     = core_buffer.write_request.control.id;
  assign write_request_enq_data.offset = core_buffer.write_request.control.offset;

  assign write_request_enq_data.data0  = core_buffer.tx_buffer_data.cl_data[32*1  - 1:32*0];
  assign write_request_enq_data.data1  = core_buffer.tx_buffer_data.cl_data[32*2  - 1:32*1];
  assign write_request_enq_data.data2  = core_buffer.tx_buffer_data.cl_data[32*3  - 1:32*2];
  assign write_request_enq_data.data3  = core_buffer.tx_buffer_data.cl_data[32*4  - 1:32*3];
  assign write_request_enq_data.data4  = core_buffer.tx_buffer_data.cl_data[32*5  - 1:32*4];
  assign write_request_enq_data.data5  = core_buffer.tx_buffer_data.cl_data[32*6  - 1:32*5];
  assign write_request_enq_data.data6  = core_buffer.tx_buffer_data.cl_data[32*7  - 1:32*6];
  assign write_request_enq_data.data7  = core_buffer.tx_buffer_data.cl_data[32*8  - 1:32*7];
  assign write_request_enq_data.data8  = core_buffer.tx_buffer_data.cl_data[32*9  - 1:32*8];
  assign write_request_enq_data.data9  = core_buffer.tx_buffer_data.cl_data[32*10 - 1:32*9];
  assign write_request_enq_data.data10 = core_buffer.tx_buffer_data.cl_data[32*11 - 1:32*10];
  assign write_request_enq_data.data11 = core_buffer.tx_buffer_data.cl_data[32*12 - 1:32*11];
  assign write_request_enq_data.data12 = core_buffer.tx_buffer_data.cl_data[32*13 - 1:32*12];
  assign write_request_enq_data.data13 = core_buffer.tx_buffer_data.cl_data[32*14 - 1:32*13];
  assign write_request_enq_data.data14 = core_buffer.tx_buffer_data.cl_data[32*15 - 1:32*14];
  assign write_request_enq_data.data15 = core_buffer.tx_buffer_data.cl_data[32*16 - 1:32*15];

  hc_fifo
  #(
    .HC_FIFO_WIDTH($bits(t_request_write_fifo)),
    .HC_FIFO_DEPTH(HC_BUFFER_TX_DEPTH)
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
      write_request_counter > (HC_BUFFER_TX_DEPTH - 5);
  end

  always_comb begin
    write_request_deq_en = !ccip_rx.c1TxAlmFull && write_request_not_empty;
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      write_request       <= '0;
      write_request_valid <= '0;
    end
    else begin
      write_request       <= write_request_deq_data;
      write_request_valid <= write_request_deq_en;
    end
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      wr_offset  <= '0;

      wr_hdr = t_ccip_c1_ReqMemHdr'(0);
      ccip_c1_tx.hdr   <= wr_hdr;
      ccip_c1_tx.valid <= 1'b0;
      ccip_c1_tx.data  <= t_ccip_clData'('0);
    end
    else begin

      // ccip_c1_tx.data <= write_request.data;

      ccip_c1_tx.data[32*1  - 1:32*0]  <= write_request.data0;
      ccip_c1_tx.data[32*2  - 1:32*1]  <= write_request.data1;
      ccip_c1_tx.data[32*3  - 1:32*2]  <= write_request.data2;
      ccip_c1_tx.data[32*4  - 1:32*3]  <= write_request.data3;
      ccip_c1_tx.data[32*5  - 1:32*4]  <= write_request.data4;
      ccip_c1_tx.data[32*6  - 1:32*5]  <= write_request.data5;
      ccip_c1_tx.data[32*7  - 1:32*6]  <= write_request.data6;
      ccip_c1_tx.data[32*8  - 1:32*7]  <= write_request.data7;
      ccip_c1_tx.data[32*9  - 1:32*8]  <= write_request.data8;
      ccip_c1_tx.data[32*10 - 1:32*9]  <= write_request.data9;
      ccip_c1_tx.data[32*11 - 1:32*10] <= write_request.data10;
      ccip_c1_tx.data[32*12 - 1:32*11] <= write_request.data11;
      ccip_c1_tx.data[32*13 - 1:32*12] <= write_request.data12;
      ccip_c1_tx.data[32*14 - 1:32*13] <= write_request.data13;
      ccip_c1_tx.data[32*15 - 1:32*14] <= write_request.data14;
      ccip_c1_tx.data[32*16 - 1:32*15] <= write_request.data15;

      if (S_WR_FINISH_1 == wr_state)
        ccip_c1_tx.data[32*1  - 1:32*0] <= 32'h1;

      case (wr_state)
      S_WR_IDLE:
        begin
          ccip_c1_tx.valid <= 1'b0;
        end

      S_WR_SEND:
        begin
          wr_hdr.address = hc_buffer[write_request.id].address + wr_offset;

          wr_offset <= t_ccip_clAddr'(wr_offset + write_request_valid);

          wr_hdr.sop = 1'b1;

          ccip_c1_tx.hdr   <= wr_hdr;
          ccip_c1_tx.valid <= write_request_valid;

          if (write_request_valid)
            $display("write = %h", write_request.data0);
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
      S_WR_IDLE:
        begin
          if (hc_control == HC_CONTROL_START) begin
            wr_next_state = S_WR_SEND;
          end
        end

      S_WR_SEND:
        begin
          if ((finish == 1) && (write_request_counter == 0)) begin
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

endmodule : hc_requestor

