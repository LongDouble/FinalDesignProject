//simple mux with variable bus size used for structural design

module multibitmux #(parameter N = 4)
	(color, pick, background, colorout);
	
	input logic [N-1:0] color;
	input logic [N-1:0] background;
	input logic pick;
	output logic [N-1:0] colorout;
	
	assign colorout = pick ? (color) : (background);
	
endmodule
