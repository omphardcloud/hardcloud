	component lpbk1_RdRspRAM2PORT is
		port (
			data      : in  std_logic_vector(533 downto 0) := (others => 'X'); -- datain
			wraddress : in  std_logic_vector(8 downto 0)   := (others => 'X'); -- wraddress
			rdaddress : in  std_logic_vector(8 downto 0)   := (others => 'X'); -- rdaddress
			wren      : in  std_logic                      := 'X';             -- wren
			clock     : in  std_logic                      := 'X';             -- clock
			q         : out std_logic_vector(533 downto 0)                     -- dataout
		);
	end component lpbk1_RdRspRAM2PORT;

	u0 : component lpbk1_RdRspRAM2PORT
		port map (
			data      => CONNECTED_TO_data,      --  ram_input.datain
			wraddress => CONNECTED_TO_wraddress, --           .wraddress
			rdaddress => CONNECTED_TO_rdaddress, --           .rdaddress
			wren      => CONNECTED_TO_wren,      --           .wren
			clock     => CONNECTED_TO_clock,     --           .clock
			q         => CONNECTED_TO_q          -- ram_output.dataout
		);

