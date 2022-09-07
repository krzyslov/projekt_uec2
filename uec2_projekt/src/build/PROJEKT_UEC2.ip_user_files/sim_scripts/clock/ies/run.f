-makelib ies_lib/xil_defaultlib -sv \
  "D:/Program_files/Vivado/Vivado/2017.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Program_files/Vivado/Vivado/2017.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Program_files/Vivado/Vivado/2017.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../PROJEKT_UEC2.srcs/sources_1/ip/clock/clock_clk_wiz.v" \
  "../../../../PROJEKT_UEC2.srcs/sources_1/ip/clock/clock.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

