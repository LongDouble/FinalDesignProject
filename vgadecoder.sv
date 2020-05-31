//takes the input colors and regulates the output to hsync and vsync

module vgadecoder
(clk, reset_n, red, green, blue, h_sync, v_sync, Rout, Gout, Bout, outdisplay, hrow, vcolumn, clkvga);
	input logic clk;
	input logic [3:0] red;
	input logic [3:0] green;
	input logic [3:0] blue;
	input logic reset_n;
	output logic h_sync;
	output logic v_sync;
	output logic [3:0] Rout;
	output logic [3:0] Gout;
	output logic [3:0] Bout;
	output logic outdisplay;
	output logic [9:0] hrow;
	output logic [9:0] vcolumn;
	output logic clkvga;
	
	logic display;
	logic hdisplay;
	logic vdisplay;
	logic clk25MHz;
	logic [3:0] outputclk;
	

	clkdivider
	halfclk(
		.initialclk(clk),
		.reset(reset_n),
		.newclock(outputclk));
		
	assign clk25MHz = outputclk[1];
		
	synccount
	vgasync(
		.inputclk(clk25MHz),
		.reset_b(reset_n),
		.hsync(h_sync),
		.vsync(v_sync),
		.hrow(hrow),
		.vcolumn(vcolumn),
		.Hdisplay(hdisplay),
		.Vdisplay(vdisplay));
		
	assign display = hdisplay & vdisplay;
	
	multibitmux
	redmux(
		.color(red),
		.background(4'b0000),
		.pick(display),
		.colorout(Rout));
		
	multibitmux
	greenmux(
		.color(green),
		.background(4'b0000),
		.pick(display),
		.colorout(Gout));
	
	multibitmux
	bluemux(
		.color(blue),
		.background(4'b0000),
		.pick(display),
		.colorout(Bout));
	
	assign clkvga = clk25MHz;
	assign outdisplay = display;
	
endmodule