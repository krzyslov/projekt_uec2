
// TEN MODUÅ? JEST Å¹LE NAPISANY: PRZEZ NIEGO JEST TEN FIOLETOWY PASEK PO BOKU MONITORA
// ZAPEWNE JEST TO JAKIEÅš PRZESUNIÄ?CIE ZWIÄ„ZANE Z NIEZASTOSOWANIEM TRYBU BEZPIECZNEGO
module Address_Generator (

   input wire CLK25, 
   input wire enable, 
   //input wire rez_160x120, 
   //input wire rez_320x240, 
   input wire vsync, 
   output reg [18:0] address
);   

	reg [18:0] val;
	reg [18:0] val_nxt;

	always @ * begin
        
            
            if(vsync == 1'b0)begin
                val_nxt = 19'd0;
            end else begin
                if((val < 640*480) && (enable == 1'b1) ) begin // 640*480
                    val_nxt = val +1;
                end else begin
                    val_nxt = val;
                end
            end
            
            
        end

	
	always @(posedge CLK25) begin
		val <= val_nxt;
		address <= val_nxt;
	end		
		
    
endmodule