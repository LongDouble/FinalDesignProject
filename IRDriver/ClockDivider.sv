/*
This module takes parameters for the amount to divide
the input clock signal by and the number of bits it
takes to represent that value. It divides the clock
signal by the specified value and outputs the divided
clock signal.
*/

module ClockDivider #(parameter divide_by = 2, N = 2) (input logic clk, reset, output logic clk_div);
    logic [N-1:0] count;
    // Double edge triggered so that we can divide by odd numbers
    always_ff @(posedge clk, negedge clk, posedge reset)
        if (reset)
        begin
            count <= 0;
            clk_div <= 0;
        end
        else
        begin
            if (count < divide_by - 1)
                count <= count + 1;
            else
            begin
                clk_div <= ~clk_div; // toggle the  output
                count <= 0;
            end
        end
endmodule