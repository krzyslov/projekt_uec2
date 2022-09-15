// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module char_rom_dist_meter (
    input wire [4:0] char_xy,
    output wire [6:0] char_code,
    input wire [8:0]distance
  );
  localparam string_length = 15;
  reg [(8*string_length -1):0] tekst_do_wyswietlenia;
  
   //[255:0]
// " filtr: RGB2Gray / Increase Brightness/ Decrease Brightness/ colour inversion / red filter 
//" /blue filter / green filter / original image
  
   always @* begin
    case(distance[8:0])
        9'b0_0000_0000: tekst_do_wyswietlenia = " dystans: 000 "  ;
        9'b0_0000_0001: tekst_do_wyswietlenia = " dystans: 001 " ;
        9'b0_0000_0010: tekst_do_wyswietlenia = " dystans: 002 "  ;   
        9'b0_0000_0011: tekst_do_wyswietlenia = " dystans: 003 " ;
        9'b0_0000_0100: tekst_do_wyswietlenia = " dystans: 004 "  ; 
        9'b0_0000_0101: tekst_do_wyswietlenia = " dystans: 005 " ;
        9'b0_0000_0110: tekst_do_wyswietlenia = " dystans: 006 "  ;
        9'b0_0000_0111: tekst_do_wyswietlenia = " dystans: 007 " ;
        9'b0_0000_1000: tekst_do_wyswietlenia = " dystans: 008 "  ;
        9'b0_0000_1001: tekst_do_wyswietlenia = " dystans: 009 " ;
        9'b0_0000_1010: tekst_do_wyswietlenia = " dystans: 010 "  ;
        9'b0_0000_1011: tekst_do_wyswietlenia = " dystans: 011 " ;
        9'b0_0000_1100: tekst_do_wyswietlenia = " dystans: 012 "  ;
        9'b0_0000_1101: tekst_do_wyswietlenia = " dystans: 013 " ;
        9'b0_0000_1110: tekst_do_wyswietlenia = " dystans: 014 "  ;
        9'b0_0000_1111: tekst_do_wyswietlenia = " dystans: 015 " ;
        9'b0_0001_0000: tekst_do_wyswietlenia = " dystans: 016 "  ;
        9'b0_0001_0001: tekst_do_wyswietlenia = " dystans: 017 " ;
        9'b0_0001_0010: tekst_do_wyswietlenia = " dystans: 018 "  ;
        9'b0_0001_0011: tekst_do_wyswietlenia = " dystans: 019 " ;
        9'b0_0001_0100: tekst_do_wyswietlenia = " dystans: 020 "  ;
        9'b0_0001_0101: tekst_do_wyswietlenia = " dystans: 021 " ;
        9'b0_0001_0110: tekst_do_wyswietlenia = " dystans: 022 "  ;
        9'b0_0001_0111: tekst_do_wyswietlenia = " dystans: 023 " ;
        9'b0_0001_1000: tekst_do_wyswietlenia = " dystans: 024 "  ;
        9'b0_0001_1001: tekst_do_wyswietlenia = " dystans: 025 " ;
        9'b0_0001_1010: tekst_do_wyswietlenia = " dystans: 026 "  ;
        9'b0_0001_1011: tekst_do_wyswietlenia = " dystans: 027 " ;
        9'b0_0001_1100: tekst_do_wyswietlenia = " dystans: 028 "  ;
        9'b0_0001_1101: tekst_do_wyswietlenia = " dystans: 029 " ;
        9'b0_0001_1110: tekst_do_wyswietlenia = " dystans: 030 "  ;
        9'b0_0001_1111: tekst_do_wyswietlenia = " dystans: 031 " ;
        9'b0_0010_0000: tekst_do_wyswietlenia = " dystans: 032 "  ;
        9'b0_0010_0001: tekst_do_wyswietlenia = " dystans: 033 " ;
        9'b0_0010_0010: tekst_do_wyswietlenia = " dystans: 034 "  ;
        9'b0_0010_0011: tekst_do_wyswietlenia = " dystans: 035 " ;
        9'b0_0010_0100: tekst_do_wyswietlenia = " dystans: 036 "  ;
        9'b0_0010_0101: tekst_do_wyswietlenia = " dystans: 037 " ;
        9'b0_0010_0110: tekst_do_wyswietlenia = " dystans: 038 "  ;
        9'b0_0010_0111: tekst_do_wyswietlenia = " dystans: 039 " ;
        9'b0_0010_1000: tekst_do_wyswietlenia = " dystans: 040 "  ;
        9'b0_0010_1001: tekst_do_wyswietlenia = " dystans: 041 " ;
        9'b0_0010_1010: tekst_do_wyswietlenia = " dystans: 042 "  ;
        9'b0_0010_1011: tekst_do_wyswietlenia = " dystans: 043 " ;
        9'b0_0010_1100: tekst_do_wyswietlenia = " dystans: 044 "  ;
        9'b0_0010_1101: tekst_do_wyswietlenia = " dystans: 045 " ;
        9'b0_0010_1110: tekst_do_wyswietlenia = " dystans: 046 "  ;
        9'b0_0010_1111: tekst_do_wyswietlenia = " dystans: 047 " ;
        9'b0_0011_0000: tekst_do_wyswietlenia = " dystans: 048 "  ;
        9'b0_0011_0001: tekst_do_wyswietlenia = " dystans: 049 " ;
        9'b0_0011_0010: tekst_do_wyswietlenia = " dystans: 050 "  ;
        9'b0_0011_0011: tekst_do_wyswietlenia = " dystans: 051 " ;
        9'b0_0011_0100: tekst_do_wyswietlenia = " dystans: 052 "  ;
        9'b0_0011_0101: tekst_do_wyswietlenia = " dystans: 053 " ;
        9'b0_0011_0110: tekst_do_wyswietlenia = " dystans: 054 "  ;
        9'b0_0011_0111: tekst_do_wyswietlenia = " dystans: 055 " ;
        9'b0_0011_1000: tekst_do_wyswietlenia = " dystans: 056 "  ;
        9'b0_0011_1001: tekst_do_wyswietlenia = " dystans: 057 " ;
        9'b0_0011_1010: tekst_do_wyswietlenia = " dystans: 058 "  ;
        9'b0_0011_1011: tekst_do_wyswietlenia = " dystans: 059 " ;
        9'b0_0011_1100: tekst_do_wyswietlenia = " dystans: 060 "  ;
        9'b0_0011_1101: tekst_do_wyswietlenia = " dystans: 061 " ;
        9'b0_0011_1110: tekst_do_wyswietlenia = " dystans: 062 "  ;
        9'b0_0011_1111: tekst_do_wyswietlenia = " dystans: 063 " ;
        9'b0_0100_0000: tekst_do_wyswietlenia = " dystans: 064 "  ;
        9'b0_0100_0001: tekst_do_wyswietlenia = " dystans: 065 "  ;
        9'b0_0100_0010: tekst_do_wyswietlenia = " dystans: 066 "  ;
        9'b0_0100_0011: tekst_do_wyswietlenia = " dystans: 067 " ;
        9'b0_0100_0100: tekst_do_wyswietlenia = " dystans: 068 "  ;
        9'b0_0100_0101: tekst_do_wyswietlenia = " dystans: 069 " ;
        9'b0_0100_0110: tekst_do_wyswietlenia = " dystans: 070 "  ;
        9'b0_0100_0111: tekst_do_wyswietlenia = " dystans: 071 " ;
        9'b0_0100_1000: tekst_do_wyswietlenia = " dystans: 072 "  ;
        9'b0_0100_1001: tekst_do_wyswietlenia = " dystans: 073 " ;
        9'b0_0100_1010: tekst_do_wyswietlenia = " dystans: 074 "  ;
        9'b0_0100_1011: tekst_do_wyswietlenia = " dystans: 075 " ;
        9'b0_0100_1100: tekst_do_wyswietlenia = " dystans: 076 "  ;
        9'b0_0100_1101: tekst_do_wyswietlenia = " dystans: 077 " ;
        9'b0_0100_1110: tekst_do_wyswietlenia = " dystans: 078 "  ;
        9'b0_0100_1111: tekst_do_wyswietlenia = " dystans: 079 " ;
        9'b0_0101_0000: tekst_do_wyswietlenia = " dystans: 080 "  ;
        9'b0_0101_0001: tekst_do_wyswietlenia = " dystans: 081 "  ;
        9'b0_0101_0010: tekst_do_wyswietlenia = " dystans: 082 "  ;
        9'b0_0101_0011: tekst_do_wyswietlenia = " dystans: 083 " ;
        9'b0_0101_0100: tekst_do_wyswietlenia = " dystans: 084 "  ;
        9'b0_0101_0101: tekst_do_wyswietlenia = " dystans: 085 " ;
        9'b0_0101_0110: tekst_do_wyswietlenia = " dystans: 086 "  ;
        9'b0_0101_0111: tekst_do_wyswietlenia = " dystans: 087 " ;
        9'b0_0101_1000: tekst_do_wyswietlenia = " dystans: 088 "  ;
        9'b0_0101_1001: tekst_do_wyswietlenia = " dystans: 089 " ;
        9'b0_0101_1010: tekst_do_wyswietlenia = " dystans: 090 "  ;
        9'b0_0101_1011: tekst_do_wyswietlenia = " dystans: 091 " ;
        9'b0_0101_1100: tekst_do_wyswietlenia = " dystans: 092 "  ;
        9'b0_0101_1101: tekst_do_wyswietlenia = " dystans: 093 " ;
        9'b0_0101_1110: tekst_do_wyswietlenia = " dystans: 094 "  ;
        9'b0_0101_1111: tekst_do_wyswietlenia = " dystans: 095 " ;
        9'b0_0110_0000: tekst_do_wyswietlenia = " dystans: 096 "  ;
        9'b0_0110_0001: tekst_do_wyswietlenia = " dystans: 097 "  ;
        9'b0_0110_0010: tekst_do_wyswietlenia = " dystans: 098 "  ;
        9'b0_0110_0011: tekst_do_wyswietlenia = " dystans: 099 " ;
        9'b0_0110_0100: tekst_do_wyswietlenia = " dystans: 100 "  ;
        9'b0_0110_0101: tekst_do_wyswietlenia = " dystans: 101 " ;
        9'b0_0110_0110: tekst_do_wyswietlenia = " dystans: 102 "  ;
        9'b0_0110_0111: tekst_do_wyswietlenia = " dystans: 103 " ;
        9'b0_0110_1000: tekst_do_wyswietlenia = " dystans: 104 "  ;
        9'b0_0110_1001: tekst_do_wyswietlenia = " dystans: 105 " ;
        9'b0_0110_1010: tekst_do_wyswietlenia = " dystans: 106 "  ;
        9'b0_0110_1011: tekst_do_wyswietlenia = " dystans: 107 " ;
        9'b0_0110_1100: tekst_do_wyswietlenia = " dystans: 108 "  ;
        9'b0_0110_1101: tekst_do_wyswietlenia = " dystans: 109 " ;
        9'b0_0110_1110: tekst_do_wyswietlenia = " dystans: 110 "  ;
        9'b0_0110_1111: tekst_do_wyswietlenia = " dystans: 111 " ;
        9'b0_0111_0000: tekst_do_wyswietlenia = " dystans: 112 "  ;
        9'b0_0111_0001: tekst_do_wyswietlenia = " dystans: 113 "  ;
        9'b0_0111_0010: tekst_do_wyswietlenia = " dystans: 114 "  ;
        9'b0_0111_0011: tekst_do_wyswietlenia = " dystans: 115 " ;
        9'b0_0111_0100: tekst_do_wyswietlenia = " dystans: 116 "  ;
        9'b0_0111_0101: tekst_do_wyswietlenia = " dystans: 117 " ;
        9'b0_0111_0110: tekst_do_wyswietlenia = " dystans: 118 "  ;
        9'b0_0111_0111: tekst_do_wyswietlenia = " dystans: 119 " ;
        9'b0_0111_1000: tekst_do_wyswietlenia = " dystans: 120 "  ;
        9'b0_0111_1001: tekst_do_wyswietlenia = " dystans: 121 " ;
        9'b0_0111_1010: tekst_do_wyswietlenia = " dystans: 122 "  ;
        9'b0_0111_1011: tekst_do_wyswietlenia = " dystans: 123 " ;
        9'b0_0111_1100: tekst_do_wyswietlenia = " dystans: 124 "  ;
        9'b0_0111_1101: tekst_do_wyswietlenia = " dystans: 125 " ;
        9'b0_0111_1110: tekst_do_wyswietlenia = " dystans: 126 "  ;
        9'b0_0111_1111: tekst_do_wyswietlenia = " dystans: 127 " ;
        9'b0_1000_0000: tekst_do_wyswietlenia = " dystans: 128 "  ;
        9'b0_1000_0001: tekst_do_wyswietlenia = " dystans: 129 "  ;
        9'b0_1000_0010: tekst_do_wyswietlenia = " dystans: 130 "  ;
        9'b0_1000_0011: tekst_do_wyswietlenia = " dystans: 131 " ;
        9'b0_1000_0100: tekst_do_wyswietlenia = " dystans: 132 "  ;
        9'b0_1000_0101: tekst_do_wyswietlenia = " dystans: 133 " ;
        9'b0_1000_0110: tekst_do_wyswietlenia = " dystans: 134 "  ;
        9'b0_1000_0111: tekst_do_wyswietlenia = " dystans: 135 " ;
        9'b0_1000_1000: tekst_do_wyswietlenia = " dystans: 136 "  ;
        9'b0_1000_1001: tekst_do_wyswietlenia = " dystans: 137 " ;
        9'b0_1000_1010: tekst_do_wyswietlenia = " dystans: 138 "  ;
        9'b0_1000_1011: tekst_do_wyswietlenia = " dystans: 139 " ;
        9'b0_1000_1100: tekst_do_wyswietlenia = " dystans: 140 "  ;
        9'b0_1000_1101: tekst_do_wyswietlenia = " dystans: 141 " ;
        9'b0_1000_1110: tekst_do_wyswietlenia = " dystans: 142 "  ;
        9'b0_1000_1111: tekst_do_wyswietlenia = " dystans: 143 " ;
        9'b0_1001_0000: tekst_do_wyswietlenia = " dystans: 144 "  ;
        9'b0_1001_0001: tekst_do_wyswietlenia = " dystans: 145 "  ;
        9'b0_1001_0010: tekst_do_wyswietlenia = " dystans: 146 "  ;
        9'b0_1001_0011: tekst_do_wyswietlenia = " dystans: 147 " ;
        9'b0_1001_0100: tekst_do_wyswietlenia = " dystans: 148 "  ;
        9'b0_1001_0101: tekst_do_wyswietlenia = " dystans: 149 " ;
        9'b0_1001_0110: tekst_do_wyswietlenia = " dystans: 150 "  ;
        9'b0_1001_0111: tekst_do_wyswietlenia = " dystans: 151 " ;
        9'b0_1001_1000: tekst_do_wyswietlenia = " dystans: 152 "  ;
        9'b0_1001_1001: tekst_do_wyswietlenia = " dystans: 153 " ;
        9'b0_1001_1010: tekst_do_wyswietlenia = " dystans: 154 "  ;
        9'b0_1001_1011: tekst_do_wyswietlenia = " dystans: 155 " ;
        9'b0_1001_1100: tekst_do_wyswietlenia = " dystans: 156 "  ;
        9'b0_1001_1101: tekst_do_wyswietlenia = " dystans: 157 " ;
        9'b0_1001_1110: tekst_do_wyswietlenia = " dystans: 158 "  ;
        9'b0_1001_1111: tekst_do_wyswietlenia = " dystans: 159 " ; 
        9'b0_1010_0000: tekst_do_wyswietlenia = " dystans: 160 "  ;
        9'b0_1010_0001: tekst_do_wyswietlenia = " dystans: 161 "  ;
        9'b0_1010_0010: tekst_do_wyswietlenia = " dystans: 162 "  ;
        9'b0_1010_0011: tekst_do_wyswietlenia = " dystans: 163 " ;
        9'b0_1010_0100: tekst_do_wyswietlenia = " dystans: 164 "  ;
        9'b0_1010_0101: tekst_do_wyswietlenia = " dystans: 165 " ;
        9'b0_1010_0110: tekst_do_wyswietlenia = " dystans: 166 "  ;
        9'b0_1010_0111: tekst_do_wyswietlenia = " dystans: 167 " ;
        9'b0_1010_1000: tekst_do_wyswietlenia = " dystans: 168 "  ;
        9'b0_1010_1001: tekst_do_wyswietlenia = " dystans: 169 " ;
        9'b0_1010_1010: tekst_do_wyswietlenia = " dystans: 170 "  ;
        9'b0_1010_1011: tekst_do_wyswietlenia = " dystans: 171 " ;
        9'b0_1010_1100: tekst_do_wyswietlenia = " dystans: 172 "  ;
        9'b0_1010_1101: tekst_do_wyswietlenia = " dystans: 173 " ;
        9'b0_1010_1110: tekst_do_wyswietlenia = " dystans: 174 "  ;
        9'b0_1010_1111: tekst_do_wyswietlenia = " dystans: 175 " ;
        9'b0_1011_0000: tekst_do_wyswietlenia = " dystans: 176 "  ;
        9'b0_1011_0001: tekst_do_wyswietlenia = " dystans: 177 "  ;
        9'b0_1011_0010: tekst_do_wyswietlenia = " dystans: 178 "  ;
        9'b0_1011_0011: tekst_do_wyswietlenia = " dystans: 179 " ;
        9'b0_1011_0100: tekst_do_wyswietlenia = " dystans: 180 "  ;
        9'b0_1011_0101: tekst_do_wyswietlenia = " dystans: 181 " ;
        9'b0_1011_0110: tekst_do_wyswietlenia = " dystans: 182 "  ;
        9'b0_1011_0111: tekst_do_wyswietlenia = " dystans: 183 " ;
        9'b0_1011_1000: tekst_do_wyswietlenia = " dystans: 184 "  ;
        9'b0_1011_1001: tekst_do_wyswietlenia = " dystans: 185 " ;
        9'b0_1011_1010: tekst_do_wyswietlenia = " dystans: 186 "  ;
        9'b0_1011_1011: tekst_do_wyswietlenia = " dystans: 187 " ;
        9'b0_1011_1100: tekst_do_wyswietlenia = " dystans: 188 "  ;
        9'b0_1011_1101: tekst_do_wyswietlenia = " dystans: 189 " ;
        9'b0_1011_1110: tekst_do_wyswietlenia = " dystans: 190 "  ;
        9'b0_1011_1111: tekst_do_wyswietlenia = " dystans: 191 " ;
        9'b0_1100_0000: tekst_do_wyswietlenia = " dystans: 192 "  ;
        9'b0_1100_0001: tekst_do_wyswietlenia = " dystans: 193 "  ;
        9'b0_1100_0010: tekst_do_wyswietlenia = " dystans: 194 "  ;
        9'b0_1100_0011: tekst_do_wyswietlenia = " dystans: 195 " ;
        9'b0_1100_0100: tekst_do_wyswietlenia = " dystans: 196 "  ;
        9'b0_1100_0101: tekst_do_wyswietlenia = " dystans: 197 " ;
        9'b0_1100_0110: tekst_do_wyswietlenia = " dystans: 198 "  ;
        9'b0_1100_0111: tekst_do_wyswietlenia = " dystans: 199 " ;
        9'b0_1100_1000: tekst_do_wyswietlenia = " dystans: 200 "  ;
        9'b0_1100_1001: tekst_do_wyswietlenia = " dystans: 201 " ;
        9'b0_1100_1010: tekst_do_wyswietlenia = " dystans: 202 "  ;
        9'b0_1100_1011: tekst_do_wyswietlenia = " dystans: 203 " ;
        9'b0_1100_1100: tekst_do_wyswietlenia = " dystans: 204 "  ;
        9'b0_1100_1101: tekst_do_wyswietlenia = " dystans: 205 " ;
        9'b0_1100_1110: tekst_do_wyswietlenia = " dystans: 206 "  ;
        9'b0_1100_1111: tekst_do_wyswietlenia = " dystans: 207 " ;        
        9'b0_1101_0000: tekst_do_wyswietlenia = " dystans: 208 "  ;
        9'b0_1101_0001: tekst_do_wyswietlenia = " dystans: 209 "  ;
        9'b0_1101_0010: tekst_do_wyswietlenia = " dystans: 210 "  ;
        9'b0_1101_0011: tekst_do_wyswietlenia = " dystans: 211 " ;
        9'b0_1101_0100: tekst_do_wyswietlenia = " dystans: 212 "  ;
        9'b0_1101_0101: tekst_do_wyswietlenia = " dystans: 213 " ;
        9'b0_1101_0110: tekst_do_wyswietlenia = " dystans: 214 "  ;
        9'b0_1101_0111: tekst_do_wyswietlenia = " dystans: 215 " ;
        9'b0_1101_1000: tekst_do_wyswietlenia = " dystans: 216 "  ;
        9'b0_1101_1001: tekst_do_wyswietlenia = " dystans: 217 " ;
        9'b0_1101_1010: tekst_do_wyswietlenia = " dystans: 218 "  ;
        9'b0_1101_1011: tekst_do_wyswietlenia = " dystans: 219 " ;
        9'b0_1101_1100: tekst_do_wyswietlenia = " dystans: 220 "  ;
        9'b0_1101_1101: tekst_do_wyswietlenia = " dystans: 221 " ;
        9'b0_1101_1110: tekst_do_wyswietlenia = " dystans: 222 "  ;
        9'b0_1101_1111: tekst_do_wyswietlenia = " dystans: 223 " ; 
        9'b0_1110_0000: tekst_do_wyswietlenia = " dystans: 224 "  ;
        9'b0_1110_0001: tekst_do_wyswietlenia = " dystans: 225 "  ;
        9'b0_1110_0010: tekst_do_wyswietlenia = " dystans: 226 "  ;
        9'b0_1110_0011: tekst_do_wyswietlenia = " dystans: 227 " ;
        9'b0_1110_0100: tekst_do_wyswietlenia = " dystans: 228 "  ;
        9'b0_1110_0101: tekst_do_wyswietlenia = " dystans: 229 " ;
        9'b0_1110_0110: tekst_do_wyswietlenia = " dystans: 230 "  ;
        9'b0_1110_0111: tekst_do_wyswietlenia = " dystans: 231 " ;
        9'b0_1110_1000: tekst_do_wyswietlenia = " dystans: 232 "  ;
        9'b0_1110_1001: tekst_do_wyswietlenia = " dystans: 233 " ;
        9'b0_1110_1010: tekst_do_wyswietlenia = " dystans: 234 "  ;
        9'b0_1110_1011: tekst_do_wyswietlenia = " dystans: 235 " ;
        9'b0_1110_1100: tekst_do_wyswietlenia = " dystans: 236 "  ;
        9'b0_1110_1101: tekst_do_wyswietlenia = " dystans: 237 " ;
        9'b0_1110_1110: tekst_do_wyswietlenia = " dystans: 238 "  ;
        9'b0_1110_1111: tekst_do_wyswietlenia = " dystans: 239 " ;
        9'b0_1111_0000: tekst_do_wyswietlenia = " dystans: 240 "  ;
        9'b0_1111_0001: tekst_do_wyswietlenia = " dystans: 241 "  ;
        9'b0_1111_0010: tekst_do_wyswietlenia = " dystans: 242 "  ;
        9'b0_1111_0011: tekst_do_wyswietlenia = " dystans: 243 " ;
        9'b0_1111_0100: tekst_do_wyswietlenia = " dystans: 244 "  ;
        9'b0_1111_0101: tekst_do_wyswietlenia = " dystans: 245 " ;
        9'b0_1111_0110: tekst_do_wyswietlenia = " dystans: 246 "  ;
        9'b0_1111_0111: tekst_do_wyswietlenia = " dystans: 247 " ;
        9'b0_1111_1000: tekst_do_wyswietlenia = " dystans: 248 "  ;
        9'b0_1111_1001: tekst_do_wyswietlenia = " dystans: 249 " ;
        9'b0_1111_1010: tekst_do_wyswietlenia = " dystans: 250 "  ;
        9'b0_1111_1011: tekst_do_wyswietlenia = " dystans: 251 " ;
        9'b0_1111_1100: tekst_do_wyswietlenia = " dystans: 252 "  ;
        9'b0_1111_1101: tekst_do_wyswietlenia = " dystans: 253 " ;
        9'b0_1111_1110: tekst_do_wyswietlenia = " dystans: 254 "  ;
        9'b0_1111_1111: tekst_do_wyswietlenia = " dystans: 255 " ;
        9'b1_0000_0000: tekst_do_wyswietlenia = " dystans: 256 "  ;
        9'b1_0000_0001: tekst_do_wyswietlenia = " dystans: 257 " ;
        9'b1_0000_0010: tekst_do_wyswietlenia = " dystans: 258 "  ;
        9'b1_0000_0011: tekst_do_wyswietlenia = " dystans: 259 " ;
        9'b1_0000_0100: tekst_do_wyswietlenia = " dystans: 260 "  ;
        9'b1_0000_0101: tekst_do_wyswietlenia = " dystans: 261 " ;
        9'b1_0000_0110: tekst_do_wyswietlenia = " dystans: 262 "  ;
        9'b1_0000_0111: tekst_do_wyswietlenia = " dystans: 263 " ;
        9'b1_0000_1000: tekst_do_wyswietlenia = " dystans: 264 "  ;
        9'b1_0000_1001: tekst_do_wyswietlenia = " dystans: 265 " ;
        9'b1_0000_1010: tekst_do_wyswietlenia = " dystans: 266 "  ;
        9'b1_0000_1011: tekst_do_wyswietlenia = " dystans: 267 " ;
        9'b1_0000_1100: tekst_do_wyswietlenia = " dystans: 268 "  ;
        9'b1_0000_1101: tekst_do_wyswietlenia = " dystans: 269 " ;
        9'b1_0000_1110: tekst_do_wyswietlenia = " dystans: 270 "  ;
        9'b1_0000_1111: tekst_do_wyswietlenia = " dystans: 271 " ;
        9'b1_0001_0000: tekst_do_wyswietlenia = " dystans: 272 "  ;
        9'b1_0001_0001: tekst_do_wyswietlenia = " dystans: 273 " ;
        9'b1_0001_0010: tekst_do_wyswietlenia = " dystans: 274 "  ;
        9'b1_0001_0011: tekst_do_wyswietlenia = " dystans: 275 " ;
        9'b1_0001_0100: tekst_do_wyswietlenia = " dystans: 276 "  ;
        9'b1_0001_0101: tekst_do_wyswietlenia = " dystans: 277 " ;
        9'b1_0001_0110: tekst_do_wyswietlenia = " dystans: 278 "  ;
        9'b1_0001_0111: tekst_do_wyswietlenia = " dystans: 279 " ;
        9'b1_0001_1000: tekst_do_wyswietlenia = " dystans: 280 "  ;
        9'b1_0001_1001: tekst_do_wyswietlenia = " dystans: 281 " ;
        9'b1_0001_1010: tekst_do_wyswietlenia = " dystans: 282 "  ;
        9'b1_0001_1011: tekst_do_wyswietlenia = " dystans: 283 " ;
        9'b1_0001_1100: tekst_do_wyswietlenia = " dystans: 284 "  ;
        9'b1_0001_1101: tekst_do_wyswietlenia = " dystans: 285 " ;
        9'b1_0001_1110: tekst_do_wyswietlenia = " dystans: 286 "  ;
        9'b1_0001_1111: tekst_do_wyswietlenia = " dystans: 287 " ;
        9'b1_0010_0000: tekst_do_wyswietlenia = " dystans: 288 "  ;
        9'b1_0010_0001: tekst_do_wyswietlenia = " dystans: 289 " ;
        9'b1_0010_0010: tekst_do_wyswietlenia = " dystans: 290 "  ;
        9'b1_0010_0011: tekst_do_wyswietlenia = " dystans: 291 " ;
        9'b1_0010_0100: tekst_do_wyswietlenia = " dystans: 292 "  ;
        9'b1_0010_0101: tekst_do_wyswietlenia = " dystans: 293 " ;
        9'b1_0010_0110: tekst_do_wyswietlenia = " dystans: 294 "  ;
        9'b1_0010_0111: tekst_do_wyswietlenia = " dystans: 295 " ;
        9'b1_0010_1000: tekst_do_wyswietlenia = " dystans: 296 "  ;
        9'b1_0010_1001: tekst_do_wyswietlenia = " dystans: 297 " ;
        9'b1_0010_1010: tekst_do_wyswietlenia = " dystans: 298 "  ;
        9'b1_0010_1011: tekst_do_wyswietlenia = " dystans: 299 " ;
        9'b1_0010_1100: tekst_do_wyswietlenia = " dystans: 300 "  ;
        9'b1_0010_1101: tekst_do_wyswietlenia = " dystans: 301 " ;
        9'b1_0010_1110: tekst_do_wyswietlenia = " dystans: 302 "  ;
        9'b1_0010_1111: tekst_do_wyswietlenia = " dystans: 303 " ;
        9'b1_0011_0000: tekst_do_wyswietlenia = " dystans: 304 "  ;
        9'b1_0011_0001: tekst_do_wyswietlenia = " dystans: 305 " ;
        9'b1_0011_0010: tekst_do_wyswietlenia = " dystans: 306 "  ;
        9'b1_0011_0011: tekst_do_wyswietlenia = " dystans: 307 " ;
        9'b1_0011_0100: tekst_do_wyswietlenia = " dystans: 308 "  ;
        9'b1_0011_0101: tekst_do_wyswietlenia = " dystans: 309 " ;
        9'b1_0011_0110: tekst_do_wyswietlenia = " dystans: 310 "  ;
        9'b1_0011_0111: tekst_do_wyswietlenia = " dystans: 311 " ;
        9'b1_0011_1000: tekst_do_wyswietlenia = " dystans: 312 "  ;
        9'b1_0011_1001: tekst_do_wyswietlenia = " dystans: 313 " ;
        9'b1_0011_1010: tekst_do_wyswietlenia = " dystans: 314 "  ;
        9'b1_0011_1011: tekst_do_wyswietlenia = " dystans: 315 " ;
        9'b1_0011_1100: tekst_do_wyswietlenia = " dystans: 316 "  ;
        9'b1_0011_1101: tekst_do_wyswietlenia = " dystans: 317 " ;
        9'b1_0011_1110: tekst_do_wyswietlenia = " dystans: 318 "  ;
        9'b1_0011_1111: tekst_do_wyswietlenia = " dystans: 319 " ;
        9'b1_0100_0000: tekst_do_wyswietlenia = " dystans: 320 "  ;
        9'b1_0100_0001: tekst_do_wyswietlenia = " dystans: 321 "  ;
        9'b1_0100_0010: tekst_do_wyswietlenia = " dystans: 322 "  ;
        9'b1_0100_0011: tekst_do_wyswietlenia = " dystans: 323 " ;
        9'b1_0100_0100: tekst_do_wyswietlenia = " dystans: 324 "  ;
        9'b1_0100_0101: tekst_do_wyswietlenia = " dystans: 325 " ;
        9'b1_0100_0110: tekst_do_wyswietlenia = " dystans: 326 "  ;
        9'b1_0100_0111: tekst_do_wyswietlenia = " dystans: 327 " ;
        9'b1_0100_1000: tekst_do_wyswietlenia = " dystans: 328 "  ;
        9'b1_0100_1001: tekst_do_wyswietlenia = " dystans: 329 " ;
        9'b1_0100_1010: tekst_do_wyswietlenia = " dystans: 330 "  ;
        9'b1_0100_1011: tekst_do_wyswietlenia = " dystans: 331 " ;
        9'b1_0100_1100: tekst_do_wyswietlenia = " dystans: 332 "  ;
        9'b1_0100_1101: tekst_do_wyswietlenia = " dystans: 333 " ;
        9'b1_0100_1110: tekst_do_wyswietlenia = " dystans: 334 "  ;
        9'b1_0100_1111: tekst_do_wyswietlenia = " dystans: 335 " ;
        9'b1_0101_0000: tekst_do_wyswietlenia = " dystans: 336 "  ;
        9'b1_0101_0001: tekst_do_wyswietlenia = " dystans: 337 "  ;
        9'b1_0101_0010: tekst_do_wyswietlenia = " dystans: 338 "  ;
        9'b1_0101_0011: tekst_do_wyswietlenia = " dystans: 339 " ;
        9'b1_0101_0100: tekst_do_wyswietlenia = " dystans: 340 "  ;
        9'b1_0101_0101: tekst_do_wyswietlenia = " dystans: 341 " ;
        9'b1_0101_0110: tekst_do_wyswietlenia = " dystans: 342 "  ;
        9'b1_0101_0111: tekst_do_wyswietlenia = " dystans: 343 " ;
        9'b1_0101_1000: tekst_do_wyswietlenia = " dystans: 344 "  ;
        9'b1_0101_1001: tekst_do_wyswietlenia = " dystans: 345 " ;
        9'b1_0101_1010: tekst_do_wyswietlenia = " dystans: 346 "  ;
        9'b1_0101_1011: tekst_do_wyswietlenia = " dystans: 347 " ;
        9'b1_0101_1100: tekst_do_wyswietlenia = " dystans: 348 "  ;
        9'b1_0101_1101: tekst_do_wyswietlenia = " dystans: 349 " ;
        9'b1_0101_1110: tekst_do_wyswietlenia = " dystans: 350 "  ;
        9'b1_0101_1111: tekst_do_wyswietlenia = " dystans: 351 " ;
        9'b1_0110_0000: tekst_do_wyswietlenia = " dystans: 352 "  ;
        9'b1_0110_0001: tekst_do_wyswietlenia = " dystans: 353 "  ;
        9'b1_0110_0010: tekst_do_wyswietlenia = " dystans: 354 "  ;
        9'b1_0110_0011: tekst_do_wyswietlenia = " dystans: 355 " ;
        9'b1_0110_0100: tekst_do_wyswietlenia = " dystans: 356 "  ;
        9'b1_0110_0101: tekst_do_wyswietlenia = " dystans: 357 " ;
        9'b1_0110_0110: tekst_do_wyswietlenia = " dystans: 358 "  ;
        9'b1_0110_0111: tekst_do_wyswietlenia = " dystans: 359 " ;
        9'b1_0110_1000: tekst_do_wyswietlenia = " dystans: 360 "  ;
        9'b1_0110_1001: tekst_do_wyswietlenia = " dystans: 361 " ;
        9'b1_0110_1010: tekst_do_wyswietlenia = " dystans: 362 "  ;
        9'b1_0110_1011: tekst_do_wyswietlenia = " dystans: 363 " ;
        9'b1_0110_1100: tekst_do_wyswietlenia = " dystans: 364 "  ;
        9'b1_0110_1101: tekst_do_wyswietlenia = " dystans: 365 " ;
        9'b1_0110_1110: tekst_do_wyswietlenia = " dystans: 366 "  ;
        9'b1_0110_1111: tekst_do_wyswietlenia = " dystans: 367 " ;
        9'b1_0111_0000: tekst_do_wyswietlenia = " dystans: 368 "  ;
        9'b1_0111_0001: tekst_do_wyswietlenia = " dystans: 369 "  ;
        9'b1_0111_0010: tekst_do_wyswietlenia = " dystans: 370 "  ;
        9'b1_0111_0011: tekst_do_wyswietlenia = " dystans: 371 " ;
        9'b1_0111_0100: tekst_do_wyswietlenia = " dystans: 372 "  ;
        9'b1_0111_0101: tekst_do_wyswietlenia = " dystans: 373 " ;
        9'b1_0111_0110: tekst_do_wyswietlenia = " dystans: 374 "  ;
        9'b1_0111_0111: tekst_do_wyswietlenia = " dystans: 375 " ;
        9'b1_0111_1000: tekst_do_wyswietlenia = " dystans: 376 "  ;
        9'b1_0111_1001: tekst_do_wyswietlenia = " dystans: 377 " ;
        9'b1_0111_1010: tekst_do_wyswietlenia = " dystans: 378 "  ;
        9'b1_0111_1011: tekst_do_wyswietlenia = " dystans: 379 " ;
        9'b1_0111_1100: tekst_do_wyswietlenia = " dystans: 380 "  ;
        9'b1_0111_1101: tekst_do_wyswietlenia = " dystans: 381 " ;
        9'b1_0111_1110: tekst_do_wyswietlenia = " dystans: 382 "  ;
        9'b1_0111_1111: tekst_do_wyswietlenia = " dystans: 383 " ;
        9'b1_1000_0000: tekst_do_wyswietlenia = " dystans: 384 "  ;
        9'b1_1000_0001: tekst_do_wyswietlenia = " dystans: 385 "  ;
        9'b1_1000_0010: tekst_do_wyswietlenia = " dystans: 386 "  ;
        9'b1_1000_0011: tekst_do_wyswietlenia = " dystans: 387 " ;
        9'b1_1000_0100: tekst_do_wyswietlenia = " dystans: 388 "  ;
        9'b1_1000_0101: tekst_do_wyswietlenia = " dystans: 389 " ;
        9'b1_1000_0110: tekst_do_wyswietlenia = " dystans: 390 "  ;
        9'b1_1000_0111: tekst_do_wyswietlenia = " dystans: 391 " ;
        9'b1_1000_1000: tekst_do_wyswietlenia = " dystans: 392 "  ;
        9'b1_1000_1001: tekst_do_wyswietlenia = " dystans: 393 " ;
        9'b1_1000_1010: tekst_do_wyswietlenia = " dystans: 394 "  ;
        9'b1_1000_1011: tekst_do_wyswietlenia = " dystans: 395 " ;
        9'b1_1000_1100: tekst_do_wyswietlenia = " dystans: 396 "  ;
        9'b1_1000_1101: tekst_do_wyswietlenia = " dystans: 397 " ;
        9'b1_1000_1110: tekst_do_wyswietlenia = " dystans: 398 "  ;
        9'b1_1000_1111: tekst_do_wyswietlenia = " dystans: 399 " ;
        9'b1_1001_0000: tekst_do_wyswietlenia = " dystans: 400 "  ;
        9'b1_1001_0001: tekst_do_wyswietlenia = " dystans: 401 "  ;
        9'b1_1001_0010: tekst_do_wyswietlenia = " dystans: 402 "  ;
        9'b1_1001_0011: tekst_do_wyswietlenia = " dystans: 403 " ;
        9'b1_1001_0100: tekst_do_wyswietlenia = " dystans: 404 "  ;
        9'b1_1001_0101: tekst_do_wyswietlenia = " dystans: 405 " ;
        9'b1_1001_0110: tekst_do_wyswietlenia = " dystans: 406 "  ;
        9'b1_1001_0111: tekst_do_wyswietlenia = " dystans: 407 " ;
        9'b1_1001_1000: tekst_do_wyswietlenia = " dystans: 408 "  ;
        9'b1_1001_1001: tekst_do_wyswietlenia = " dystans: 409 " ;
        9'b1_1001_1010: tekst_do_wyswietlenia = " dystans: 410 "  ;
        9'b1_1001_1011: tekst_do_wyswietlenia = " dystans: 411 " ;
        9'b1_1001_1100: tekst_do_wyswietlenia = " dystans: 412 "  ;
        9'b1_1001_1101: tekst_do_wyswietlenia = " dystans: 413 " ;
        9'b1_1001_1110: tekst_do_wyswietlenia = " dystans: 414 "  ;
        9'b1_1001_1111: tekst_do_wyswietlenia = " dystans: 415 " ;
        9'b1_1010_0000: tekst_do_wyswietlenia = " dystans: 416 "  ;
        9'b1_1010_0001: tekst_do_wyswietlenia = " dystans: 417 "  ;
        9'b1_1010_0010: tekst_do_wyswietlenia = " dystans: 418 "  ;
        9'b1_1010_0011: tekst_do_wyswietlenia = " dystans: 419 " ;
        9'b1_1010_0100: tekst_do_wyswietlenia = " dystans: 420 "  ;
        9'b1_1010_0101: tekst_do_wyswietlenia = " dystans: 421 " ;
        9'b1_1010_0110: tekst_do_wyswietlenia = " dystans: 422 "  ;
        9'b1_1010_0111: tekst_do_wyswietlenia = " dystans: 423 " ;
        9'b1_1010_1000: tekst_do_wyswietlenia = " dystans: 424 "  ;
        9'b1_1010_1001: tekst_do_wyswietlenia = " dystans: 425 " ;
        9'b1_1010_1010: tekst_do_wyswietlenia = " dystans: 426 "  ;
        9'b1_1010_1011: tekst_do_wyswietlenia = " dystans: 427 " ;
        9'b1_1010_1100: tekst_do_wyswietlenia = " dystans: 428 "  ;
        9'b1_1010_1101: tekst_do_wyswietlenia = " dystans: 429 " ;
        9'b1_1010_1110: tekst_do_wyswietlenia = " dystans: 430 "  ;
        9'b1_1010_1111: tekst_do_wyswietlenia = " dystans: 431 " ;              
        9'b1_1011_0000: tekst_do_wyswietlenia = " dystans: 432 "  ;
        9'b1_1011_0001: tekst_do_wyswietlenia = " dystans: 433 "  ;
        9'b1_1011_0010: tekst_do_wyswietlenia = " dystans: 434 "  ;
        9'b1_1011_0011: tekst_do_wyswietlenia = " dystans: 435 " ;
        9'b1_1011_0100: tekst_do_wyswietlenia = " dystans: 436 "  ;
        9'b1_1011_0101: tekst_do_wyswietlenia = " dystans: 437 " ;
        9'b1_1011_0110: tekst_do_wyswietlenia = " dystans: 438 "  ;
        9'b1_1011_0111: tekst_do_wyswietlenia = " dystans: 439 " ;
        9'b1_1011_1000: tekst_do_wyswietlenia = " dystans: 440 "  ;
        9'b1_1011_1001: tekst_do_wyswietlenia = " dystans: 441 " ;
        9'b1_1011_1010: tekst_do_wyswietlenia = " dystans: 442 "  ;
        9'b1_1011_1011: tekst_do_wyswietlenia = " dystans: 443 " ;
        9'b1_1011_1100: tekst_do_wyswietlenia = " dystans: 444 "  ;
        9'b1_1011_1101: tekst_do_wyswietlenia = " dystans: 445 " ;
        9'b1_1011_1110: tekst_do_wyswietlenia = " dystans: 446 "  ;
        9'b1_1011_1111: tekst_do_wyswietlenia = " dystans: 447 " ;
        9'b1_1100_0000: tekst_do_wyswietlenia = " dystans: 448 "  ;
        9'b1_1100_0001: tekst_do_wyswietlenia = " dystans: 449 "  ;
        9'b1_1100_0010: tekst_do_wyswietlenia = " dystans: 450 "  ;
        9'b1_1100_0011: tekst_do_wyswietlenia = " dystans: 451 " ;
        9'b1_1100_0100: tekst_do_wyswietlenia = " dystans: 452 "  ;
        9'b1_1100_0101: tekst_do_wyswietlenia = " dystans: 453 " ;
        9'b1_1100_0110: tekst_do_wyswietlenia = " dystans: 454 "  ;
        9'b1_1100_0111: tekst_do_wyswietlenia = " dystans: 455 " ;
        9'b1_1100_1000: tekst_do_wyswietlenia = " dystans: 456 "  ;
        9'b1_1100_1001: tekst_do_wyswietlenia = " dystans: 457 " ;
        9'b1_1100_1010: tekst_do_wyswietlenia = " dystans: 458 "  ;
        9'b1_1100_1011: tekst_do_wyswietlenia = " dystans: 459 " ;
        9'b1_1100_1100: tekst_do_wyswietlenia = " dystans: 460 "  ;
        9'b1_1100_1101: tekst_do_wyswietlenia = " dystans: 461 " ;
        9'b1_1100_1110: tekst_do_wyswietlenia = " dystans: 462 "  ;
        9'b1_1100_1111: tekst_do_wyswietlenia = " dystans: 463 " ;
        9'b1_1101_0000: tekst_do_wyswietlenia = " dystans: 464 "  ;
        9'b1_1101_0001: tekst_do_wyswietlenia = " dystans: 465 "  ;
        9'b1_1101_0010: tekst_do_wyswietlenia = " dystans: 466 "  ;
        9'b1_1101_0011: tekst_do_wyswietlenia = " dystans: 467 " ;
        9'b1_1101_0100: tekst_do_wyswietlenia = " dystans: 468 "  ;
        9'b1_1101_0101: tekst_do_wyswietlenia = " dystans: 469 " ;
        9'b1_1101_0110: tekst_do_wyswietlenia = " dystans: 470 "  ;
        9'b1_1101_0111: tekst_do_wyswietlenia = " dystans: 471 " ;
        9'b1_1101_1000: tekst_do_wyswietlenia = " dystans: 472 "  ;
        9'b1_1101_1001: tekst_do_wyswietlenia = " dystans: 473 " ;
        9'b1_1101_1010: tekst_do_wyswietlenia = " dystans: 474 "  ;
        9'b1_1101_1011: tekst_do_wyswietlenia = " dystans: 475 " ;
        9'b1_1101_1100: tekst_do_wyswietlenia = " dystans: 476 "  ;
        9'b1_1101_1101: tekst_do_wyswietlenia = " dystans: 477 " ;
        9'b1_1101_1110: tekst_do_wyswietlenia = " dystans: 478 "  ;
        9'b1_1101_1111: tekst_do_wyswietlenia = " dystans: 479 " ;
        9'b1_1110_0000: tekst_do_wyswietlenia = " dystans: 480 "  ;
        9'b1_1110_0001: tekst_do_wyswietlenia = " dystans: 481 "  ;
        9'b1_1110_0010: tekst_do_wyswietlenia = " dystans: 482 "  ;
        9'b1_1110_0011: tekst_do_wyswietlenia = " dystans: 483 " ;
        9'b1_1110_0100: tekst_do_wyswietlenia = " dystans: 484 "  ;
        9'b1_1110_0101: tekst_do_wyswietlenia = " dystans: 485 " ;
        9'b1_1110_0110: tekst_do_wyswietlenia = " dystans: 486 "  ;
        9'b1_1110_0111: tekst_do_wyswietlenia = " dystans: 487 " ;
        9'b1_1110_1000: tekst_do_wyswietlenia = " dystans: 488 "  ;
        9'b1_1110_1001: tekst_do_wyswietlenia = " dystans: 489 " ;
        9'b1_1110_1010: tekst_do_wyswietlenia = " dystans: 490 "  ;
        9'b1_1110_1011: tekst_do_wyswietlenia = " dystans: 491 " ;
        9'b1_1110_1100: tekst_do_wyswietlenia = " dystans: 492 "  ;
        9'b1_1110_1101: tekst_do_wyswietlenia = " dystans: 493 " ;
        9'b1_1110_1110: tekst_do_wyswietlenia = " dystans: 494 "  ;
        9'b1_1110_1111: tekst_do_wyswietlenia = " dystans: 495 " ;
        9'b1_1111_0000: tekst_do_wyswietlenia = " dystans: 496 "  ;
        9'b1_1111_0001: tekst_do_wyswietlenia = " dystans: 497 "  ;
        9'b1_1111_0010: tekst_do_wyswietlenia = " dystans: 498 "  ;
        9'b1_1111_0011: tekst_do_wyswietlenia = " dystans: 499 " ;
        9'b1_1111_0100: tekst_do_wyswietlenia = " dystans: 500 "  ;
      default: tekst_do_wyswietlenia = " poza zakresem" ; 
    endcase 
   end
   //reg [(8*string_length -1):0] tekst_do_wyswietlenia = "In principio erat Verbum, et Verbum erat apud Deum, et Deus erat Verbum. Hoc erat in principio apud Deum. Omnia per ipsum facta sunt: et sine ipso factum est nihil, quod factum est: in ipso vita erat, et vita erat lux hominum: et lux in tenebris lucet, et";
   assign char_code = {
    tekst_do_wyswietlenia[((string_length*8) - 9)  - char_xy*8], //[char_xy-7]
    tekst_do_wyswietlenia[((string_length*8) - 10) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 11) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 12) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 13) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 14) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 15) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 16) - char_xy*8] };
    //assign char_code =7'h61;

endmodule
