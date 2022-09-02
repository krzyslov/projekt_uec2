// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module char_rom (
    input wire [7:0] char_xy,
    output wire [6:0] char_code,
    input wire [3:0]sw
  );
  localparam string_length = 30;
  reg [(8*string_length -1):0] tekst_do_wyswietlenia;
  
   //[255:0]
// " filtr: RGB2Gray / Increase Brightness/ Decrease Brightness/ colour inversion / red filter 
//" /blue filter / green filter / original image
  
   always @* begin
    case(sw[3:0])
       4'b0000: tekst_do_wyswietlenia = "filtr: RGB2Gray               "  ;
       4'b0001: tekst_do_wyswietlenia = "filtr: Increase Brightness    " ;
       4'b0010: tekst_do_wyswietlenia = "filtr: Decrease Brightness    " ;
       4'b0011: tekst_do_wyswietlenia = "filtr: Colour Inversion       " ;
       4'b0100: tekst_do_wyswietlenia = "filtr: Red Filter             " ;
       4'b0101: tekst_do_wyswietlenia = "filtr: Blue Filter            " ;
       4'b0110: tekst_do_wyswietlenia = "filtr: Green Filter           " ;
       4'b0111: tekst_do_wyswietlenia = "filtr: Original Image         " ;
       default: tekst_do_wyswietlenia = "Wybierz jeden filtr           " ; 
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
