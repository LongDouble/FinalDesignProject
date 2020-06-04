//  Responsible for interactions with the NES controller, and for decoding the data into a usable format
//
//	Author: Ryan Dillard
//	Date: 6/3/2020
//




module nesConsle(input logic data,
                 input logic clk_900KHz, reset,
                 output logic clklatch,
                 output logic clkout,
                 output logic a, b, select, start, up, down, left, right);  //Bits order from input 0, 1, 2, 3, 4, 5, 6, 7,
    logic [3:0] clkspeeds;
    logic [7:0] dataout;
    
    //Divides the input clock speed by 8 to make the latch signal which controls the shift register read.
    //file: clockdivider.sv
    clkdivider
	makinglatch(clk_900KHz, reset, clkspeeds);
    assign clklatch = clkspeeds[3];
    assign clkout = clk_900KHz;
    
    //Uses a shift register to convert the serial data into seperate signals
    //file: seriestoparallel.sv
    seriestoparallel
	serialconverter(clk_900KHz,reset,clklatch,~data,dataout);
    
    //assigns the seperated out data to the corresponding input
    assign a = dataout[0];
    assign b = dataout[1];
    assign select = dataout[2];
    assign start = dataout[3];
    assign up = dataout[4];
    assign down = dataout[5];
    assign left = dataout[6];
    assign right = dataout[7];



endmodule

