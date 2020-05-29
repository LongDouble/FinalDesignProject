/* 
This module takes in a serial input from a
PS/2 keyboard and outputs the value of the
scan code in HEX. When a scan code has been
completely read and is avaiable at data_out, 
ready is set HIGH.
*/

module PS2Converter(input  logic        clk, data_in, reset,
                    output logic        ready,
                    output logic [7:0] data_out);

    //Defining states for state machine
    typedef enum logic [1:0] {waiting, reading, stop_bit} statetype;
    statetype state, nextstate;

    //will track how many bits have been shifted
    logic [3:0] bits_shifted; 

    //State register
    always_ff @(negedge clk, posedge reset)
        if(reset) state <= waiting;
        else      state <= nextstate;

    //next state logic
    always_comb
        case (state)
            waiting: //Waiting for data_in to be 0
                if (~data_in) 
                    nextstate = reading;
                else          
                    nextstate = waiting;

            reading: 
                if (bits_shifted < 7) //More scan data to be read
                    nextstate = reading;
                else //All scan data has been read
                    nextstate = stop_bit;     

            stop_bit:
                nextstate = waiting;

            default:
                nextstate = waiting;
        endcase
    
    //Shift register for output data 
    always_ff @(negedge clk, posedge reset)
        begin
            if (reset) 
                begin
                    data_out <= 0;
                    ready <= 0;
                end
            else if (state == waiting)
                begin
                    ready <= 0;
                    bits_shifted <= 0;
                end

            else if (state == reading)
                begin
                    data_out <= data_out >> 1;
                    data_out[7] <= data_in;
                    bits_shifted <= bits_shifted + 1;
                end

            else if (state == stop_bit)
                ready <= 1;
        end
        
endmodule