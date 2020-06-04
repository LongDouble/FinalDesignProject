//	Handles syncronizing the outputs to meet timing requirements to drive a VGA monitor
//
//
//	Author: Ryan Dillard
//	Date: 6/3/2020
//

module synccount(inputclk, reset_b, hsync, vsync, Hdisplay, Vdisplay, hrow , vcolumn);

	input logic inputclk;
	input logic reset_b;
	output logic hsync;
	output logic vsync;
	output logic Hdisplay;
	output logic Vdisplay;
	output logic [9:0] hrow;
	output logic [9:0] vcolumn;
	
	logic [9:0] counterval;
	logic front;
	logic back;
	logic resetor;
	logic resetnot;
	logic vsyncnot;
	logic counterreset;
	logic linetic;
	
	//Module handles timing reqirements for each individual line outputs linetic when hsync restarts
	//file: hsyncmodule.sv
	hsyncmodule
	horizontal(
		.inputclk(inputclk),
		.reset_b(reset_b),
		.cycleoutput(hsync),
		.linetic(linetic),
		.Hdisplay(Hdisplay));
	
	//Count increments every time a line finishes on rising endge of linetic
	//file: Counter.sv
	counter #(.N(10))
	verticalsync(
		.clk(linetic),
		.reset(resetor),
		.q(counterval));
		

	//Check against the counted values to determine the timing parameter m is what being checked against
	//file: comparator.sv
	comparator #(.M(2), .N(10)) 
	synccontrol( 
		.a(counterval),
		.alessthanm(vsyncnot));
		
	comparator #(.M(35), .N(10))
	frontporch(
		.a(counterval),
		.alessthanm(front));
		
	comparator #(.M(515), .N(10))
	backporch(
		.a(counterval),
		.alessthanm(back));
		
	comparator #(.M(525), .N(10))
	resetcontrol(
		.a(counterval),
		.alessthanm(resetnot));
		
	//When in display this counts to determine which pixel is being worked on
	//file: en-counter.sv	
	addresscounter
	haddresses(
		.clk(inputclk),
		.enable(Hdisplay & Vdisplay),
		.reset(reset_b),
		.count(hrow));
		
	//When in display this counts to determine which pixel is being worked on
	//file: en-counter.sv		
	addresscounter
	vaddresses(
		.clk(linetic),
		.enable(Vdisplay),
		.reset(reset_b),
		.count(vcolumn));
		
		
		assign counterreset = ~resetnot;
		//In the display interval when they are passed the front interval, but haven't reached the back porch
		assign Vdisplay = ((~front)&(back));
		assign resetor = counterreset | reset_b;
		assign vsync = ~vsyncnot;
		
	endmodule
	