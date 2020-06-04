/*
This module receives an 8-bit scan code
and displays its corresponding keys on a
seven-segment display.
*/

module SevenSeg(input  logic [7:0] data,
                output logic [6:0] segments);
				
	always_comb
		case(data)
			//                   gfe_dcba
			8'h1D:   segments=7'b100_0001; //w ('u' is displayed)
			8'h1C:   segments=7'b000_1000; //a 
			8'h2C:   segments=7'b000_0111; //t 
			8'h24:   segments=7'b000_0110; //e 
			8'h2D:   segments=7'b010_1111; //r 
			8'h23:   segments=7'b010_0001; //d 
			8'h2B:   segments=7'b000_1110; //f 
			8'h34:   segments=7'b100_0010; //g 
			8'h1B:   segments=7'b001_0010; //s 
			default: segments=7'b000_0000;
		endcase
endmodule