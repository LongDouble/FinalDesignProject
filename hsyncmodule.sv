module hsyncmodule(inputclk,reset_b,cycleoutput,linetic,Hdisplay);


	input logic inputclk;
	input logic reset_b;
	output logic cycleoutput;
	output logic linetic;
	output logic Hdisplay;
	
	logic counterreset;
	logic [9:0] counterval;
	logic resetor;
	logic hsyncnot;
	logic resetnot;
	logic front;
	logic back;
	
	comparator #(.M(96), .N(10)) 
	synccontrol( 
		.a(counterval),
		.alessthanm(hsyncnot));
		
	comparator #(.M(144), .N(10))
	frontporch(
		.a(counterval),
		.alessthanm(front));
		
	comparator #(.M(784), .N(10))
	backporch(
		.a(counterval),
		.alessthanm(back));
		
	comparator #(.M(800), .N(10))
	resetcontrol(
		.a(counterval),
		.alessthanm(resetnot));

	assign Hdisplay = ((~front)&(back));
	assign counterreset = ~resetnot;
	assign resetor = counterreset | reset_b;
	
	counter #(.N(10))
	linesync(
		.clk(inputclk),
		.reset(resetor),
		.q(counterval));
		

	assign cycleoutput = ~hsyncnot;
	assign linetic = counterreset;
	
endmodule
	