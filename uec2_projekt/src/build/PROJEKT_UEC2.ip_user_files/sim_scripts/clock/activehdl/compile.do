vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"D:/Program_files/Vivado/Vivado/2017.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Program_files/Vivado/Vivado/2017.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Program_files/Vivado/Vivado/2017.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../../PROJEKT_UEC2.srcs/sources_1/ip/clock/clock_clk_wiz.v" \
"../../../../PROJEKT_UEC2.srcs/sources_1/ip/clock/clock.v" \

vlog -work xil_defaultlib \
"glbl.v"

