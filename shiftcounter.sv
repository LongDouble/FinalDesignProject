//keeps track of the offset from the controller
//updates status on register logic high
//
//
//	Author: Ryan Dillard
//	Date: 6/3/2020
//
module shiftcounter #(parameter N = 8)
    (increase, decrease, register, reset, shift);

    input logic increase;
    input logic decrease;
    input logic register;
    input logic reset;
    output logic [N-1:0] shift;
    
    //counter but has the ability to decrement, as well as increment depending inputs.
    always_ff @(posedge register, posedge reset) //Will change only if one of the options is true
        begin
            if(reset) shift <= 0;
            else if( increase & ~decrease)  shift <= shift +1;
            else if( ~increase & decrease)  shift <= shift -1;
        end
        

endmodule
