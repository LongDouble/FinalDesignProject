/*
This module acts as a shift register for scan
codes. When "clk" is HIGH, all busses of data_out
are shifted to the left to allow for the new 
scan code to arrive. The new scan code is
stored at the 0 index of data_out.
*/

module ScanCodeRegister(input logic clk, reset,
                        input logic [7:0] data_in,
                        output logic [7:0] data_out [5:0]);
    
    //Set HIGH if a reset is incoming;
    logic incoming_reset;

    always_ff @(posedge clk, posedge reset)
        if(reset)
            begin
                data_out[5] <= 0;
                data_out[4] <= 0;
                data_out[3] <= 0;
                data_out[2] <= 0;
                data_out[1] <= 0;
                data_out[0] <= 0;
                incoming_reset <= 0;
            end
        else if(data_in == 8'hf0)
            incoming_reset <= 1;

        else if(incoming_reset == 1)
            incoming_reset <= 0;

        else
            begin
                data_out[6] <= data_out[5];
                data_out[5] <= data_out[4];
                data_out[4] <= data_out[3];
                data_out[3] <= data_out[2];
                data_out[2] <= data_out[1];
                data_out[1] <= data_out[0];
                data_out[0] <= data_in;
            end
endmodule