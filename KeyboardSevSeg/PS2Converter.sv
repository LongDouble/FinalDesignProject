/* 
This module recieves a serial input from a
PS/2 keyboard and outputs the value of the
scan code in HEX. When a scan code has been
completely read and is avaiable at data_out, 
ready is set HIGH.
*/

module PS2Converter(input  logic        clk, data_in, reset,
                    output logic        ready,
                    output logic [7:0]  data_out);

    //Defining states for state machine
    typedef enum logic [1:0] {waiting, reading, parity_bit, stop_bit} statetype;
    statetype state, nextstate;

    //Tracks how many bits have been shifted
    logic [3:0] bits_shifted; 

    //State register
    always_ff @(negedge clk, posedge reset)
        if(reset) state <= waiting;
        else      state <= nextstate;

    //Next state logic
    always_comb
        case (state)

            //Waiting for data_in to be 0
            waiting: 

                //Start bit was recieved
                if (~data_in) 
                    nextstate = reading;

                //No start bit was recieved
                else          
                    nextstate = waiting;

            reading: 

                //More scan data to be read
                if (bits_shifted < 7) 
                    nextstate = reading;
                    
                //State will change to parity_bit on final scan data read
                else 
                    nextstate = parity_bit;

            //No error checking
            parity_bit: 
                nextstate = stop_bit;     

            //No checking stop bit
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

            //Getting ready to shift in data
            else if (state == waiting)
                begin
                    ready <= 0;
                    bits_shifted <= 0;
                end

            //Shifting in serial data
            else if (state == reading)
                begin
                    data_out <= data_out >> 1;
                    data_out[7] <= data_in;
                    bits_shifted <= bits_shifted + 1;
                end

            //Set ready HIGH to indicate all data has been read
            else if (state == stop_bit)
                ready <= 1;
        end
        
endmodule