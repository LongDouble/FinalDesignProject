module nesConsle(input logic data,
                 input logic clk_900KHz, reset
                 output logic clklatch,
                 output logic clkout,
                 output logic a, b, select, start, up, down, left, right);  //Bits order from input 0, 1, 2, 3, 4, 5, 6, 7,
    logic [3:0] clkspeeds;
    logic [7:0] dataOut;
    
    clkdivider(clk_900KHz, reset, clkspeeds);
    assign clklatch <= clkspeeds[2];
    assign clkout <= clk_900KHz;
    seriestoparallel(clk_900KHz,reset,clklatch,data,dataout);
    assign a <= dataout[0];
    assign b <= dataout[1];
    assign select <= dataout[2];
    assign start <= dataout[3];
    assign up <= dataout[4];
    assign down <= dataout[5];
    assign left <= dataout[6];
    assign right <= dataout[7];



endmodule

