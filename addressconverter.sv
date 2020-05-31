//converts the columns and rows into a single address using hexadecimal

module addressconverter(row, column, rowshift, columnshift, address);

	input logic [9:0] row;
	input logic [9:0] column;
    input logic [9:0] rowshift;
    input logic [9:0] columnshift;
	output logic [7:0] address;
	
	assign address = ((column-columnshift) * 16) + (row-rowshift);
	
	
endmodule 