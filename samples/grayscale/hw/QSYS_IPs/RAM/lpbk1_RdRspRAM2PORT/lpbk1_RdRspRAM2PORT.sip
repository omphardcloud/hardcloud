set_global_assignment -entity "lpbk1_RdRspRAM2PORT" -library "lib_lpbk1_RdRspRAM2PORT" -name IP_TOOL_NAME "QsysPrimePro"
set_global_assignment -entity "lpbk1_RdRspRAM2PORT" -library "lib_lpbk1_RdRspRAM2PORT" -name IP_TOOL_VERSION "16.0"
set_global_assignment -entity "lpbk1_RdRspRAM2PORT" -library "lib_lpbk1_RdRspRAM2PORT" -name IP_TOOL_ENV "QsysPrimePro"
set_global_assignment -library "lib_lpbk1_RdRspRAM2PORT" -name SPD_FILE [file join $::quartus(sip_path) "lpbk1_RdRspRAM2PORT.spd"]
set_global_assignment -library "lib_lpbk1_RdRspRAM2PORT" -name MISC_FILE [file join $::quartus(sip_path) "../lpbk1_RdRspRAM2PORT.qsys"]

set_global_assignment -library "lib_lpbk1_RdRspRAM2PORT" -name MISC_FILE [file join $::quartus(sip_path) "sim/lpbk1_RdRspRAM2PORT.v"]
set_global_assignment -library "lib_lpbk1_RdRspRAM2PORT" -name MISC_FILE [file join $::quartus(sip_path) "ram_2port_160/sim/lpbk1_RdRspRAM2PORT_ram_2port_160_5m77a5a.v"]
