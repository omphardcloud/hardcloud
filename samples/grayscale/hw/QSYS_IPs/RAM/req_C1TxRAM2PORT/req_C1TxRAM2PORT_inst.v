	req_C1TxRAM2PORT u0 (
		.data      (<connected-to-data>),      //  ram_input.datain
		.wraddress (<connected-to-wraddress>), //           .wraddress
		.rdaddress (<connected-to-rdaddress>), //           .rdaddress
		.wren      (<connected-to-wren>),      //           .wren
		.clock     (<connected-to-clock>),     //           .clock
		.q         (<connected-to-q>)          // ram_output.dataout
	);

