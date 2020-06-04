//Counter requres the enable to be logic high for any counting to occur
//Counter resets when enable is logic low
//
//
//	Author: Ryan Dillard
//	Date: 6/3/2020
//
module addresscounter #(parameter N = 10)
	(clk, enable, reset, count);
	
	input logic clk;
	input logic enable;
	input logic reset;
	output logic [N-1:0]count;
	
	always_ff @ (posedge clk, posedge reset)
		if(reset) count <= 0;
		else if(enable) count <= count + 1;
		else count <= 0;
		
	endmodule
	