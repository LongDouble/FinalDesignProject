//converts the columns and rows into a single address using hexadecimal
//
//
//	Author: Ryan Dillard
//	Date: 6/3/2020
//



module addressconverter(row, column, rowshift, columnshift, address);

	input logic [9:0] row;
	input logic [9:0] column;
    input logic [9:0] rowshift;
    input logic [9:0] columnshift;
	output logic [7:0] address;
	//The data in the rom is a 16 by 16 sprite
	//treat the upper left corner as (0,0)
	//The row holds where in the x it is.
	//The column refrences where in the y it is.
	//addresses are continuous.
	assign address = ((column-columnshift) * 16) + (row-rowshift);
	
	
endmodule 