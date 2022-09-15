//////////////////////////////////////////////////////////////////////////////////
// Company: Akademia GÛrniczo-Hutnicza w Krakowie
// Engineer: Benedykt Bekasiak
// èrÛd≥o modu≥u: https://www.fpga4student.com/2018/08/basys-3-fpga-ov7670-camera.html
// T≥umaczone z jÍzyka vhdl i przerabiane do poprawnego dzia≥ania
// Create Date: 15.09.2022 10:18:28
// Project Name: Ardudido
// Tool Versions: Vivado 2017.3
//////////////////////////////////////////////////////////////////////////////////


module ov7670_controller (clk, resend, config_finished, sioc, siod, reset, pwdn, xclk);

	input clk;
	input resend;
	output config_finished;
	wire config_finished;
	output sioc;
	wire sioc;
	inout siod;
	wire siod;
	wire siod_xhdl0;
	output reset;
	wire reset;
	output pwdn;
	wire pwdn;
	output xclk;
	wire xclk;
	
	reg sys_clk;
	wire [15:0] command;
	wire finished;
	wire taken;
	wire send;
	parameter[7:0] camera_address = 8'h42;
	
	assign siod = siod_xhdl0;
	
	initial
	begin
		sys_clk <= 1'b0;
	end
	
	assign config_finished = finished;
	assign send = ~finished;
	
	i2c_sender Inst_i2c_sender(
		.clk(clk),
		.taken(taken),
		.siod(siod),
		.sioc(sioc),
		.send(send),
		.id(camera_address),
		.reg_xhdl1(command[15:8]),
		.value(command[7:0])
	);
	
	assign reset = 1'b1;
	assign pwdn = 1'b0;
	assign xclk = sys_clk;
	
	ov7670_registers Inst_ov7670_registers(
		.clk(clk),
		.advance(taken),
		.command(command),
		.finished(finished),
		.resend(resend)
		);
		
	always @(posedge clk)
	begin
		sys_clk <= ~sys_clk;
	end
	
endmodule