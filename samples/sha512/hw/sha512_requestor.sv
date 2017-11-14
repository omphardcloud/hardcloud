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

  logic [1023:0] block[2];

  //
  // States in our simple example.
  //
  typedef enum logic [2:0]
  {
      STATE_IDLE,
      STATE_READ,
      STATE_WAIT_READ,
      STATE_WRITE,
      STATE_FINISH,
      STATE_STOP
  }
  t_state;

  t_state state;

  //
  // Common Data
  //
  logic [511:0] data;

  //
  // State machine
  //

  always_ff @(posedge clk)
  begin
      if (reset)
      begin
          state <= STATE_IDLE;
      end
      else
      begin
          if ((state == STATE_IDLE) && (hc_control == HC_CONTROL_START))
          begin
              state <= STATE_READ;
    
              $display("== requestor ==");
              $display(hc_buffer[0].address);
              $display(hc_buffer[0].size);
              $display(hc_buffer[1].address);
              $display(hc_buffer[1].size);
          end

          if ((state == STATE_READ) && !ccip_rx.c0TxAlmFull)
          begin
              state <= STATE_WAIT_READ;
          end

          if ((state == STATE_WAIT_READ) &&
              (ccip_rx.c0.rspValid) &&
              (ccip_rx.c0.hdr.resp_type == eRSP_RDLINE))
          begin
              state <= STATE_WRITE;
          end

          if ((state == STATE_WRITE) && !ccip_rx.c1TxAlmFull)
          begin
              state <= STATE_FINISH;
          end

          if ((state == STATE_FINISH) && !ccip_rx.c1TxAlmFull)
          begin
              state <= STATE_STOP;
          end

          if ((state == STATE_STOP) && (hc_control == HC_CONTROL_STOP))
          begin
            state <= STATE_IDLE;
          end
      end
  end

  //
  // Read
  //

  // Construct a memory read request header.  For this AFU it is always
  // the same, since we read to only one address.
  t_ccip_c0_ReqMemHdr rd_hdr;
  always_comb
  begin
      // Zero works for most write request header fields in this example
      rd_hdr = t_ccip_c0_ReqMemHdr'(0);
      // Set the read address
      rd_hdr.address = hc_buffer[1].address;
  end

  // Control logic for memory reads
  always_ff @(posedge clk)
  begin
      if (reset)
      begin
          ccip_c0_tx.valid <= 1'b0;
      end
      else
      begin
          // Request the write as long as the channel isn't full.
          ccip_c0_tx.valid <= ((state == STATE_READ) && !ccip_rx.c0TxAlmFull);
      end

      ccip_c0_tx.hdr <= rd_hdr;
  end

  // Receive data (read responses).
  always_ff @(posedge clk)
  begin
      if ((ccip_rx.c0.rspValid) && (ccip_rx.c0.hdr.resp_type == eRSP_RDLINE))
      begin
          for (int i = 0; i < 32; i++)
          begin
            data[32*i +: 32] <= ccip_rx.c0.data[32*i +: 32] + 10;
          end

          $display("recv data test");
          $display(ccip_rx.c0.data);
      end
  end

  //
  // Write
  //

  // Construct a memory write request header.
  t_ccip_c1_ReqMemHdr wr_hdr;
  always_comb
  begin
      // Zero works for most write request header fields in this example
      wr_hdr = t_ccip_c1_ReqMemHdr'(0);
      // Set the write address
      wr_hdr.address = (state == STATE_FINISH) ? hc_dsm_base + 1 : hc_buffer[0].address;
      // Start of packet is always set for single beat writes
      wr_hdr.sop = 1'b1;
  end

  // Control logic for memory writes
  always_ff @(posedge clk)
  begin
      if (reset)
      begin
          ccip_c1_tx.valid <= 1'b0;
      end
      else
      begin
          // Request the write as long as the channel isn't full.
          ccip_c1_tx.valid <= ((state == STATE_FINISH || state == STATE_WRITE) &&
                          !ccip_rx.c1TxAlmFull);

          ccip_c1_tx.data <= (state == STATE_FINISH) ? t_ccip_clData'('h1) : data;
      end

      ccip_c1_tx.hdr <= wr_hdr;
  end

endmodule : sha512_requestor

