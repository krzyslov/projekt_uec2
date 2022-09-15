//////////////////////////////////////////////////////////////////////////////////
// Company: Akademia GÛrniczo-Hutnicza w Krakowie
// Engineer: Maciej Warcholak, Benedykt Bekasiak
// èrÛd≥o modu≥u: https://github.com/Gowtham1729/Image-Processing
// Przerabiane do poprawnego dzia≥ania(filtrowanie obrazu z kamery zamiast obrazu ze schowka)
// Oraz dodatkowo usprawniane i modyfikowane
// Create Date: 15.09.2022 10:18:28
// Project Name: Ardudido
// Tool Versions: Vivado 2017.3
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module filtering(
input wire clock,
input wire reset,

input wire [3:0]sel_module,  
input wire [23:0] rgb_C,

input wire [7:0] gray_center,
input wire [7:0] gray_up, //rgb_N
input wire [7:0] gray_down,
input wire [7:0] gray_right,
input wire [7:0] gray_right_down,
input wire [7:0] gray_right_up,
input wire [7:0] gray_left,
input wire [7:0] gray_left_down,
input wire [7:0] gray_left_up,
input wire [10:0] Hcount_in,
input wire [10:0] Vcount_in,
output reg [3:0]red,
output reg[3:0] green,
output reg[3:0] blue, 
output reg[10:0] hc,
output reg[10:0] vc,
input wire Nblank
);
    
    // pixel position
    
    reg [7:0] gray_nxt, left_nxt, right_nxt, up_nxt, down_nxt, leftup_nxt, leftdown_nxt, rightup_nxt, rightdown_nxt;     //different values in matrix
    reg[7:0] red_o, blue_o, green_o,red_o_nxt,blue_o_nxt,green_o_nxt;            // variables used during calcultion
    reg [15:0] r, b, g;
    reg [15:0] r_nxt,g_nxt,b_nxt;                         // variables used during calcultion
    
 

    reg [7:0] val = 8'b00000110;            
  
   	reg [7:0] tred,tgreen,tblue,tred_nxt,tgreen_nxt,tblue_nxt;
   	reg [3:0] red_nxt,green_nxt,blue_nxt;
 
   always @(posedge clock) begin
      vc <= Vcount_in;
      hc <= Hcount_in;
end

always @(posedge clock)begin
    if(reset)begin
        red<=4'b0000;
        green<=4'b0000;
        blue<=4'b0000;
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
        //addra<=addra_nxt;
        red<=red_nxt;
        green<=green_nxt;
        blue<=blue_nxt;
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

always @*
	begin		
            
            if(Nblank == 1'b1)
            begin
                tblue_nxt= rgb_C[23:16];
                tgreen_nxt = rgb_C[15:8];
                tred_nxt = rgb_C[7:0];
                 
              

//                 RGB image to gray_center scale image
              if(sel_module == 4'b0000)begin
  
                        red_o_nxt = ((tred >> 2) + (tred >> 5) + (tgreen >> 1) + (tgreen >> 4)+ (tblue >> 4) + (tblue >> 5))/16;
                        green_o_nxt = ((tred >> 2) + (tred >> 5) + (tgreen >> 1) + (tgreen >> 4)+ (tblue >> 4) + (tblue >> 5))/16;
                        blue_o_nxt = ((tred >> 2) + (tred >> 5) + (tgreen >> 1) + (tgreen >> 4)+ (tblue >> 4) + (tblue >> 5))/16;
                        
                        red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                        green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                        blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]}; 
                        r_nxt= red_o ;
                        g_nxt= green_o;
                        b_nxt= blue_o;                       
                    end
                
                    // Increase brightness
                     else if(sel_module == 4'b0001)begin
                    
                            r_nxt = tred + val;
                            g_nxt = tgreen + val;
                            b_nxt = tblue + val;
                            
                            if(r > 255)begin
                                red_o_nxt = 255/16;
                            end else begin
                                red_o_nxt = r[7:0]/16;
                            end
                            if(g > 255)begin
                                green_o_nxt = 255/16;
                            end else begin
                                green_o_nxt = g[7:0]/16;
                            end
                            if(b > 255)begin
                                blue_o_nxt = 255/16;
                            end else begin
                                blue_o_nxt = b[7:0]/16;
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
                                red_o_nxt = r[7:0] / 16;
                            end
                            if(g > 256)begin
                                green_o_nxt = 0;
                            end else begin
                                green_o_nxt = g[7:0] / 16;
                            end
                            if(b > 256)begin
                                blue_o_nxt = 0;
                            end else begin
                                blue_o_nxt = b[7:0] / 16;
                            end
                            
                            red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                            green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                            blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                        end
                        
                        // colour inversion
                    else if(sel_module == 4'b0011)begin
                      
                            red_o_nxt = (8'd255 - tred)/8'd16;
                            green_o_nxt = (8'd255 - tgreen)/8'd16;
                            blue_o_nxt = (8'd255 - tblue)/8'd16;
                            
                            red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                            green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                            blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                            r_nxt = red_o ;
                            g_nxt = green_o;
                            b_nxt = blue_o;  
                            end
                                            
                        
                        // red filter
                 else if(sel_module == 4'b0100)begin         
                        blue_o_nxt = tblue/16;
                        green_o_nxt = tgreen/16;
                        red_o_nxt = 255;
                        
                        red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                        green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                        blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                        g_nxt= green_o;
                        b_nxt= blue_o;  
                        r_nxt = red_o;
                    end
                    
                    //blue filter
               else if(sel_module == 4'b0101) begin
                        red_o_nxt = tred/16;
                        green_o_nxt = tgreen/16;
                        blue_o_nxt = 255;
    
                        red_nxt = {red_o[3],red_o[2], red_o[1], red_o[0]};
                        green_nxt = {green_o[3],green_o[2], green_o[1], green_o[0]};
                        blue_nxt = {blue_o[3],blue_o[2], blue_o[1], blue_o[0]};
                        r_nxt= red_o ;
                        g_nxt= green_o;
                        b_nxt = blue_o;
                                            
                    end
                    
                    //green filter
                else if(sel_module == 4'b0110)begin
                   
                        red_o_nxt = tred/16;
                        blue_o_nxt = tblue/16;
                        green_o_nxt = 255;
                        red_nxt = red_o[3:0];
                        green_nxt = green_o[3:0];
                        blue_nxt = blue_o[3:0];
                        r_nxt= red_o ;
                        b_nxt= blue_o;  
                        g_nxt = green_o;
                    end
                   
                    
                    //original image
                else if(sel_module == 4'b0111)begin
                        red_o_nxt = tred/16;
                        blue_o_nxt = tblue/16;
                        green_o_nxt = tgreen/16;
                        red_nxt = rgb_C[3:0];
                        green_nxt = rgb_C[11:8];
                        blue_nxt = rgb_C[19:16];
                        r_nxt= red_o ;
                        g_nxt= green_o;
                        b_nxt= blue_o;
                    end
                    
///////////////////////////////////////////convultions//////////////////////////////////////////////////////                    
                
                
                //   average blurring    
                else if(sel_module == 4'b1000)begin
                    
                       r_nxt = (gray_center + gray_left + gray_right + gray_up +gray_down +gray_left_up +gray_left_down +gray_right_up +gray_right_down)/9;
                    
                       
                       red_o_nxt = r/16;
                       blue_o_nxt = r/16;
                       green_o_nxt = r/16;

                       red_nxt = red_o[3:0];
                       green_nxt = green_o[3:0];
                       blue_nxt = blue_o[3:0];                
                       g_nxt= green_o;
                       b_nxt= blue_o;
                   end
                   
                   //// sobel edge detection
                else if(sel_module == 4'b1001)begin
                  
                       r_nxt = ((gray_right_up)- gray_left_up + (2*gray_right) - (2*gray_left) + gray_right_down - gray_left_down);
                       g_nxt = ((gray_right_up) + (2*gray_up) + gray_left_up - gray_right_down - (2*gray_down) - gray_left_down);
                       
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
                      
                      red_nxt = red_o[3:0];
                      green_nxt = green_o[3:0];
                      blue_nxt = blue_o[3:0];
                       
                end
                
                
                
                    ////  edge detection
                else if(sel_module == 4'b1010)begin
                            r_nxt = ((8*gray_center) - gray_left - gray_right - gray_up - gray_down - gray_left_up - gray_left_down - gray_right_up - gray_right_down);
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
                           red_nxt = red_o>>4;
                           green_nxt = green_o>>4;
                           blue_nxt = blue_o>>4;
                          
                           g_nxt= green_o;
                           b_nxt= blue_o;
                         end
                         
                    /////  motion blurring xy     
               else if(sel_module == 4'b1011)begin
                        r_nxt = (gray_center + gray_left_down + gray_right_up)/3;
                        
                        red_o_nxt = r/16;
                        blue_o_nxt = r/16;
                        green_o_nxt = r/16;
                       red_nxt = red_o[3:0];
                       green_nxt = green_o[3:0];
                       blue_nxt = blue_o[3:0];
                       g_nxt= green_o;
                       b_nxt= blue_o;
                     end            
                     
                    ////   emboss ///////
                 else if(sel_module == 4'b1100)begin            
                   r_nxt = (gray_center + gray_left - gray_right - gray_up + gray_down + (2*gray_left_down) -(2*gray_right_up));
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
                       
                       g_nxt= green_o;
                       b_nxt= blue_o;
                      red_nxt = red_o>>4;
                      green_nxt = green_o>>4;
                      blue_nxt = blue_o>>4;
               end
               
                   ///// sharpen /////////
               else if(sel_module == 4'b1101)begin          
                      r_nxt = ((5*gray_center) - gray_left - gray_right - gray_up - gray_down);
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
                          
                          
                         red_nxt = red_o>>4;
                         green_nxt = green_o>>4;
                         blue_nxt = blue_o>>4;
                         g_nxt= green_o;
                         b_nxt= blue_o;
                  end
                  
                  ///////  motion blur x
                else if(sel_module == 4'b1110)begin
                       r_nxt = (gray_up + gray_left_up + gray_right_up)/3;
                       
                       red_o_nxt = r/16;
                       blue_o_nxt = r/16;
                       green_o_nxt = r/16;
                 
                      red_nxt = red_o[3:0];
                      green_nxt = green_o[3:0];
                      blue_nxt = blue_o[3:0];
                      
                      g_nxt= green_o;
                      b_nxt= blue_o;
                    end 
                    
                    
              else if(sel_module == 4'b1111)begin
                          r_nxt = (gray_right_up  + (2*gray_up) + gray_left_up + (2*gray_right) + (4*gray_center) + (2*gray_left) + gray_right_down + (2*gray_down) + (2*gray_left_down))/16;
                          
                          red_o_nxt = r/16;
                          blue_o_nxt = r/16;
                          green_o_nxt = r/16;
                       
                         red_nxt = red_o[3:0];
                         green_nxt = green_o[3:0];
                         blue_nxt = blue_o[3:0];
                        
                         g_nxt= green_o;
                         b_nxt= blue_o;
                  end 
                  
             else begin
                red_nxt = red;
               green_nxt = green;
               blue_nxt = blue;
               r_nxt= r ;
               g_nxt= g;
               b_nxt= b; 
               red_o_nxt = red_o;
               blue_o_nxt = blue_o;
               green_o_nxt = green_o;  
               tblue_nxt= rgb_C[23:16];
               tgreen_nxt = rgb_C[15:8];
               tred_nxt = rgb_C[7:0];
             end         
          
        end    
            else
                  begin
                  
                      red_nxt = 0;
                      green_nxt = 0;
                      blue_nxt = 0;
                      r_nxt= 0 ;
                      g_nxt= 0;
                      b_nxt= 0; 
                      red_o_nxt = 0;
                      blue_o_nxt = 0;
                      green_o_nxt = 0;  
                      tblue_nxt= rgb_C[23:16];
                      tgreen_nxt = rgb_C[15:8];
                      tred_nxt = rgb_C[7:0];                  
   
   end           
 end  
    endmodule

