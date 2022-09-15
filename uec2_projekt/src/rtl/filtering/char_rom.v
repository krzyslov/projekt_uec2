//////////////////////////////////////////////////////////////////////////////////
// Company: Akademia Górniczo-Hutnicza w Krakowie
// Engineer: Benedykt Bekasiak
// Create Date: 15.09.2022 10:18:28
// Project Name: Ardudido
// Tool Versions: Vivado 2017.3
//////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module char_rom (
    input wire [4:0] char_xy,
    output wire [6:0] char_code,
    input wire [3:0]sw
  );
  localparam string_length = 30;
  reg [(8*string_length -1):0] tekst_do_wyswietlenia;
  
  
   always @* begin
    case(sw[3:0])
       4'b0000: tekst_do_wyswietlenia = " filtr: RGB2Gray              "  ;
       4'b0001: tekst_do_wyswietlenia = " filtr: Increase Brightness   " ;
       4'b0010: tekst_do_wyswietlenia = " filtr: Decrease Brightness   " ;
       4'b0011: tekst_do_wyswietlenia = " filtr: Colour Inversion      " ;
       4'b0100: tekst_do_wyswietlenia = " filtr: Red Filter            " ;
       4'b0101: tekst_do_wyswietlenia = " filtr: Blue Filter           " ;
       4'b0110: tekst_do_wyswietlenia = " filtr: Green Filter          " ;
       4'b0111: tekst_do_wyswietlenia = " filtr: Original Image        " ;
       4'b1000: tekst_do_wyswietlenia = " filtr: Average blurring      " ;
       4'b1001: tekst_do_wyswietlenia = " filtr: Sobel Edge Detection  " ;
       4'b1010: tekst_do_wyswietlenia = " filtr: Edge Detection        " ;
       4'b1011: tekst_do_wyswietlenia = " filtr: Motion Blurring XY    " ;
       4'b1100: tekst_do_wyswietlenia = " filtr: Emboss                " ;
       4'b1101: tekst_do_wyswietlenia = " filtr: Sharpen               " ;
       4'b1110: tekst_do_wyswietlenia = " filtr: Motion Blur X         " ;
       default: tekst_do_wyswietlenia = " Wybierz inna kombinacje      " ; 
    endcase 
   end
   assign char_code = {
    tekst_do_wyswietlenia[((string_length*8) - 9)  - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 10) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 11) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 12) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 13) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 14) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 15) - char_xy*8],
    tekst_do_wyswietlenia[((string_length*8) - 16) - char_xy*8] };

endmodule
