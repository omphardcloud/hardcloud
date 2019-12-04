onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib control_hardcloud_top_vip_opt

do {wave.do}

view wave
view structure
view signals

do {control_hardcloud_top_vip.udo}

run -all

quit -force
