// sha512_csr.sv

import ccip_if_pkg::*;

module sha512_csr
(
  input  logic           clk,
  input  logic           reset,
  input  t_if_ccip_c0_Rx rx_mmio_channel,
  output t_if_ccip_c2_Tx tx_mmio_channel,
  output logic [31:0]    ctl,
  output t_ccip_clAddr   mem_dsm,
  output t_ccip_clAddr   mem_addr_read,
  output t_ccip_clAddr   mem_addr_write
);

  // register map to HardCloud
  localparam HC_DEVICE_HEADER    = 16'h000; // 64b - RO  Constant: 0x1000010000000000.
  localparam HC_AFU_ID_LOW       = 16'h008; // 64b - RO  Constant: 0xC000C9660D824272.
  localparam HC_AFU_ID_HIGH      = 16'h010; // 64b - RO  Constant: 0x9AEFFE5F84570612.
  localparam HC_DSM_BASE_LOW     = 16'h110; // 32b - RW  Lower 32-bits of DSM base address
  localparam HC_CONTROL          = 16'h118; // 32b - RW  Control to start n stop the test

  localparam HC_BUFFER_ADDRESS_0 = 16'h120; // 64b - RW  Reads are targetted to this region
  localparam HC_BUFFER_SIZE_0    = 16'h128; // 32b - RW  Numbers of cache lines
  localparam HC_BUFFER_ADDRESS_1 = 16'h130; // 64b - RW  Writes are targetted to this region
  localparam HC_BUFFER_SIZE_1    = 16'h138; // 32b - RW  Numbers of cache lines


  // =========================================================================
  //
  //   CSR (MMIO) handling.
  //
  // =========================================================================

  // The AFU ID is a unique ID for a given program.  Here we generated
  // one with the "uuidgen" program.
  logic [127:0] afu_id = 128'hC000C966_0D82_4272_9AEF_FE5F84570612;

  //
  // A valid AFU must implement a device feature list, starting at MMIO
  // address 0.  Every entry in the feature list begins with 5 64-bit
  // words: a device feature header, two AFU UUID words and two reserved
  // words.
  //

  // Is a CSR read request active this cycle?
  logic is_csr_read;
  assign is_csr_read = rx_mmio_channel.mmioRdValid;

  // Is a CSR write request active this cycle?
  logic is_csr_write;
  assign is_csr_write = rx_mmio_channel.mmioWrValid;

  // The MMIO request header is overlayed on the normal c0 memory read
  // response data structure.  Cast the c0Rx header to an MMIO request
  // header.
  t_ccip_c0_ReqMmioHdr mmio_req_hdr;
  assign mmio_req_hdr = t_ccip_c0_ReqMmioHdr'(rx_mmio_channel.hdr);


  //
  // Implement the device feature list by responding to MMIO reads.
  //

  always_ff @(posedge clk)
  begin
      if (reset)
      begin
          tx_mmio_channel.mmioRdValid <= 1'b0;
      end
      else
      begin
          // Always respond with something for every read request
          tx_mmio_channel.mmioRdValid <= is_csr_read;

          // The unique transaction ID matches responses to requests
          tx_mmio_channel.hdr.tid <= mmio_req_hdr.tid;

          // Addresses are of 32-bit objects in MMIO space.  Addresses
          // of 64-bit objects are thus multiples of 2.
          case (mmio_req_hdr.address)
            HC_DEVICE_HEADER: // AFU DFH (device feature header)
              begin
                  // Here we define a trivial feature list.  In this
                  // example, our AFU is the only entry in this list.
                  tx_mmio_channel.data <= t_ccip_mmioData'(0);
                  // Feature type is AFU
                  tx_mmio_channel.data[63:60] <= 4'h1;
                  // End of list (last entry in list)
                  tx_mmio_channel.data[40] <= 1'b1;
              end

            // AFU_ID_L
            (HC_AFU_ID_LOW >> 2): tx_mmio_channel.data <= afu_id[63:0];

            // AFU_ID_H
            (HC_AFU_ID_HIGH >> 2): tx_mmio_channel.data <= afu_id[127:64];

            // DFH_RSVD0
            6: tx_mmio_channel.data <= t_ccip_mmioData'(0);

            // DFH_RSVD1
            8: tx_mmio_channel.data <= t_ccip_mmioData'(0);

            default: tx_mmio_channel.data <= t_ccip_mmioData'(0);
          endcase
      end
  end


  //
  // CSR write handling.  Host software must tell the AFU the memory address
  // to which it should be writing.  The address is set by writing a CSR.
  //

  // dsm_basel: device status memory - base low
  logic is_dsm_basel;
  assign is_dsm_basel = is_csr_write &&
      (mmio_req_hdr.address == t_ccip_mmioAddr'(HC_DSM_BASE_LOW >> 2));

  // csr_read: src address
  logic is_mem_addr_csr_read;
  assign is_mem_addr_csr_read = is_csr_write &&
      (mmio_req_hdr.address == t_ccip_mmioAddr'(HC_BUFFER_ADDRESS_1 >> 2));

  // src_num_lines: source number of cache lines
  logic is_src_num_lines;
  assign is_src_num_lines = is_csr_write &&
      (mmio_req_hdr.address == t_ccip_mmioAddr'(HC_BUFFER_SIZE_1 >> 2));

  // csr_write: dst address
  logic is_mem_addr_csr_write;
  assign is_mem_addr_csr_write = is_csr_write &&
      (mmio_req_hdr.address == t_ccip_mmioAddr'(HC_BUFFER_ADDRESS_0 >> 2));

  // dst_num_lines: destination number of cache lines
  logic is_dst_num_lines;
  assign is_dst_num_lines = is_csr_write &&
      (mmio_req_hdr.address == t_ccip_mmioAddr'(HC_BUFFER_SIZE_0 >> 2));

  // ctl: block control
  logic is_ctl;
  assign is_ctl = is_csr_write &&
      (mmio_req_hdr.address == t_ccip_mmioAddr'(HC_CONTROL >> 2));

  // Memory address to which this AFU will read or write.
  always_ff @(posedge clk)
  begin
      if (is_dsm_basel)
      begin
          mem_dsm <= t_ccip_clAddr'(rx_mmio_channel.data) >> 6;
          $display("AFU set DSM Low");
      end
  end

  always_ff @(posedge clk)
  begin
      if (is_mem_addr_csr_read)
      begin
          mem_addr_read <= t_ccip_clAddr'(rx_mmio_channel.data);
          $display("AFU set src_address");
      end
  end

  always_ff @(posedge clk)
  begin
      if (is_mem_addr_csr_write)
      begin
          mem_addr_write <= t_ccip_clAddr'(rx_mmio_channel.data);
          $display("AFU set dst_address");
      end
  end

  always_ff @(posedge clk)
  begin
      if (is_ctl)
      begin
          ctl <= rx_mmio_channel.data[31:0];
      end
  end

endmodule : sha512_csr

