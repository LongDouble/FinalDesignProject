module nestovga(inputclk, data, reset, background, outred, outgreen, outblue, hsync, vsync, clklatch, clkout)
	
	input logic inputclk;
	input logic data;
	input logic reset;
	input logic [11:0] background;
	output logic [3:0] outred;
	output logic [3:0] outgreen;
	output logic [3:0] outblue;
	output logic hsync;
	output logic vsync;
	output logic clklatch;
	output logic clkout;
	
	logic clk900KHz;
	logic moveup;
	logic movedown;
	logic moveleft;
	logic moveright;
	logic [5:0] conversioncount;
	logic clkreset
	
	counter #(.N(6))
		clkconverter(
			.clk(inputclk),
			.reset(clkreset),
			.q(conversioncount));
			
	comparator #(.N(6),.M(56))
		clk900KHz(
			.a(conversioncount),
			.alessthanm(clk900KHz));
			
		assign clkreset = reset | ~clk900KHz;
	
	nesconsle
		nesdecoder(
			.data(data),
			.clk_900KHz(),
			.reset(reset),
			.clklatch(clklatch),
			.clkout(clkout),
			.up(moveup),
			.down(movedown),
			.left(moveleft),
			.right(moveright),
	
	
	sprite
		graphicsmodule(
			.inputclk(inputclk),
			.reset_b(reset),
			.background(background),
			.up(moveup),
			.down(movedown),
			.left(moveleft),
			.right(moveright),
			.outred(outred),
			.outgreen(outgreen),
			.outblue(outblue),
			.hsync(hsync),
			.vsync(vsync));