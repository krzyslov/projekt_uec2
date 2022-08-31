

module ov7670_capture(
	input wire pclk,
	//input wire rez_160x120,
	//input wire rez_320x240,
	input wire vsync,
	input wire href,
	input wire [7:0] d,
	output wire [18:0] addr,
	output wire [11:0] dout,
	output wire we
);


reg [15:0] d_latch;
reg [18:0] address;
reg [1:0] line, line_nxt;
reg [6:0] href_last;
reg we_reg,href_hold,latched_vsync,latched_href;
reg [7:0] latched_d;


initial begin //do wsadzenia w reset
	d_latch<= {16{1'b0}};
	address<={18{1'b0}};
	line<={2{1'b0}};
	href_last<={7{1'b0}};
	we_reg<=1'b0;
	href_hold<=1'b0;
	latched_vsync<=1'b0;
	latched_href<=1'b0;
	latched_d<={8{1'b0}};
end

assign addr = address;
assign we = we_reg;
assign dout = {d_latch[15:12],d_latch[10:7],d_latch[4:1]};

/*
-- This is a bit tricky href starts a pixel transfer that takes 3 cycles
         --        Input   | state after clock tick   
         --         href   | wr_hold    d_latch           dout                we address  address_next
         -- cycle -1  x    |    xx      xxxxxxxxxxxxxxxx  xxxxxxxxxxxx  x   xxxx     xxxx
         -- cycle 0   1    |    x1      xxxxxxxxRRRRRGGG  xxxxxxxxxxxx  x   xxxx     addr
         -- cycle 1   0    |    10      RRRRRGGGGGGBBBBB  xxxxxxxxxxxx  x   addr     addr
         -- cycle 2   x    |    0x      GGGBBBBBxxxxxxxx  RRRRGGGGBBBB  1   addr     addr+1

         -- detect the rising edge on href - the start of the scan line
*/
always @(negedge pclk) begin
	latched_d <= d;
	latched_href <= href;
	latched_vsync <= vsync;
end




always @(posedge pclk)begin
	address <= (we_reg == 1'b1) ? (addr + 1) : addr;
	
	line<=line_nxt;
	href_hold<= latched_href;
	
	if(latched_href == 1'b1)
		d_latch <={d_latch[7:0], latched_d};
	else
		d_latch <=d_latch;
	
	we_reg <=1'b0;
	
	
	if(latched_vsync == 1'b1) begin
		address <= {18{1'b0}};
		href_last<={7{1'b0}};
		line<= {2{1'b0}};
	end
	else begin
		//if (((rez_160x120 == 1'b1) && (href_last[6] == 1'b1)) ||((rez_320x240 == 1'b1) && (href_last[2] == 1'b1)) || ((rez_160x120 == 1'b0) && (rez_320x240 == 1'b0)&& (href_last[0] == 1'b1))) begin
		if (href_last[0] == 1'b1) begin
			/*if (rez_160x120 == 1'b1)
				we_reg<=(line==2'b10) ? 1'b1 : 1'b0;
			else if(rez_320x240 == 1'b1)
				we_reg<= (line[1] == 1'b1) ? 1'b1 : 1'b0;
			else*/
				
            we_reg <= 1'b1;
			href_last<={7{1'b0}};
		end
		else
			href_last<={href_last[5:0], latched_href};
	end
end


always @* begin

	if ((href_hold == 1'b0) &&(latched_href == 1'b1)) begin
		case(line)
			2'b00: line_nxt = 2'b01;
			2'b01: line_nxt = 2'b10;
			2'b10: line_nxt = 2'b11;
			default: line_nxt = 2'b00;
		endcase
	end
	else begin
		line_nxt = line;
	end	
end
endmodule

