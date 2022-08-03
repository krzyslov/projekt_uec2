-makelib ies_lib/xil_defaultlib -sv \
  "D:/Program_files/Vivado/Vivado/2017.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Program_files/Vivado/Vivado/2017.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_0 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../PROJEKT_UEC2.srcs/sources_1/ip/frame_buffer/sim/frame_buffer.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

