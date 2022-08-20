
module i2c_sender(
	input wire clk,
	inout wire siod,
	output reg sioc,
	output reg taken,
	input wire send,
	input wire [7:0] id,
	input wire [7:0] reg_xhdl1,
	input wire [7:0] value
);


reg siod_xhdl0;
reg [7:0] divider;
reg [31:0] busy_sr, data_sr;

assign siod = siod_xhdl0;

initial 
begin
	divider<=8'b0000_0001;
	busy_sr<={32{1'b0}};
	data_sr<={32{1'b1}};
end

always @(busy_sr or data_sr[31])
begin
	if( (busy_sr[11:10] == 2'b10) | (busy_sr[20:19] == 2'b10) | (busy_sr[29:28] == 2'b10) )
	begin
		siod_xhdl0 <=1'bz;
	end
	else
	begin
		siod_xhdl0<=data_sr[31];
	end
end


always @(posedge clk) begin
	taken <=1'b0;
	if(busy_sr[31] == 1'b0) begin
		sioc<=1'b1;
		if(send == 1'b1)
		begin
			if(divider == 8'b0000_0000)
			begin
				data_sr<={3'b100,id,1'b0,reg_xhdl1,1'b0,value,1'b0,2'b01};
				busy_sr<={3'b111,9'b1_1111_1111,9'b1_1111_1111,9'b1_1111_1111,2'b11};
				taken<=1'b1;
			end
			else
			begin
				divider<=divider+1;
			end
		end	
	end
	else
	begin
		case({busy_sr[31:29],busy_sr[2:0]})
			{3'b111,3'b111}:
				begin
					case(divider[7:6])
						2'b00: sioc<=1'b1;
						2'b01: sioc<=1'b1;
						2'b10: sioc<=1'b1;
						default: sioc<=1'b1;
					endcase
				end
			{3'b111,3'b110}:
				begin
					case(divider[7:6])
						2'b00: sioc<=1'b1;
						2'b01: sioc<=1'b1;
						2'b10: sioc<=1'b1;
						default: sioc<=1'b1;
					endcase
				end
			{3'b111,3'b100}:
				begin
					case(divider[7:6])
						2'b00: sioc<=1'b0;
						2'b01: sioc<=1'b0;
						2'b10: sioc<=1'b0;
						default: sioc<=1'b0;
					endcase
				end
			{3'b110,3'b000}:
				begin
					case(divider[7:6])
						2'b00: sioc<=1'b0;
						2'b01: sioc<=1'b1;
						2'b10: sioc<=1'b1;
						default: sioc<=1'b1;
					endcase
				end
			{3'b100,3'b000}:
				begin
					case(divider[7:6])
						2'b00: sioc<=1'b1;
						2'b01: sioc<=1'b1;
						2'b10: sioc<=1'b1;
						default: sioc<=1'b1;
					endcase
				end
			{3'b000,3'b000}:
				begin
					case(divider[7:6])
						2'b00: sioc<=1'b1;
						2'b01: sioc<=1'b1;
						2'b10: sioc<=1'b1;
						default: sioc<=1'b1;
					endcase
				end
			default:
				begin
					case(divider[7:6])
						2'b00: sioc<=1'b0;
						2'b01: sioc<=1'b1;
						2'b10: sioc<=1'b1;
						default: sioc<=1'b0;
					endcase
				end
		endcase
		if(divider == 8'b1111_1111)
		begin
			busy_sr<={busy_sr[30:0],1'b0};
			data_sr<={data_sr[30:0],1'b1};
			divider<={8{1'b0}};
		end
		else
		begin
			divider<=divider+1;
		end
	end
end
endmodule