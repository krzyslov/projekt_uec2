//////////////////////////////////////////////////////////////////////////////////
// Company: Akademia GÛrniczo-Hutnicza w Krakowie
// Engineer: Benedykt Bekasiak
// èrÛd≥o modu≥u: https://www.fpga4student.com/2018/08/basys-3-fpga-ov7670-camera.html
// T≥umaczone z jÍzyka vhdl i przerabiane do poprawnego dzia≥ania
// Create Date: 15.09.2022 10:18:28
// Project Name: Ardudido
// Tool Versions: Vivado 2017.3
//////////////////////////////////////////////////////////////////////////////////

module ov7670_registers(clk, resend, advance, command, finished);

	input clk;
	input resend;
	input advance;
	output [15:0] command;
	output finished;
	wire finished;
	
	reg [15:0] sreg;
	reg [7:0] address;

	initial
	begin
		address <= {8{1'b0}};
	end

	assign command = sreg;
	assign finished = (sreg == 16'hFFFF) ? 1'b1 : 1'b0;

	always @(posedge clk)
	begin
		if(resend == 1'b1)
		begin
			address <= {8{1'b0}};
		end
	else if (advance == 1'b1)
	begin
		address <= address+1;
	end
	case(address)
	8'h00:
		begin
			sreg <= 16'h1280;
		end
	8'h01:
		begin
			sreg <= 16'h1280;
		end
	8'h02:
		begin
			sreg <= 16'h1204;
		end
	8'h03:
		begin
			sreg <= 16'h1100;
		end
	8'h04:
		begin
			sreg <= 16'h0C00;
		end
	8'h05:
		begin
			sreg <= 16'h3E00;
		end
	8'h06:
		begin
			sreg <= 16'h8C00;
		end
	8'h07:
		begin
			sreg <= 16'h0400;
		end
	8'h08:
		begin
			sreg <= 16'h4010;
		end
	8'h09:
		begin
			sreg <= 16'h3A04;
		end
	8'h0A:
		begin
			sreg <= 16'h1438;
		end
	8'h0B:
		begin
			sreg <= 16'h4fb3;
		end
	8'h0C:
		begin
			sreg <= 16'h50b3;
		end
	8'h0D:
		begin
			sreg <= 16'h5100;
		end
	8'h0E:
		begin
			sreg <= 16'h523d;
		end
	8'h0F:
		begin
			sreg <= 16'h53A7;
		end
	8'h10:
		begin
			sreg <= 16'h54e4;
		end
	8'h11:
		begin
			sreg <= 16'h589e;
		end
	8'h12:
		begin
			sreg <= 16'h3dc0;
		end
	8'h13:
		begin
			sreg <= 16'h1100;
		end
	8'h14:
		begin
			sreg <= 16'h1711;
		end
	8'h15:
		begin
			sreg <= 16'h1861;
		end
	8'h16:
		begin
			sreg <= 16'h32a4;
		end
	8'h17:
		begin
			sreg <= 16'h1903;
		end
	8'h18:
		begin
			sreg <= 16'h1a7b;
		end
	8'h19:
		begin
			sreg <= 16'h030a;
		end
	8'h1A:
		begin
			sreg <= 16'h0e61;
		end
	8'h1B:
		begin
			sreg <= 16'h0f4b;
		end
	8'h1C:
		begin
			sreg <= 16'h1602;
		end
	8'h1D:
		begin
			sreg <= 16'h1e37;
		end
	8'h1E:
		begin
			sreg <= 16'h2102;
		end
	8'h1F:
		begin
			sreg <= 16'h2291;
		end
	8'h20:
		begin
			sreg <= 16'h2907;
		end
	8'h21:
		begin
			sreg <= 16'h330b;
		end
	8'h22:
		begin
			sreg <= 16'h350b;
		end
	8'h23:
		begin
			sreg <= 16'h371d;
		end
	8'h24:
		begin
			sreg <= 16'h3871;
		end
	8'h25:
		begin
			sreg <= 16'h392a;
		end
	8'h26:
		begin
			sreg <= 16'h3c78;
		end
	8'h27:
		begin
			sreg <= 16'h4d40;
		end
	8'h28:
		begin
			sreg <= 16'h4e20;
		end
	8'h29:
		begin
			sreg <= 16'h6900;
		end
	8'h2A:
		begin
			sreg <= 16'h6b4a;
		end
	8'h2B:
		begin
			sreg <= 16'h7410;
		end
	8'h2C:
		begin
			sreg <= 16'h8d4f;
		end
	8'h2D:
		begin
			sreg <= 16'h8e00;
		end
	8'h2E:
		begin
			sreg <= 16'h8f00;
		end
	8'h2F:
		begin
			sreg <= 16'h9000;
		end
	8'h30:
		begin
			sreg <= 16'h9100;
		end
	8'h31:
		begin
			sreg <= 16'h9600;
		end
	8'h32:
		begin
			sreg <= 16'h9a00;
		end
	8'h33:
		begin
			sreg <= 16'hb084;
		end
	8'h34:
		begin
			sreg <= 16'hb10c;
		end
	8'h35:
		begin
			sreg <= 16'hb20e;
		end
	8'h36:
		begin
			sreg <= 16'hb382;
		end
	8'h37:
		begin
			sreg <= 16'hb80a;
		end
	default:
		begin
			sreg <= 16'hFFFF;
		end
	endcase
	end
endmodule
	