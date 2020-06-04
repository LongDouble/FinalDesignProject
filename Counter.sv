//  Basic counting module increments q by one on the rising edge of each clock cycle
//  Active high reset
//
//
//	Author: Ryan Dillard
//	Date: 6/3/2020
//

module counter #(parameter N = 25)(input  logic clk, reset,
                                   output logic [N-1:0] q); 
                 
    always_ff @(posedge clk, posedge reset) 
    if (reset) q <= 0; 
    else       q <= q + 1; 
    
endmodule