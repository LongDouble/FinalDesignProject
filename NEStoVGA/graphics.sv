//	Handles driving the VGA monitor by keeping track of the sync
//	Uses counters and ROM to display a sprite and allow it to move around the screen via user inputs
//
//
//	Author: Ryan Dillard
//	Date: 6/3/2020
//

module sprite(inputclk, reset_b, background, up, down, left, right, outred, outgreen, outblue, hsync, vsync);

	input logic inputclk;
	input logic reset_b;
	input logic [11:0] background;
    input logic up;
    input logic down;
    input logic left;
    input logic right;
	output logic [3:0] outred;
	output logic [3:0] outgreen;
	output logic [3:0] outblue;
	output logic hsync;
	output logic vsync;
	
	logic [9:0] hrow;
	logic [9:0] vcolumn;
	logic clkvga;
	logic [11:0] colorin;
	logic [11:0] sprite;
	logic select;
	logic [7:0] address;
	logic display;
	logic validh;
	logic validv;
    logic [9:0] hshift;
    logic [9:0] vshift;
	
//Handles converting data for display on vga screen
//file: vgadecoder.sv
	vgadecoder 
		vga(
			.clk(inputclk),
			.red(colorin[3:0]),
			.green(colorin[7:4]),
			.blue(colorin[11:8]),
			.reset_n(reset_b),
			.h_sync(hsync),
			.v_sync(vsync),
			.Rout(outred),
			.Gout(outgreen),
			.Bout(outblue),
			.hrow(hrow),
			.vcolumn(vcolumn),
			.outdisplay(display),
			.clkvga(clkvga));
			
	//Changes color going to the vga driver between memory and background color		
	//file: multibitmux.sv
	multibitmux #(.N(12)) 
		spriteselect(
			.color(sprite),
			.pick(select),
			.background(background),
			.colorout(colorin));
			
	//ROM verilog, make with quartus also requires the link_ROM.hex in same file
	//file: link.v
	link 
	spritememory(
		.address(address),
		.clock(inputclk),
		.q(sprite));
		
	//takes the displayed rows and columns and converts then to the address in memory
	//file: addressconverter.sv
	addressconverter 
	converter(
		.row(hrow),
		.column(vcolumn),
        .rowshift(hshift),
        .columnshift(vshift),
		.address(address));

	//Counter that will increment or decrement based on the users inputs. Updates with every screen refresh
	//file: shiftcounter.sv	
	shiftcounter #(.N(10))
    horizontalshift(
        .increase(right),
        .decrease(left),
        .register(~vsync),
        .reset(reset_b),
        .shift(hshift));

	//Counter that will increment or decrement based on the users inputs. Updates with every screen refresh
	//file: shiftcounter.sv	
    shiftcounter #(.N(10))
    verticalshift(
        .increase(down),
        .decrease(up),
        .register(~vsync),
        .reset(reset_b),
        .shift(vshift));

	//compares check and shift. If check minus shift is less than m inrange will be logic high.
	//file twoincomparator.sv
	twoincomparator #(.N(10), .M(16))
		hcompare(
			.check(hrow),
            .shift(hshift),
			.inrange(validh));
	
	//compares check and shift. If check minus shift is less than m inrange will be logic high.
	//file twoincomparator.sv
	twoincomparator #(.N(10), .M(16))
		vcompare(
			.check(vcolumn),
            .shift(vshift),
			.inrange(validv));
			
			assign select = validh & validv;
endmodule

