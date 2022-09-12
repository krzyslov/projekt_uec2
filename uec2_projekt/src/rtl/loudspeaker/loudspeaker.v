module Loudspeaker(
    input wire clk,
    input wire [4:0] speaker_note,
    output reg audio
    );
    
	reg [17:0] count;
    reg [17:0] value;

	always @(posedge clk)
		if(count > 1)  begin 
		  count = count - 1; 
		end
		else begin count <= value; audio <= ~audio; end
        
    always @* begin
      case (speaker_note)
        5'b00000: value = 50000; 
        5'b00001: value = 53000;  
        5'b00010: value = 56000;   
        5'b00011: value = 60000;    
        5'b00100: value = 63000;    
        5'b00101: value = 67000;    
        5'b00110: value = 70000;    
        5'b00111: value = 75000;    
        5'b01000: value = 80000;   
        5'b01001: value = 85000;   
        5'b01010: value = 90000;   
        5'b01011: value = 95000;    
        5'b01100: value = 100000;   
        5'b01101: value = 107000;   
        5'b01110: value = 113000;  
        5'b01111: value = 120000;   
        5'b10000: value = 127000;   
        5'b10001: value = 135000;   
        5'b10010: value = 143000;  
        5'b10011: value = 150000;   
        5'b10100: value = 160000;   
        5'b10101: value = 170000;  
        5'b10110: value = 180000;   
        5'b10111: value = 192000;   
        5'b11000: value = 203000;  
        5'b11001: value = 215000;  
        5'b11010: value = 227000; 
        5'b11011: value = 240000;  
        5'b11100: value = 254000;   
        5'b11101: value = 286000;   
        5'b11110: value = 270000;    
        5'b11111: value = 290000;    
        default: value = 320000;   
      endcase
  end
endmodule