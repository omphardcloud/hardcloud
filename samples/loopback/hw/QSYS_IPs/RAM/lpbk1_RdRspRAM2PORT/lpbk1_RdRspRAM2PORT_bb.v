
module lpbk1_RdRspRAM2PORT (
	data,
	wraddress,
	rdaddress,
	wren,
	clock,
	q);	

	input	[533:0]	data;
	input	[8:0]	wraddress;
	input	[8:0]	rdaddress;
	input		wren;
	input		clock;
	output	[533:0]	q;
endmodule
