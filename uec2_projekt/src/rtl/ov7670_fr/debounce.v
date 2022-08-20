


module debounce(
	input wire clk,
	input wire i,
	output reg o
);
	reg [23:0] c,c_nxt;

	always @(posedge clk) begin
	    c <= c_nxt;
		if (i == 1'b1) begin
			if (c_nxt == 24'hFFFFFF) begin
                    o <= 1'b1;
                end
            else begin
                    o<= 1'b0;
                end
		end
		else begin
			 c <= {24{1'b0}};
			 o <= 1'b0;
			end
		end
	always @*
	begin
	   if (i == 1'b1) begin
            c_nxt = c + 1;
       end
       else begin
       c_nxt ={24{1'b0}};
       end                 
	end
endmodule