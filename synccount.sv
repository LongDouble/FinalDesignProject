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
	
	hsyncmodule
	horizontal(
		.inputclk(inputclk),
		.reset_b(reset_b),
		.cycleoutput(hsync),
		.linetic(linetic),
		.Hdisplay(Hdisplay));
	
	counter #(.N(10))
	verticalsync(
		.clk(linetic),
		.reset(resetor),
		.q(counterval));
		
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
		
		
	addresscounter
	haddresses(
		.clk(inputclk),
		.enable(Hdisplay & Vdisplay),
		.reset(reset_b),
		.count(hrow));
		
	addresscounter
	vaddresses(
		.clk(linetic),
		.enable(Vdisplay),
		.reset(reset_b),
		.count(vcolumn));
		
		
		assign counterreset = ~resetnot;
		assign Vdisplay = ((~front)&(back));
		assign resetor = counterreset | reset_b;
		assign vsync = ~vsyncnot;
		
	endmodule
	