//
// Copyright (c) 2017, Intel Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// Neither the name of the Intel Corporation nor the names of its contributors
// may be used to endorse or promote products derived from this software
// without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

import ccip_if_pkg::*;

module ccip_std_afu
(
    // CCI-P Clocks and Resets
    input  logic         pClk,               // 400MHz - CCI-P clock domain. Primary interface clock
    input  logic         pClkDiv2,           // 200MHz - CCI-P clock domain.
    input  logic         pClkDiv4,           // 100MHz - CCI-P clock domain.
    input  logic         uClk_usr,           // User clock domain. Refer to clock programming guide  ** Currently provides fixed 300MHz clock **
    input  logic         uClk_usrDiv2,       // User clock domain. Half the programmed frequency  ** Currently provides fixed 150MHz clock **
    input  logic         pck_cp2af_softReset,// CCI-P ACTIVE HIGH Soft Reset
    input  logic [1:0]   pck_cp2af_pwrState, // CCI-P AFU Power State
    input  logic         pck_cp2af_error,    // CCI-P Protocol Error Detected

    // Interface structures
    input  t_if_ccip_Rx  pck_cp2af_sRx,      // CCI-P Rx Port
    output t_if_ccip_Tx  pck_af2cp_sTx       // CCI-P Tx Port
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
    localparam HC_BUFFER_ADDRESS_2 = 16'h140; // 64b - RW  Writes are targetted to this region
    localparam HC_BUFFER_SIZE_2    = 16'h148; // 32b - RW  Numbers of cache lines
    localparam HC_BUFFER_ADDRESS_3 = 16'h150; // 64b - RW  Writes are targetted to this region
    localparam HC_BUFFER_SIZE_3    = 16'h158; // 32b - RW  Numbers of cache lines
    localparam HC_BUFFER_ADDRESS_4 = 16'h160; // 64b - RW  Writes are targetted to this region
    localparam HC_BUFFER_SIZE_4    = 16'h168; // 32b - RW  Numbers of cache lines
    localparam HC_BUFFER_ADDRESS_5 = 16'h170; // 64b - RW  Writes are targetted to this region
    localparam HC_BUFFER_SIZE_5    = 16'h178; // 32b - RW  Numbers of cache lines
    localparam HC_BUFFER_ADDRESS_6 = 16'h180; // 64b - RW  Writes are targetted to this region
    localparam HC_BUFFER_SIZE_6    = 16'h188; // 32b - RW  Numbers of cache lines
    localparam HC_BUFFER_ADDRESS_7 = 16'h190; // 64b - RW  Writes are targetted to this region
    localparam HC_BUFFER_SIZE_7    = 16'h198; // 32b - RW  Numbers of cache lines

    // HC_CONTROL actions
    localparam HC_CONTROL_ASSERT_RST   = 32'h0000;
    localparam HC_CONTROL_DEASSERT_RST = 32'h0001;
    localparam HC_CONTROL_START        = 32'h0003;
    localparam HC_CONTROL_STOP         = 32'h0007;

    //
    // Run the entire design at the standard CCI-P frequency (400 MHz).
    //
    logic clk;
    assign clk = pClk;

    logic reset;
    assign reset = pck_cp2af_softReset;


    // =========================================================================
    //
    //   Register requests.
    //
    // =========================================================================

    //
    // The incoming pck_cp2af_sRx and outgoing pck_af2cp_sTx must both be
    // registered.  Here we register pck_cp2af_sRx and assign it to sRx.
    // We also assign pck_af2cp_sTx to sTx here but don't register it.
    // The code below never uses combinational logic to write sTx.
    //

    t_if_ccip_Rx sRx;
    always_ff @(posedge clk)
    begin
        sRx <= pck_cp2af_sRx;
    end

    t_if_ccip_Tx sTx;
    assign pck_af2cp_sTx = sTx;


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
    assign is_csr_read = sRx.c0.mmioRdValid;

    // Is a CSR write request active this cycle?
    logic is_csr_write;
    assign is_csr_write = sRx.c0.mmioWrValid;

    // The MMIO request header is overlayed on the normal c0 memory read
    // response data structure.  Cast the c0Rx header to an MMIO request
    // header.
    t_ccip_c0_ReqMmioHdr mmio_req_hdr;
    assign mmio_req_hdr = t_ccip_c0_ReqMmioHdr'(sRx.c0.hdr);


    //
    // Implement the device feature list by responding to MMIO reads.
    //

    always_ff @(posedge clk)
    begin
        if (reset)
        begin
            sTx.c2.mmioRdValid <= 1'b0;
        end
        else
        begin
            // Always respond with something for every read request
            sTx.c2.mmioRdValid <= is_csr_read;

            // The unique transaction ID matches responses to requests
            sTx.c2.hdr.tid <= mmio_req_hdr.tid;

            // Addresses are of 32-bit objects in MMIO space.  Addresses
            // of 64-bit objects are thus multiples of 2.
            case (mmio_req_hdr.address)
              HC_DEVICE_HEADER: // AFU DFH (device feature header)
                begin
                    // Here we define a trivial feature list.  In this
                    // example, our AFU is the only entry in this list.
                    sTx.c2.data <= t_ccip_mmioData'(0);
                    // Feature type is AFU
                    sTx.c2.data[63:60] <= 4'h1;
                    // End of list (last entry in list)
                    sTx.c2.data[40] <= 1'b1;
                end

              // AFU_ID_L
              (HC_AFU_ID_LOW >> 2): sTx.c2.data <= afu_id[63:0];

              // AFU_ID_H
              (HC_AFU_ID_HIGH >> 2): sTx.c2.data <= afu_id[127:64];

              // DFH_RSVD0
              6: sTx.c2.data <= t_ccip_mmioData'(0);

              // DFH_RSVD1
              8: sTx.c2.data <= t_ccip_mmioData'(0);

              default: sTx.c2.data <= t_ccip_mmioData'(0);
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
    t_ccip_clAddr mem_dsm;
    t_ccip_clAddr mem_addr_read;
    t_ccip_clAddr mem_addr_write;

    logic [31:0] ctl;

    always_ff @(posedge clk)
    begin
        if (is_dsm_basel)
        begin
            mem_dsm <= t_ccip_clAddr'(sRx.c0.data) >> 6;
            $display("AFU set DSM Low");
        end
    end

    always_ff @(posedge clk)
    begin
        if (is_mem_addr_csr_read)
        begin
            mem_addr_read <= t_ccip_clAddr'(sRx.c0.data);
            $display("AFU set src_address");
        end
    end

    always_ff @(posedge clk)
    begin
        if (is_mem_addr_csr_write)
        begin
            mem_addr_write <= t_ccip_clAddr'(sRx.c0.data);
            $display("AFU set dst_address");
        end
    end

    always_ff @(posedge clk)
    begin
        if (is_ctl)
        begin
            ctl <= sRx.c0.data[31:0];
        end
    end



    // =========================================================================
    //
    //   Main AFU logic
    //
    // =========================================================================

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
            if ((state == STATE_IDLE) && (ctl == HC_CONTROL_START))
            begin
                state <= STATE_READ;
            end

            if ((state == STATE_READ) && !sRx.c0TxAlmFull)
            begin
                state <= STATE_WAIT_READ;
            end

            if ((state == STATE_WAIT_READ) &&
                (sRx.c0.rspValid) &&
                (sRx.c0.hdr.resp_type == eRSP_RDLINE))
            begin
                state <= STATE_WRITE;
            end

            if ((state == STATE_WRITE) && !sRx.c1TxAlmFull)
            begin
                state <= STATE_FINISH;
            end

            if ((state == STATE_FINISH) && !sRx.c1TxAlmFull)
            begin
                state <= STATE_STOP;
            end

            if ((state == STATE_STOP) && (ctl == HC_CONTROL_STOP))
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
        rd_hdr.address = mem_addr_read;
    end

    // Control logic for memory reads
    always_ff @(posedge clk)
    begin
        if (reset)
        begin
            sTx.c0.valid <= 1'b0;
        end
        else
        begin
            // Request the write as long as the channel isn't full.
            sTx.c0.valid <= ((state == STATE_READ) && !sRx.c0TxAlmFull);
        end

        sTx.c0.hdr <= rd_hdr;
    end

    // Receive data (read responses).
    always_ff @(posedge clk)
    begin
        if ((sRx.c0.rspValid) && (sRx.c0.hdr.resp_type == eRSP_RDLINE))
        begin
            for (int i = 0; i < 32; i++)
            begin
              data[32*i +: 32] <= sRx.c0.data[32*i +: 32] + 10;
            end
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
        wr_hdr.address = (state == STATE_FINISH) ? mem_dsm + 1 : mem_addr_write;
        // Start of packet is always set for single beat writes
        wr_hdr.sop = 1'b1;
    end

    // Control logic for memory writes
    always_ff @(posedge clk)
    begin
        if (reset)
        begin
            sTx.c1.valid <= 1'b0;
        end
        else
        begin
            // Request the write as long as the channel isn't full.
            sTx.c1.valid <= ((state == STATE_FINISH || state == STATE_WRITE) &&
                            !sRx.c1TxAlmFull);

            sTx.c1.data <= (state == STATE_FINISH) ? t_ccip_clData'('h1) : data;
        end

        sTx.c1.hdr <= wr_hdr;
    end

endmodule

