// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module draw_distance_char (
  //output reg vsync_out,
  //output reg vblnk_out,
  //output reg hsync_out,
  //output reg hblnk_out,
  output reg [11:0] rgb_out,
 // output reg [10:0] hcount_out,
 // output reg [10:0] vcount_out,
  output wire [3:0] char_line,
  output wire [6:0] char_xy,
  
  
  input wire [7:0] char_pixels,
  input wire [10:0] hcount_in,
  input wire [10:0] vcount_in,
  input wire [11:0] rgb_in,
  input wire pclk,
  input wire rst
  );
   
  wire [10:0] hcount_dl;
  wire [10:0] vcount_dl;
  wire [7:0] char_pixels_dl;
  wire [11:0] rgb_dl;
  reg  [11:0] rgb_nxt;


    delay #(
          .WIDTH (34), 
          .CLK_DEL(2)    
    ) my_delay(
    .rst(rst),
    .clk(pclk),
    .din( {hcount_in, vcount_in, rgb_in}),
    .dout({hcount_dl, vcount_dl,  rgb_dl})
    );

    reg [1:0] char_y;
    reg [3:0] char_x;
    

    localparam rect_x = 380 , rect_width = 120;
    localparam rect_y = 464, rect_height = 16;

   
    
    assign char_xy = {char_y[1:0], char_x[3:0]};
    assign char_line = {(vcount_in - rect_y) % 16};//4'h6;


    always @(*) begin
        
            if ((hcount_dl >= rect_x ) & (hcount_dl < rect_x + rect_width) & (vcount_dl >= rect_y ) & ( vcount_dl < rect_y + rect_height)) begin
    
                if ( char_pixels[3'd7 - ((hcount_dl - rect_x)%8)] == 1'b1 ) begin
                        rgb_nxt[11:0] = 12'hFFF;
                end else begin
                        rgb_nxt = 12'h000;
                end 
            end else begin
            
                 rgb_nxt = rgb_dl;
            
            end 
        
    end
    
    always @(posedge pclk) begin
        if(rst) begin
            rgb_out     <= 0;
            char_y      <= 0;
            char_x      <= 0;
        end else begin
            rgb_out     <= rgb_nxt;
            char_y      <= (vcount_in - rect_y)/16;
            char_x      <= (hcount_in - rect_x)/8;
        end
        
    end
    

endmodule
