// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Wed Sep  7 16:36:16 2022
// Host        : DESKTOP-E1S6T55 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/bened/Desktop/freqd/build/PROJEKT_UEC2.srcs/sources_1/ip/clock/clock_stub.v
// Design      : clock
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clock(CLK_100, CLK_90, CLK_50, CLK_25, CLK_10, reset, 
  locked, CLK_IN_100)
/* synthesis syn_black_box black_box_pad_pin="CLK_100,CLK_90,CLK_50,CLK_25,CLK_10,reset,locked,CLK_IN_100" */;
  output CLK_100;
  output CLK_90;
  output CLK_50;
  output CLK_25;
  output CLK_10;
  input reset;
  output locked;
  input CLK_IN_100;
endmodule
