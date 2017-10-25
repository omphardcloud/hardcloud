set_global_assignment -entity "req_C1TxRAM2PORT" -library "lib_req_C1TxRAM2PORT" -name IP_TOOL_NAME "QsysPrimePro"
set_global_assignment -entity "req_C1TxRAM2PORT" -library "lib_req_C1TxRAM2PORT" -name IP_TOOL_VERSION "16.0"
set_global_assignment -entity "req_C1TxRAM2PORT" -library "lib_req_C1TxRAM2PORT" -name IP_TOOL_ENV "QsysPrimePro"
set_global_assignment -library "lib_req_C1TxRAM2PORT" -name SPD_FILE [file join $::quartus(sip_path) "req_C1TxRAM2PORT.spd"]
set_global_assignment -library "lib_req_C1TxRAM2PORT" -name MISC_FILE [file join $::quartus(sip_path) "../req_C1TxRAM2PORT.qsys"]

set_global_assignment -library "lib_req_C1TxRAM2PORT" -name MISC_FILE [file join $::quartus(sip_path) "sim/req_C1TxRAM2PORT.v"]
set_global_assignment -library "lib_req_C1TxRAM2PORT" -name MISC_FILE [file join $::quartus(sip_path) "ram_2port_160/sim/req_C1TxRAM2PORT_ram_2port_160_nfprwsy.v"]
