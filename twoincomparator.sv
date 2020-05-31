// checks if the address minus a shift is less
//than the paramete

module twoincomparator #(parameter N = 8, M = 16)
(check, shift, inrange);

    input logic [N-1:0] check;
    input logic [N-1:0] shift;
    output logic inrange;

    assign inrange = ((check - shift) < M);

endmodule