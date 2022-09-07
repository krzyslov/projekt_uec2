vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"D:/Program_files/Vivado/Vivado/2017.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Program_files/Vivado/Vivado/2017.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Program_files/Vivado/Vivado/2017.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../../PROJEKT_UEC2.srcs/sources_1/ip/clock/clock_clk_wiz.v" \
"../../../../PROJEKT_UEC2.srcs/sources_1/ip/clock/clock.v" \

vlog -work xil_defaultlib \
"glbl.v"

