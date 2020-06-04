// checks if the address minus a shift is less
// than the parameter m if so inrange is logic high
//
//	Author: Ryan Dillard
//	Date: 6/3/2020
//

module twoincomparator #(parameter N = 8, M = 16)
(check, shift, inrange);

    input logic [N-1:0] check;
    input logic [N-1:0] shift;
    output logic inrange;

    assign inrange = ((check - shift) < M);

endmodule