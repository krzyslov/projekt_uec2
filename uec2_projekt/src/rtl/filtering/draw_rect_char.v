// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module draw_rect_char (
  output reg [11:0] rgb_out,
  output reg [10:0] hcount_out,
  output reg [10:0] vcount_out,
  output wire [3:0] char_line,
  output wire [4:0] char_xy,
  
  
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
    .din( {hcount_in, vcount_in,  rgb_in}),
    .dout({hcount_dl, vcount_dl, rgb_dl})
    );

   // reg [2:0] char_y;
    reg [4:0] char_x;
    
    
    localparam rect_x =140 , rect_width = 240;
    localparam rect_y = 464, rect_height = 16;
    
    localparam FRAME_X_POS = 10 ,
               FRAME_Y_POS = 10 ,
               FRAME_X_PIX = 630,           
               FRAME_Y_PIX = 450,
               FRAME_RGB = 12'h0_0_1;
   
    
    assign char_xy = {char_x[4:0]};
    assign char_line = {(vcount_in - rect_y) % 16};//4'h6;

    
    
    always @(*) begin
    
    
        if ((hcount_dl >= rect_x ) & (hcount_dl < rect_x + rect_width) & (vcount_dl >= rect_y ) & ( vcount_dl < rect_y + rect_height)) begin
    
                if ( char_pixels[3'd7 - ((hcount_dl - rect_x)%8)] == 1'b1 ) begin
                        rgb_nxt[11:0] = 12'hFFF;
                end else begin
                        rgb_nxt = 12'h000;
                end 
            end else begin
            if((hcount_in <= FRAME_X_POS) || (hcount_in > (FRAME_X_PIX)) || (vcount_in <= FRAME_Y_POS) || (vcount_in > (FRAME_Y_PIX)) ) 
                begin
                    rgb_nxt  = FRAME_RGB;
                end else begin
                    
                    if (( hcount_in == 0 )||(hcount_in == FRAME_X_POS)) begin
                        rgb_nxt = 12'hFFF;
                    end else if ( hcount_in == FRAME_X_PIX + 1) begin
                        rgb_nxt = 12'hFFF;
                    end else if ( ( vcount_in == 0 ) ||(vcount_in == FRAME_Y_POS) ) begin
                        rgb_nxt = 12'hFFF;
                    end else if ( vcount_in == FRAME_Y_PIX ) begin
                        rgb_nxt = 12'hFFF;
                    end else begin
                        rgb_nxt = rgb_dl;
                    end
                    
                
                end
                 
            
            end 
    
        end
    
    always @(posedge pclk) begin
        if(rst) begin
            vcount_out  <= 0;
            hcount_out  <= 0;
            rgb_out     <= 0;
          //  char_y      <= 0;
            char_x      <= 0;
        end else begin
            vcount_out  <= vcount_dl;
            hcount_out  <= hcount_dl;
            rgb_out     <= rgb_nxt; //rgb_nxt;
            //char_y      <= (vcount_in - rect_y)/16;
            char_x      <= (hcount_in - rect_x)/8;
        end
        
    end
    

endmodule
