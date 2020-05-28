module SevenSeg(input  logic [7:0] data,
				output logic [6:0] segments);
	always_comb
		case(data)
			//						   gfe_dcba
			8'h1D:       segments=7'b100_0001; //w //can't actually be represented, so a U is shown instead 1000001
			8'h1C:       segments=7'b000_1000; //a 0001000
			8'h2C:       segments=7'b000_0111; //t 0000111
			8'h24:       segments=7'b000_0110; //e 0000110
			8'h2D:       segments=7'b010_1111; //r 0101111
			8'h23:       segments=7'b010_0001; //d 0100001
			8'h2B:       segments=7'b000_1110; //f 0001110
			8'h34:       segments=7'b100_0010; //g 1000010
			8'h1B:       segments=7'b001_0010; //s 0010010
			default: segments=7'b000_0000;
		endcase
endmodule