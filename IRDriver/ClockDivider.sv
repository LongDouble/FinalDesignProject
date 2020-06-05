/*
This module takes parameters for the amount to divide
the input clock signal by and the number of bits it
takes to represent that value. It divides the clock
signal by the specified value and outputs the divided
clock signal.
*/

module ClockDivider #(parameter divide_by = 2, N = 2) (input logic clk, reset, output logic clk_div);
    logic [N-1:0] count;
    logic tff1; // state of first tff
    logic tff2; // state of second tff

    always_ff @(posedge clk, posedge reset)
        if (reset)
        begin
            count <= 0;
        end
        else
        begin
            if (count == divide_by - 1)
                count <= 0;
            else
                count <= count + 1;
        end
    
    always_ff @(posedge clk, posedge reset)
        if (reset)
            tff1 <= 0;
        else if (count == 0) // enable
            tff1 <= ~tff1;
    
    always_ff @(negedge clk, posedge reset) // offset by half a clock cycle
        if (reset)
            tff2 <= 0;
        else if (count == (divide_by/2)+1) // enable
            tff2 <= ~tff2;

    assign clk_div = tff1 ^ tff2; // the resulting clock is the XOR of the states of the two flip flops
endmodule