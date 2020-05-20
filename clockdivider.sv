module clkdivider #(parameter N = 4)
                 (input logic initialclk,
                  input logic reset,
                  output logic [N-1:0] newclock);

    always @(posedge initialclk, posedge reset)
        if(reset) newclock <= 0;
        else      newclock <= newclock +1;

endmodule
    