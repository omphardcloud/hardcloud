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

    //
    // Run the entire design at the standard CCI-P frequency (400 MHz).
    //
    logic clk;
    assign clk = pClk;

    logic reset;
    assign reset = pck_cp2af_softReset;

    // HC_CONTROL actions
    localparam HC_CONTROL_ASSERT_RST   = 32'h0000;
    localparam HC_CONTROL_DEASSERT_RST = 32'h0001;
    localparam HC_CONTROL_START        = 32'h0003;
    localparam HC_CONTROL_STOP         = 32'h0007;

    // =========================================================================
    //
    //   Instances.
    //
    // =========================================================================
    logic [31:0]  ctl;
    t_ccip_clAddr mem_dsm;
    t_ccip_clAddr mem_addr_read;
    t_ccip_clAddr mem_addr_write;

    sha512_csr uu_sha512_csr
    (
      .clk             (clk),
      .reset           (reset),
      .rx_mmio_channel (sRx.c0),
      .tx_mmio_channel (sTx.c2),
      .ctl             (ctl),
      .mem_dsm         (mem_dsm),
      .mem_addr_read   (mem_addr_read),
      .mem_addr_write  (mem_addr_write)
    );


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

