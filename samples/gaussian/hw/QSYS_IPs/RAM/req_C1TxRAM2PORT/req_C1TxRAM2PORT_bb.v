
module req_C1TxRAM2PORT (
	data,
	wraddress,
	rdaddress,
	wren,
	clock,
	q);	

	input	[555:0]	data;
	input	[8:0]	wraddress;
	input	[8:0]	rdaddress;
	input		wren;
	input		clock;
	output	[555:0]	q;
endmodule
