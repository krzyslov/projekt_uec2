set_property SRC_FILE_INFO {cfile:c:/Users/bened/Desktop/freqd/build/PROJEKT_UEC2.srcs/sources_1/ip/clock/clock.xdc rfile:../../../PROJEKT_UEC2.srcs/sources_1/ip/clock/clock.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports CLK_IN_100]] 0.1
