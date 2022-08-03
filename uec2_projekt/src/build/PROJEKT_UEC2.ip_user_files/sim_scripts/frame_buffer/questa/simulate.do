onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib frame_buffer_opt

do {wave.do}

view wave
view structure
view signals

do {frame_buffer.udo}

run -all

quit -force
