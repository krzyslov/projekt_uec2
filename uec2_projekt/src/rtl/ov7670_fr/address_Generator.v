
// TEN MODUĹ? JEST ĹąLE NAPISANY: PRZEZ NIEGO JEST TEN FIOLETOWY PASEK PO BOKU MONITORA
// ZAPEWNE JEST TO JAKIEĹš PRZESUNIÄ?CIE ZWIÄ„ZANE Z NIEZASTOSOWANIEM TRYBU BEZPIECZNEGO
module Address_Generator (

   input wire CLK25, 
   input wire enable,
   input wire reset,
   //input wire rez_160x120, 
   //input wire rez_320x240, 
   input wire vsync, 
   output reg [18:0] address_C,
   output reg [18:0] address_N,
   output reg [18:0] address_NE,
   output reg [18:0] address_E,
   output reg [18:0] address_SE,
   output reg [18:0] address_S,
   output reg [18:0] address_SW,
   output reg [18:0] address_W,
   output reg [18:0] address_NW
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
		
		if (reset == 1'b1) begin
			val <={19{1'b0}};
			address_C <= {19{1'b0}};
			address_N <= {19{1'b0}};
			address_NE <= {19{1'b0}};
			address_E <= {19{1'b0}};
			address_SE <= {19{1'b0}};
			address_S <= {19{1'b0}};
			address_SW <= {19{1'b0}};
			address_W <= {19{1'b0}};
			address_NW <= {19{1'b0}};
		end else begin
		
			val <= val_nxt;
			address_C <= val_nxt;
			address_N <= val_nxt - 640;
			address_NE <=val_nxt - 640 + 1;
			address_E <= val_nxt + 1;
			address_SE <= val_nxt + 640 + 1;
			address_S <= val_nxt + 640;
			address_SW <= val_nxt + 640 - 1;
			address_W <= val_nxt - 1;
			address_NW <= val_nxt - 640 - 1;
		end
	end		
		
    
endmodule