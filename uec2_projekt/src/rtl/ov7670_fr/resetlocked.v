//////////////////////////////////////////////////////////////////////////////////
// Company: Akademia Górniczo-Hutnicza w Krakowie
// Engineer: Maciej Warcholak
// Create Date: 15.09.2022 10:18:28
// Project Name: Ardudido
// Tool Versions: Vivado 2017.3
//////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module resetlocked (
  
    input wire pclk,
    input wire locked,
    output wire reset
    );
              
    reg [3:0] safestart;
    reg [3:0] safestart_nxt;

always @* begin

safestart_nxt =  {safestart[2:0], !locked};

   
end 
 
assign reset = safestart[3];
always @(posedge pclk or negedge locked) begin

if(!locked) begin
    
 safestart <=4'b1111;

    
end   

else begin
   safestart<= safestart_nxt;
end

end
   
endmodule
