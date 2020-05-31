//Basic comparator
//Checks if input is less than defined m


module comparator #(parameter N = 8, M = 60)
						 (input  logic [N-1:0] a,
						  output logic alessthanm);
						  
	assign alessthanm = a < M;
	
endmodule