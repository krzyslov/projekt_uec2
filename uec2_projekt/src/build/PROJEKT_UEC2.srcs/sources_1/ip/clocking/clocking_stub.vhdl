-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
-- Date        : Sat Aug 20 18:59:42 2022
-- Host        : DESKTOP-E1S6T55 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/bened/Desktop/Proj/uec2_projekt/src/build/PROJEKT_UEC2.srcs/sources_1/ip/clocking/clocking_stub.vhdl
-- Design      : clocking
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clocking is
  Port ( 
    CLK_50 : out STD_LOGIC;
    CLK_25 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    CLK_100 : in STD_LOGIC
  );

end clocking;

architecture stub of clocking is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK_50,CLK_25,reset,locked,CLK_100";
begin
end;
