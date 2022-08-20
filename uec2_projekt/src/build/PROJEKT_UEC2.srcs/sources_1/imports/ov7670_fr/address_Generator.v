
// TEN MODUŁ JEST ŹLE NAPISANY: PRZEZ NIEGO JEST TEN FIOLETOWY PASEK PO BOKU MONITORA
// ZAPEWNE JEST TO JAKIEŚ PRZESUNIĘCIE ZWIĄZANE Z NIEZASTOSOWANIEM TRYBU BEZPIECZNEGO
module Address_Generator (

   input wire CLK25, 
   input wire enable, 
   input wire rez_160x120, 
   input wire rez_320x240, 
   input wire vsync, 
   output reg [18:0] address
);   

	reg [18:0] val;
	
	//always @* begin
	//	address <= val;
	//end
	
	always @(posedge CLK25) begin
		address <=val;
		//val <= val;
		
		if(enable == 1'b1) begin
			if (rez_160x120 == 1'b1) begin
				if (val < 19'd19200 ) begin // 160*120
					val <= val +1;
				end
			end
			else if (rez_320x240 == 1'b1) begin
				if (val < 19'd76800) begin // 320*240
					val <= val +1;
				end
			end
			else begin
				if(val < 19'd307200) begin // 640*480
					val <= val +1;
				end
			end
		end
		
		if(vsync == 1'b0)begin
			val <= 19'd0;
		end
		
		
	end


endmodule