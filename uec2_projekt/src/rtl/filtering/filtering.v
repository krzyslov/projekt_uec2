`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 04:26:40 PM
// Design Name: 
// Module Name: check
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01  - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module filtering(
input wire clock,
input wire reset,
input wire clk10,
//input wire hsync,
//input wire vsync,
input wire [3:0]sel_module,
input wire hsync_in,
input wire vsync_in,
//input wire [7:0]red_in, // Center
//input wire [7:0]green_in, // Center
//input wire [7:0]blue_in,  // Center       //inputs - sel_module(select required function), reset(to switch on and off), val(give a value to adjust brightness and filters)
input wire [23:0] rgb_in,
input wire [3:0] pixel_position,
input wire [10:0] Hcount_in,
input wire [10:0] Vcount_in,
input wire [23:0] rgb_up,
output reg [3:0]red,
output reg[3:0] green,
output reg[3:0] blue, 
output reg[10:0] hc,
output reg[10:0] vc,
output reg hblank,
output reg vblank,
output reg hsync,
output reg vsync,                   // red, green and blue output pixels
input wire Nblank
);
    
    // pixel position
    localparam
        position_center     = 4'b0000,
        position_up         = 4'b0001,
        position_down       = 4'b0010,
        position_left       = 4'b0011,
        position_right      = 4'b0100,
        position_left_up    = 4'b0101,
        position_left_down  = 4'b0110,
        position_right_up   = 4'b0111,
        position_right_down = 4'b1000;
    
    //input clock;
    //input reset;
    
    //input[3:0] sel_module;          // can select one of 16 functions
    reg [7:0] gray, left, right, up, down, leftup, leftdown, rightup, rightdown;  
    reg [7:0] gray_nxt, left_nxt, right_nxt, up_nxt, down_nxt, leftup_nxt, leftdown_nxt, rightup_nxt, rightdown_nxt;     //different values in matrix
    reg[7:0] red_o, blue_o, green_o,red_o_nxt,blue_o_nxt,green_o_nxt;            // variables used during calcultion
    reg [15:0] r, b, g;
    reg [3:0] r_nxt,g_nxt,b_nxt;                         // variables used during calcultion
    
 /*   
   reg clk;
   initial begin
   clk =0;
   end
   always@(posedge clock)
   begin
    clk<=~clk;
   end
   */
   
//lst = ["gray", "left", "right", "up", "down", "leftup", "leftdown", "rightup", "rightdown"] 

    reg [7:0] val = 8'b00000010;            // intialize value to zero
   	//output reg hsync;
   	//output reg vsync;
   	reg [7:0] tred,tgreen,tblue,tred_nxt,tgreen_nxt,tblue_nxt;
   	reg [3:0] red_nxt,green_nxt,blue_nxt;
	//output reg [3:0] red,green;
	//output reg [3:0] blue;

 
	reg read = 0;
	reg [14:0] addra = 0;
	reg [14:0] addra_nxt;
	reg [95:0] in1 = 0;
	wire [95:0] out2;
	
/*	
image  inst1(
  .clka(clk), // input clka
  .wea(read), // input [0 : 0] wea
  .addra(addra), // input [14 : 0] addra
  .dina(in1), // input [95 : 0] dina
  .douta(out2) // output [95 : 0] douta
);
*/
//   wire pixel_clk;
   reg 		pcount = 0;
   wire 	ec = (pcount == 0);
   always @ (posedge clock) pcount <= ~pcount;
  // assign 	pixel_clk = ec;
   //clock;
   
  	
   /*initial begin
    hsync =0;
    vsync=0;
    hblank=0;
    vblank=0;
   end*/
//   reg [9:0] 	hc=0;      
  // reg [9:0] 	vc=0;	 
	
   wire 	hsyncon,hsyncoff,hreset,hblankon; //
   assign 	hblankon = ec & (hc == 639);    
   assign 	hsyncon = ec & (hc == 655);
   assign 	hsyncoff = ec & (hc == 751);
   assign 	hreset = ec & (hc == 799);
   
   wire 	blank =  (vblank | (hblank & ~hreset));    
   
   wire 	vsyncon,vsyncoff,vreset,vblankon; //
   //assign 	vblankon = hreset & (vc == 479);    
   //assign 	vsyncon = hreset & (vc == 490);
   //assign 	vsyncoff = hreset & (vc == 492);
   assign 	vreset = hreset & (vc == 523);

   always @(posedge clock) begin
      vc <= Vcount_in;
      hc <= Hcount_in;
      hsync <= hsync_in;
      vsync <= vsync_in;
   //hc <= ec ? (hreset ? 0 : hc + 1) : hc;
   //hblank <= hreset ? 0 : hblankon ? 1 : hblank;
   //hsync <= hsyncon ? 0 : hsyncoff ? 1 : hsync; 
   
   //vc <= hreset ? (vreset ? 0 : vc + 1) : vc;
   //vblank <= vreset ? 0 : vblankon ? 1 : vblank;
   //vsync <= vsyncon ? 0 : vsyncoff ? 1 : vsync;
end

always @(posedge clock)begin
    if(reset)begin
        addra<={15{1'b0}};
        red<=4'b0000;
        green<=4'b0000;
        blue<=4'b0000;
        gray <= 8'b0000_0000;
        left <= 8'b0000_0000;
        right <= 8'b0000_0000;
        up <= 8'b0000_0000;
        down <= 8'b0000_0000;
        leftup  <= 8'b0000_0000;
        leftdown <= 8'b0000_0000;
        rightup <= 8'b0000_0000; 
        rightdown <= 8'b0000_0000;
        tred <= 8'b0000_0000;
        tblue<= 8'b0000_0000;
        tgreen<= 8'b0000_0000;
        red_o <= 8'b0000_0000;
        green_o <= 8'b0000_0000;
        blue_o <= 8'b0000_0000;
        r<={16{1'b0}};
        g<={16{1'b0}};
        b<={16{1'b0}};
        
    
    
    end else begin
        addra<=addra_nxt;
        red<=red_nxt;
        green<=green_nxt;
        blue<=blue_nxt;
        gray <= gray_nxt;
        left <= left_nxt;
        right <= right_nxt;
        up <= up_nxt;
        down <= down_nxt;
        leftup <= leftup_nxt;
        leftdown <= leftdown_nxt;
        rightup <= rightup_nxt; 
        rightdown <= rightdown_nxt;
        tred<=tred_nxt;
        tgreen<=tgreen_nxt;
        tblue<=tblue_nxt;
        red_o<=red_o_nxt;
        green_o<=green_o_nxt;
        blue_o<=blue_o_nxt;
        r<=r_nxt;
        g<=g_nxt;
        b<=b_nxt;
    end
end

//always @(posedge pixel_clk)
always @*
	begin		
            //if(blank == 0 && hc >= 0 && hc < 260 && vc >= 0 && vc < 215)
            if(Nblank == 1'b1)
            begin
            
//                tblue =  {out2[95], out2[94], out2[93], out2[92], out2[91], out2[90], out2[89], out2[88]};
//                tgreen = {out2[87], out2[86], out2[85], out2[84], out2[83], out2[82], out2[81], out2[80]};
//                tred = {out2[79], out2[78], out2[77], out2[76], out2[75], out2[74], out2[73], out2[72]};    
                /*gray =  {out2[95], out2[94], out2[93], out2[92], out2[91], out2[90], out2[89], out2[88]};
                
                left = {out2[87], out2[86], out2[85], out2[84], out2[83], out2[82], out2[81], out2[80]};
                right = {out2[79], out2[78], out2[77], out2[76], out2[75], out2[74], out2[73], out2[72]};                       
                up =  {out2[71], out2[70], out2[69], out2[68], out2[67], out2[66], out2[65], out2[64]};
                down = {out2[63], out2[62], out2[61], out2[60], out2[59], out2[58], out2[57], out2[56]};
                leftup = {out2[55], out2[54], out2[53], out2[52], out2[51], out2[50], out2[49], out2[48]};
                leftdown =  {out2[47], out2[46], out2[45], out2[44], out2[43], out2[42], out2[41], out2[40]};
                rightup = {out2[39], out2[38], out2[37], out2[36], out2[35], out2[34], out2[33], out2[32]};
                rightdown = {out2[31], out2[30], out2[29], out2[28], out2[27], out2[26], out2[25], out2[24]};*/
                
                /*
                gray = {(rgb_C[23:16] + rgb_C[15:8] + rgb_C[7:0])/8'h03};
                left = {(rgb_W[23:16] + rgb_W[15:8] + rgb_W[7:0])/8'h03};
                right = {(rgb_E[23:16] + rgb_E[15:8] + rgb_E[7:0])/8'h03};
                up = {(rgb_N[23:16] + rgb_N[15:8] + rgb_N[7:0])/8'h03};
                down = {(rgb_S[23:16] + rgb_S[15:8] + rgb_S[7:0])/8'h03};
                leftup = {(rgb_NW[23:16] + rgb_NW[15:8] + rgb_NW[7:0])/8'h03};
                leftdown = {(rgb_SW[23:16] + rgb_SW[15:8] + rgb_SW[7:0])/8'h03};
                rightup = {(rgb_NE[23:16] + rgb_NE[15:8] + rgb_NE[7:0])/8'h03};
                rightdown = {(rgb_SE[23:16] + rgb_SE[15:8] + rgb_SE[7:0])/8'h03};
                */
                
                
                
                /*case (pixel_position)
                    position_center: begin
                        tblue_nxt = rgb_in[23:16];
                        tgreen_nxt = rgb_in[15:8];
                        tred_nxt = rgb_in[7:0];
                        gray_nxt = {(rgb_in[23:16] + rgb_in[15:8] + rgb_in[7:0])/8'h03};
                    end
                    position_up: begin
                        up_nxt = {(rgb_in[23:16] + rgb_in[15:8] + rgb_in[7:0])/8'h03};
                    end
                    position_down: begin
                        down_nxt = {(rgb_in[23:16] + rgb_in[15:8] + rgb_in[7:0])/8'h03};
                    end
                    position_left: begin
                        left_nxt = {(rgb_in[23:16] + rgb_in[15:8] + rgb_in[7:0])/8'h03};
                    end
                    position_right: begin
                        right_nxt = {(rgb_in[23:16] + rgb_in[15:8] + rgb_in[7:0])/8'h03};
                    end
                    position_left_up: begin
                        leftup_nxt = {(rgb_in[23:16] + rgb_in[15:8] + rgb_in[7:0])/8'h03};
                    end
                    position_left_down: begin
                        leftdown_nxt = {(rgb_in[23:16] + rgb_in[15:8] + rgb_in[7:0])/8'h03};
                    end
                    position_right_up: begin
                        rightup_nxt = {(rgb_in[23:16] + rgb_in[15:8] + rgb_in[7:0])/8'h03};
                    end
                    position_right_down: begin
                        rightdown_nxt = {(rgb_in[23:16] + rgb_in[15:8] + rgb_in[7:0])/8'h03};
                    end
                    default: begin
                        gray_nxt = gray;
                        left_nxt = left;
                        right_nxt = right;
                        up_nxt = up;
                        down_nxt = down;
                        leftup_nxt = leftup;
                        leftdown_nxt = leftdown;
                        rightup_nxt = rightup; 
                        rightdown_nxt = rightdown;
                    end
                endcase*/
                
                tblue_nxt= rgb_in[23:16];
                tgreen_nxt = rgb_in[15:8];
                tred_nxt = rgb_in[7:0];
                 
                //tblue =  {out2[23], out2[22], out2[21], out2[20], out2[19], out2[18], out2[17], out2[16]};
                //tgreen = {out2[15], out2[14], out2[13], out2[12], out2[11], out2[10], out2[9], out2[8]};
                //tred = {out2[7], out2[6], out2[5], out2[4], out2[3], out2[2], out2[1], out2[0]};
                
                

//                 RGB image to gray scale image
              if(sel_module == 4'b0000)begin
  
                        red_o_nxt = ((tred >> 2) + (tred >> 5) + (tgreen >> 1) + (tgreen >> 4)+ (tblue >> 4) + (tblue >> 5))/16;
                        green_o_nxt = ((tred >> 2) + (tred >> 5) + (tgreen >> 1) + (tgreen >> 4)+ (tblue >> 4) + (tblue >> 5))/16;
                        blue_o_nxt = ((tred >> 2) + (tred >> 5) + (tgreen >> 1) + (tgreen >> 4)+ (tblue >> 4) + (tblue >> 5))/16;
                        
                        /*
                        red_o = red_o/16;
                        blue_o = blue_o/16;
                        green_o = green_o/16;
                        */
                        red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                        green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                        blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};                        
                    end
                
                    // Increase brightness
                 else if(sel_module == 4'b0001)begin
                
                        r_nxt = tred + val;
                        g_nxt = tgreen + val;
                        b_nxt = tblue + val;
                        
                        if(r > 255)begin
                            red_o_nxt = 255;
                        end else begin
                            red_o_nxt = r;
                        end
                        if(g > 255)begin
                            green_o_nxt = 255;
                        end else begin
                            green_o_nxt = g;
                        end
                        if(b > 255)begin
                            blue_o_nxt = 255;
                        end else begin
                            blue_o_nxt = b;
                        end
                        
                        red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                        green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                        blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                    end
                    
                    // Decrease brightness
                else if(sel_module == 4'b0010) begin
                        r_nxt = tred - val;
                        g_nxt = tgreen - val;
                        b_nxt = tblue - val;
                        if(r > 256)begin
                            red_o_nxt = 0;
                        end else begin
                            red_o_nxt = r << 4;
                        end
                        if(g > 256)begin
                            green_o_nxt = 0;
                        end else begin
                            green_o_nxt = g << 4;
                        end
                        if(b > 256)begin
                            blue_o_nxt = 0;
                        end else begin
                            blue_o_nxt = b << 4;
                        end
                        
                        red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                        green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                        blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                    end
                    
                    // colour inversion
                else if(sel_module == 4'b0011)begin
                  
                        red_o_nxt = (255 - tred)/16;
                        green_o_nxt = (255 - tgreen)/16;
                        blue_o_nxt = (255 - tblue)/16;
                        
                        red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                        green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                        blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                        end
                        
                        // red filter
                 else if(sel_module == 4'b0100)begin
                    
                        r_nxt = tred - val;
                        if(r > 256)begin
                            red_o_nxt = 0;
                        end else begin
                            red_o_nxt = r/16;
                        end
                        blue_o_nxt = tblue/16;
                        green_o_nxt = tgreen/16;
                        red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                        green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                        blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                    end
                    
                    //blue filter
               else if(sel_module == 4'b0101) begin
                        red_o_nxt = tred/16;
                        b_nxt = tblue - val;
                        if(b > 256)begin
                            blue_o_nxt = 0;
                        end else begin
                            blue_o_nxt = b/16;
                        end
                        green_o_nxt = tgreen/16;
                        red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                        green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                        blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                    end
                    
                    //green filter
                else if(sel_module == 4'b0110)begin
                   
                        red_o_nxt = tred/16;
                        blue_o_nxt = tblue/16;
                        g_nxt = tgreen - val;
                        if(g > 256)begin
                            green_o_nxt = 0;
                        end else begin
                            green_o_nxt = g/16;
                        end
                        red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                        green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                        blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                    end
                   
                    
                    //original image
                else if(sel_module == 4'b0111)begin
                        red_o_nxt = tred/16;
                        blue_o_nxt = tblue/16;
                        green_o_nxt = tgreen/16;
                        
                        /*red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                        green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                        blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};*/
                        red_nxt = rgb_in[7:0];
                        green_nxt = rgb_in[15:8];
                        blue_nxt = rgb_in[23:16];
                    end
                    
///////////////////////////////////////////convultions//////////////////////////////////////////////////////                    
                
                
                //   average blurring    
                else if(sel_module == 4'b1000)begin
                    
                       r_nxt = (gray + left + right + up +down +leftup +leftdown +rightup +rightdown)/9;
                    
                       
                       red_o_nxt = r/16;
                       blue_o_nxt = r/16;
                       green_o_nxt = r/16;

                       red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                       green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                       blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                   end
                   
                   //// sobel edge detection
                else if(sel_module == 4'b1001)begin
                  
                       r_nxt = ((rightup)- leftup + (2*right) - (2*left) + rightdown - leftdown);
                       g_nxt = ((rightup) + (2*up) + leftup - rightdown - (2*down) - leftdown);
                       
                       if(r > 1024 & g > 1024)begin
                           b_nxt = -(r + g)/2;
                       end else if(r > 1024 & g < 1024)begin
                           b_nxt = (-r  + g)/2;
                       end else if(r < 1024 & g < 1024)begin
                           b_nxt = (r + g)/2;
                       end else begin
                           b_nxt = (r - g)/2;
                       end
                       red_o_nxt = b/16;
                       blue_o_nxt = b/16;
                       green_o_nxt = b/16;
                          
                          red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                          green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                          blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                       
                end
                
                
                
                    ////  edge detection
                else if(sel_module == 4'b1010)begin
                            r_nxt = ((8*gray) - left - right - up - down - leftup - leftdown - rightup - rightdown);
                            if(r > 2048)begin
                               red_o_nxt = 0;
                               blue_o_nxt = 0;
                               green_o_nxt = 0;
                            end else if(r > 255) begin
                                  red_o_nxt = 255;
                                  blue_o_nxt = 255;
                                  green_o_nxt = 255;
                            end else begin
                               red_o_nxt = r;
                               blue_o_nxt = r;
                               green_o_nxt = r;
                            end
                            
                            red_o_nxt = red_o/16;
                           blue_o_nxt = blue_o/16;
                           green_o_nxt = green_o/16;
                           red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                           green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                           blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                         end
                         
                    /////  motion blurring xy     
               else if(sel_module == 4'b1011)begin
                        r_nxt = (gray + leftdown + rightup)/3;
                        
                        red_o_nxt = r/16;
                        blue_o_nxt = r/16;
                        green_o_nxt = r/16;
                       red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                       green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                       blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                     end            
                     
                    ////   emboss ///////
                 else if(sel_module == 4'b1100)begin            
                   r_nxt = (gray + left - right - up + down + (2*leftdown) -(2*rightup));
                       if(r > 1280)begin
                           red_o_nxt = 0;
                           blue_o_nxt = 0;
                           green_o_nxt = 0;
                       end else if(r > 255) begin
                           red_o_nxt = 255;
                           blue_o_nxt = 255;
                           green_o_nxt = 255;
                       end else begin
                           red_o_nxt = r;
                           blue_o_nxt = r;
                           green_o_nxt = r;
                       end
                       
                       red_o_nxt = red_o/16;
                      blue_o_nxt = blue_o/16;
                      green_o_nxt = green_o/16;
                      red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                      green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                      blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
               end
               
                   ///// sharpen /////////
               else if(sel_module == 4'b1101)begin          
                      r_nxt = ((5*gray) - left - right - up - down);
                          if(r > 1280)begin
                              red_o_nxt = 0;
                              blue_o_nxt = 0;
                              green_o_nxt = 0;
                          end else if(r > 255) begin
                              red_o_nxt = 256;
                              blue_o_nxt = 256;
                              green_o_nxt = 256;
                          end else begin
                              red_o_nxt = r;
                              blue_o_nxt = r;
                              green_o_nxt = r;
                          end
                          
                          
                          red_o_nxt = red_o/16;
                         blue_o_nxt  = blue_o/16;
                         green_o_nxt = green_o/16;
                         red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                         green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                         blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                  end
                  
                  ///////  motion blur x
                else if(sel_module == 4'b1110)begin
                       r_nxt = (up + leftup + rightup)/3;
                       
                       red_o_nxt = r/16;
                       blue_o_nxt = r/16;
                       green_o_nxt = r/16;
                 
                      red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                      green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                      blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                    end 
                    
                    
              else if(sel_module == 4'b1111)begin
                          r_nxt = (rightup  + (2*up) + leftup + (2*right) + (4*gray) + (2*left) + rightdown + (2*down) + (2*leftdown))/16;
                          
                          red_o_nxt = r/16;
                          blue_o_nxt = r/16;
                          green_o_nxt = r/16;
                       
                         red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                         green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                         blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                    end 
                        

                
                if(addra <18399)
                    addra_nxt = addra + 1;
                else
                    addra_nxt = 0;
            end
            
            else
            begin
            
                red_nxt = 0;
                green_nxt = 0;
                blue_nxt = 0;
                
            end
        end    
       
    endmodule

