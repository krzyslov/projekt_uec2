// zero - //code x30
module top_level(
    input wire [3:0]sw,
	input wire clk100,
	input wire btnc,
	//Ultrasound distance meter
	input wire EchoPin,
	output wire TrigPin,
	//Speaker
	output wire speaker_out,
	//VGA
	output wire vga_hsync,
	output wire vga_vsync,
	output wire [3:0]vga_r,
	output wire [3:0]vga_g,
	output wire [3:0]vga_b,
	//ov7670 camera pins
	input wire ov7670_pclk,
	output wire ov7670_xclk,
	input wire ov7670_vsync,
	input wire ov7670_href,
	input wire [7:0] ov7670_data,
	output wire ov7670_sioc,
	inout wire ov7670_siod,
	output wire ov7670_pwdn,
	output wire ov7670_reset,
	output wire config_finished
);

wire clk_camera, clk_vga,resend,nBlank,vSync,nSync,activeArea,rez_160x120,rez_320x240,locked,reset_locked;
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
//assign rez_160x120 = btnl;
//assign rez_320x240 = btnr;

wire clk_100MHz;

/*clock my_clock(
.CLK_100(clk_100MHz),
.CLK_50(clk_camera),
.CLK_25(clk_vga),
.reset(btnc),
.locked(locked),
.CLK_IN_100(clk100)
);*/

clocking my_clocking(
	.reset(btnc),
	.CLK_100(clk100),
	.CLK_50(clk_camera),
	.CLK_25(clk_vga),
	.locked(locked)
);

resetlocked my_resetlocked(
    .pclk(clk_vga),
	.reset(reset_locked),
	.locked(locked)

);

wire [4:0] speaker_note;

Loudspeaker my_Loudspeaker(
.clk(clk_camera),
.speaker_note(speaker_note),
.audio(speaker_out)
);

wire [8:0] distance_cm;     //[10:0]

Distance_meter my_Distance_meter(
.clk_100MHz(clk_camera),
.reset(reset_locked),
.distance_cm(distance_cm),
.speaker_note(speaker_note),
.Echo_in(EchoPin),
.Trig_out(TrigPin)
);

assign vga_vsync = vSync;

wire [10:0] hcount_f, vcount_f;
wire hblank_f,vblank_f,hsync_f,vsync_f;
wire [10:0] hcount_vga_filtering, vcount_vga_filtering;

VGA my_VGA(
	.CLK25(clk_vga),
	.reset(reset_locked),
	.Hsync(vga_hsync),
	.Vsync(vSync),
	.Nblank(nBlank),
	.Nsync(nSync),
	.activeArea(activeArea),
	.Hcnt_out(hcount_vga_filtering),
	.Vcnt_out(vcount_vga_filtering)
);

debounce my_debounce(
	.clk(clk_vga),
	.i(reset_locked),
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

//assign size_select = {btnl,btnr};
assign rd_addr =    (size_select == 2'b00) ? rdaddress[18:2] : rdaddress[16:0];
                    //(size_select == 2'b01) ? rdaddress[16:0] : 
                    //(size_select == 2'b10) ? rdaddress[16:0] : rdaddress[16:0];
                    //(size_select == 2'b11) ? rdaddress[16:0] : rd_addr;


assign wr_addr = wraddress[18:2];
//(size_select == 2'b01) ? wraddress[16:0] : 
//(size_select == 2'b10) ? wraddress[16:0] : 
//(size_select == 2'b11) ? wraddress : wr_addr;

wire [18:0] address_C, address_N, address_NE, address_E,address_SE,address_S, address_SW, address_W, address_NW;
wire [11:0] rddata_C, rddata_N, rddata_NE, rddata_E, rddata_SE, rddata_S, rddata_SW, rddata_W, rddata_NW;

frame_buffer my_frame_buffer(
	.addrb(address_center[18:2]),
	.clkb(clk_vga),
	.doutb(rddata_C),
	.clka(ov7670_pclk),
	.addra(wr_addr),
	.dina(wrdata),
	.wea(wren)
);



ov7670_capture my_ov7670_capture(
	.pclk(ov7670_pclk),
	.vsync(ov7670_vsync),
	.href(ov7670_href),
	.d(ov7670_data),
	.addr(wraddress),
	.dout(wrdata),
	.we(wren[0])
);
wire [7:0] R,G,B;

wire [23:0] RGB_C, RGB_N, RGB_NE, RGB_E, RGB_SE, RGB_S, RGB_SW, RGB_W, RGB_NW;
wire [7:0] gray_wire;

RGB my_RGB(
	.Din(rddata_C),
	.reset(reset_locked),
	.Nblank(activeArea),
	.R(RGB_C[7:0]),
	.G(RGB_C[15:8]),
	.B(RGB_C[23:16]),
	.Grayscale(gray_wire)
	
);

wire [7:0] gray_center, gray_right_up, gray_right, gray_right_down, gray_down, gray_left_down, gray_left, gray_left_up, gray_up;
wire [18:0] address_center, address_left_up, address_left, address_left_down, address_up, address_right_up, address_right, address_right_down, address_down;


ram_buffer my_ram_buffer(
.clk(clk_vga),
.we(1'b1),
.gray_input(gray_wire),
.input_rgb_address(address_center),
.address_center(address_center),
.address_left_up(address_left_up), 
.address_left(address_left),
.address_left_down(address_left_down),
.address_up(address_up),
.address_down(address_down),
.address_right_up(address_right_up),
.address_right(address_right),
.address_righ_down(address_right_down),
.gray_center(gray_center), 
.gray_left_up(gray_left_up), 
.gray_left(gray_left),
.gray_left_down(gray_left_down),
.gray_up(gray_up),
.gray_down(gray_down),
.gray_right_up(gray_right_up),
.gray_right(gray_right),
.gray_right_down(gray_right_down)
);

Address_Generator my_Address_Generator(
	.CLK25(clk_vga),
	.reset(reset_locked),
//	.rez_160x120(rez_160x120),
//	.rez_320x240(rez_320x240),
	.enable(activeArea),
	.vsync(vSync),
	.address_C(address_center),
	.address_N(address_up),
	.address_NE(address_right_up),
	.address_E(address_right),
	.address_SE(address_right_down),
	.address_S(address_down),
	.address_SW(address_left_down),
	.address_W(address_left),
	.address_NW(address_left_up)
	//.address(rdaddress)
);

wire [3:0] red_char, green_char,blue_char;





filtering my_filtering(
    .vsync_in(vSync),
    .hsync_in(vga_hsync),
    .clock(clk_vga),
    .reset(reset_locked),
    .sel_module(sw),
    .rgb_C(RGB_C),
    .gray_center(gray_center), 
    .gray_left_up(gray_left_up), 
    .gray_left(gray_left),
    .gray_left_down(gray_left_down),
    .gray_up(gray_up),
    .gray_down(gray_down),
    .gray_right_up(gray_right_up),
    .gray_right(gray_right),
    .gray_right_down(gray_right_down),
    //.red_in(R),
    //.green_in(G),
    //.blue_in(B),
    .red(red_char),
    .green(green_char),
    .blue(blue_char),   
    .Nblank(activeArea),
    .hc(hcount_f),
    .vc(vcount_f),
    .hblank(hblank_f),
    .vblank(vblank_f),
    .hsync(hsync_f),
    .vsync(vsync_f),
    .Hcount_in(hcount_vga_filtering),
    .Vcount_in(vcount_vga_filtering)
    
);

wire [6:0] char_code, char_code_distance, char_distance_xy;
wire [3:0] char_line, char_line_distance;
wire [7:0] char_pixel, char_xy,  char_pixel_distance;

wire [11:0] rgb_rect2distance;
wire [10:0] vcount_rect2distance, hcount_rect2distance;

wire vsync_rect2distance, hsync_rect2distance, hblnk_rect2distance, vblnk_rect2distance;

draw_rect_char my_draw_rect_char(
      .vcount_in(vcount_f),
      //.vsync_in(vsync_f),
      //.vblnk_in(vblank_f),
      .hcount_in(hcount_f),
     // .hsync_in(hsync_f),
     // .hblnk_in(hblank_f),
      .char_pixels(char_pixel),
      .rgb_in({red_char,green_char,blue_char}),
      .vcount_out(vcount_rect2distance),
     // .vsync_out(vsync_rect2distance),
      //.vblnk_out(vblnk_rect2distance),
      .hcount_out(hcount_rect2distance),
      //.hsync_out(hsync_rect2distance),
      //.hblnk_out(hblnk_rect2distance),
      .rgb_out(rgb_rect2distance),
      .char_xy(char_xy),
      .char_line(char_line), //{r,g,b}
      .pclk(clk_vga),
      .rst(reset_locked)

);

draw_distance_char my_draw_distance_char(
      .vcount_in(vcount_rect2distance),
      //.vsync_in(vsync_rect2distance),
      //.vblnk_in(vblnk_rect2distance),
      .hcount_in(hcount_rect2distance),
     // .hsync_in(hsync_rect2distance),
     // .hblnk_in(hblnk_rect2distance),
      .char_pixels(char_pixel_distance),
      .rgb_in(rgb_rect2distance),
    
      .rgb_out({red[7:4],green[7:4],blue[7:4]}),
      .char_xy(char_distance_xy),
      .char_line(char_line_distance), //{r,g,b}
      .pclk(clk_vga),
      .rst(reset_locked)

);


font_rom my_font_rom(        
      .char_line_pixels(char_pixel),  
      .addr({char_code[6:0],char_line[3:0]}),
      .clk(clk_vga)

);

font_rom my_font_rom2(
    .char_line_pixels(char_pixel_distance),  
    .addr({char_code_distance[6:0],char_line_distance[3:0]}),
    .clk(clk_vga)
);

char_rom my_char_rom(
   
    .char_code(char_code),
    .char_xy(char_xy),
    .sw(sw)

);

char_rom_dist_meter my_char_rom_dist_meter(
   
    .char_code(char_code_distance),
    .char_xy(char_distance_xy),
    .distance(distance_cm)
);

endmodule