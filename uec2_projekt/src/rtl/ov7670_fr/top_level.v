
module top_level(
	input wire clk100,
	input wire btnl,
	input wire btnr,
	input wire btnc,
	output wire config_finished,
	output wire vga_hsync,
	output wire vga_vsync,
	output wire [3:0]vga_r,
	output wire [3:0]vga_g,
	output wire [3:0]vga_b,
	input wire ov7670_pclk,
	output wire ov7670_xclk,
	input wire ov7670_vsync,
	input wire ov7670_href,
	input wire [7:0] ov7670_data,
	output wire ov7670_sioc,
	inout wire ov7670_siod,
	output wire ov7670_pwdn,
	output wire ov7670_reset
);

wire clk_camera, clk_vga,resend,nBlank,vSync,nSync,activeArea,rez_160x120,rez_320x240;
wire [16:0] rd_addr,wr_addr;
wire [18:0] wraddress,rdaddress;
wire [11:0] wrdata,rddata;
wire [7:0] red,blue,green;
wire [0:0] wren;
wire [1:0] size_select;
wire ov7670_siod_xhdl0;

assign ov7670_siod = ov7670_siod_xhdl0;
assign vga_r = red[7:4];
assign vga_g = green[7:4];
assign vga_b = blue[7:4];
assign rez_160x120 = btnl;
assign rez_320x240 = btnr;

clocking my_clocking(
	.CLK_100(clk100),
	.CLK_50(clk_camera),
	.CLK_25(clk_vga)
); 

assign vga_vsync = vSync;


VGA my_VGA(
	.CLK25(clk_vga),
	.rez_160x120(rez_160x120),
	.rez_320x240(rez_320x240),
	.clkout(),
	.Hsync(vga_hsync),
	.Vsync(vSync),
	.Nblank(nBlank),
	.Nsync(nSync),
	.activeArea(activeArea)
);

debounce my_debounce(
	.clk(clk_vga),
	.i(btnc),
	.o(resend)
);

ov7670_controller my_ov7670_controller(
	.clk(clk_camera),
	.resend(resend),
	.config_finished(config_finished),
	.sioc(ov7670_sioc),
	.siod(ov7670_siod),
	.reset(ov7670_reset),
	.pwdn(ov7670_pwdn),
	.xclk(ov7670_xclk)
);

assign size_select = {btnl,btnr};
assign rd_addr =    (size_select == 2'b00) ? rdaddress[18:2] : rdaddress[16:0];
                    //(size_select == 2'b01) ? rdaddress[16:0] : 
                    //(size_select == 2'b10) ? rdaddress[16:0] : rdaddress[16:0];
                    //(size_select == 2'b11) ? rdaddress[16:0] : rd_addr;


assign wr_addr = (size_select == 2'b00) ? wraddress[18:2] : wraddress[16:0];
//(size_select == 2'b01) ? wraddress[16:0] : 
//(size_select == 2'b10) ? wraddress[16:0] : 
//(size_select == 2'b11) ? wraddress : wr_addr;


frame_buffer my_frame_buffer(
	.addrb(rd_addr),
	.clkb(clk_vga),
	.doutb(rddata),
	.clka(ov7670_pclk),
	.addra(wr_addr),
	.dina(wrdata),
	.wea(wren)
);

ov7670_capture my_ov7670_capture(
	.pclk(ov7670_pclk),
	.rez_160x120(rez_160x120),
	.rez_320x240(rez_320x240),
	.vsync(ov7670_vsync),
	.href(ov7670_href),
	.d(ov7670_data),
	.addr(wraddress),
	.dout(wrdata),
	.we(wren[0])
);

RGB my_RGB(
	.Din(rddata),
	.Nblank(activeArea),
	.R(red),
	.G(green),
	.B(blue)
	
);

Address_Generator my_Address_Generator(
	.CLK25(clk_vga),
	.rez_160x120(rez_160x120),
	.rez_320x240(rez_320x240),
	.enable(activeArea),
	.vsync(vSync),
	.address(rdaddress)
);
endmodule