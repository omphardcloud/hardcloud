onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xilinx_vip -L xil_defaultlib -L xpm -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_4 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.control_hardcloud_top_vip xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {control_hardcloud_top_vip.udo}

run -all

quit -force
