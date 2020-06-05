//	Counts the cycles inside each line to determine the timing.
//	Reset is active high
//
//
//	Author: Ryan Dillard
//	Date: 6/3/2020
//

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
	

	//Check against the counted values to determine the timing parameter m This one used to control Hsync. 
	//Hsync is then inverted and output
	//file: comparator.sv
	comparator #(.M(96), .N(10)) 
	synccontrol( 
		.a(counterval),
		.alessthanm(hsyncnot));


	//Check against the counted values to determine the timing parameter m is what being checked against
	//True until the cycle leaves the front porch. H display is high when passed
	//file: comparator.sv	
	comparator #(.M(144), .N(10))
	frontporch(
		.a(counterval),
		.alessthanm(front));

	//Check against the counted values to determine the timing parameter m is what being checked against
	//True until it reaches the back porch. H display then becomes low.
	//file: comparator.sv	
	comparator #(.M(784), .N(10))
	backporch(
		.a(counterval),
		.alessthanm(back));

	//Check against the counted values to determine the timing parameter m is what being checked against
	//All cycles have happened and causes the counter to reset and the process to start over.
	//file: comparator.sv	
	comparator #(.M(800), .N(10))
	resetcontrol(
		.a(counterval),
		.alessthanm(resetnot));

	assign Hdisplay = ((~front)&(back));
	assign counterreset = ~resetnot;
	assign resetor = counterreset | reset_b;
	

	//Count increments every clock cycle. used to determine pixel position on the line
	//file: Counter.sv
	counter #(.N(10))
	linesync(
		.clk(inputclk),
		.reset(resetor),
		.q(counterval));
		

	assign cycleoutput = ~hsyncnot;
	assign linetic = counterreset;
	
endmodule
	