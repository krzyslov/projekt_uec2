//////////////////////////////////////////////////////////////////////////////////
// Company: Akademia GÛrniczo-Hutnicza w Krakowie
// Engineer: Benedykt Bekasiak
// èrÛd≥o modu≥u: https://www.fpga4student.com/2018/08/basys-3-fpga-ov7670-camera.html
// T≥umaczone z jÍzyka vhdl i przerabiane do poprawnego dzia≥ania
// Create Date: 15.09.2022 10:18:28
// Project Name: Ardudido
// Tool Versions: Vivado 2017.3
//////////////////////////////////////////////////////////////////////////////////

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