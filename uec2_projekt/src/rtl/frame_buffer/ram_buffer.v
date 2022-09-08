//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   template_ram
 Author:        Robert Szczygiel
 Version:       1.0
 Last modified: 2017-04-03
 Coding style: Xilinx recommended + ANSI ports
 Description:  Template for RAM module as recommended by Xilinx. The module
 				has second output port 'dpo', which can be removed when not needed
 				(together with 'dpra' and 'read_dpra');

 ** This example shows the use of the Vivado rom_style attribute
 **
 ** Acceptable values are:
 ** block : Instructs the tool to infer RAMB type components.
 ** distributed : Instructs the tool to infer LUT ROMs.
 **
 */
//////////////////////////////////////////////////////////////////////////////
module ram_buffer
	#(parameter
		ADDRESSWIDTH = 19,
		BITWIDTH = 8,
		DEPTH = 1920
	)
	(
		input wire clk, // posedge active clock
		input wire we,  // write enable
		input wire [ADDRESSWIDTH-1:0] input_rgb_address,
		input wire [ADDRESSWIDTH-1:0] address_center,     // read/write address
		input wire [ADDRESSWIDTH-1:0] address_left_up,  // read address for second port
		input wire [ADDRESSWIDTH-1:0] address_left,
		input wire [ADDRESSWIDTH-1:0] address_left_down,
		input wire [ADDRESSWIDTH-1:0] address_up,
		input wire [ADDRESSWIDTH-1:0] address_down,
		input wire [ADDRESSWIDTH-1:0] address_right_up,
		input wire [ADDRESSWIDTH-1:0] address_right,
		input wire [ADDRESSWIDTH-1:0] address_righ_down,
		input wire [BITWIDTH-1:0] gray_input, // data input
		output reg [BITWIDTH-1:0] gray_center, // first output data
		output reg [BITWIDTH-1:0] gray_left_up, // first output data
		output reg [BITWIDTH-1:0] gray_left, // first output data
		output reg [BITWIDTH-1:0] gray_left_down, // first output data
		output reg [BITWIDTH-1:0] gray_up, // first output data
		output reg [BITWIDTH-1:0] gray_down, // first output data
		output reg [BITWIDTH-1:0] gray_right_up, // first output data
		output reg [BITWIDTH-1:0] gray_right, // first output data
		output reg [BITWIDTH-1:0] gray_right_down // first output data
	);

	(* ram_style = "block" *)
	//640*480
	reg [BITWIDTH-1:0] ram [DEPTH-1:0];

	reg [ADDRESSWIDTH-1:0] read_address_center;
	reg [ADDRESSWIDTH-1:0] read_address_left_up;
	reg [ADDRESSWIDTH-1:0] read_address_left;
	reg [ADDRESSWIDTH-1:0] read_address_left_down;
	reg [ADDRESSWIDTH-1:0] read_address_up;
	reg [ADDRESSWIDTH-1:0] read_address_down;
	reg [ADDRESSWIDTH-1:0] read_address_right_up;
	reg [ADDRESSWIDTH-1:0] read_address_right;
	reg [ADDRESSWIDTH-1:0] read_address_righ_down;
    
    // 0-480
    reg [8:0] line_number;
    // chyba ¿e on liczy³by liniê z adresu przychodz¹cego
    
	always @(posedge clk) begin
	
	    gray_center          <= ram [read_address_center];
        gray_left_up         <= ram[read_address_left_up];
        gray_left            <= ram [read_address_left];
        gray_left_down       <= ram [read_address_left_down];
        gray_up              <= ram [read_address_up];
        gray_down            <= ram [read_address_down];
        gray_right_up        <= ram [read_address_right_up];
        gray_right           <= ram [read_address_right];
        gray_right_down      <= ram [read_address_righ_down];
	   
	   // 3*640 = 1920
		if (we) begin
			ram [input_rgb_address % 1920] <= gray_input;
		end
            // latch read address on posedge clk
           read_address_center <= address_center % 1920;
           read_address_left_up <= address_left_up % 1920;
           read_address_left <= address_left % 1920;
           read_address_left_down <= address_left_down % 1920; 
           read_address_up <= address_up % 1920;
           read_address_down <= address_down % 1920;
           read_address_right_up <= address_right_up % 1920;
           read_address_right <= address_right % 1920;
           read_address_righ_down <= address_righ_down % 1920;
	end

/*
	assign rgb_center = ram [read_address_center];
	assign rgb_left_up = ram[read_address_left_up];
	assign rgb_left = ram [read_address_left];
	assign rgb_left_down = ram [read_address_left_down];
	assign rgb_up = ram [read_address_up];
	assign rgb_down = ram [read_address_down];
	assign rgb_right_up = ram [read_address_right_up];
	assign rgb_right = ram [read_address_right];
	assign rgb_right_down = ram[read_address_righ_down];
*/

endmodule


