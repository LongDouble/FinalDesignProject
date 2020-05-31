module IRDriver(input logic clk, reset, input logic signal, output logic [7:0] value);
    // Clock signal should have a period of 0.5625 ms
    // For a 50MHz clock, divide by 28125
    
    // Alright so here's what I got so far: 
    // Sequence starts with 9 ms solid 0, followed by 4.5 ms of 1.
    // 1 pulses are 2.25 ms long, zeros are 1.125.

    // Sample TWICE every 1.125 ms (once every .5625 ms)
    // Wait for 16 clock cycles of zeroes
    // Then wait 8 clock cycles (ones)
    // Next should be a zero (start of address code)
    // Repeat the following until done reading 
    // check if the previous value was a one. 
    // If it is and the current value is a 1, then we got a 1
    // If it is but the current value is a 0, then we got a 0

    // The first two bytes are address code and its inverse (maybe safe to ignore?)
    // Next two are the actual data.

    logic [7:0] count;
    logic [15:0] saved_values;
    logic [1:0] prev;

    always_ff @(posedge clk, posedge reset)
        if (reset)
        begin
            count <= 0;
            saved_values <= 0;
            prev <= 0;
            value <= 0;
        end
        else
        begin
            // Wait for valid leader code
            if (count < 16)
                count <= signal ? 0 : (count + 1);
            else if (count < 24)
                count <= signal ? (count + 1) : 0;
            else // Receiving data now
            begin
                // Add bit to shift reg once we determine what it is
                if(~signal && prev >= 1)
                begin
                    if (prev == 1)
                    begin
                        saved_values <= saved_values << 1;
                        prev <= 0;
                    end
                    else
                    begin
                        saved_values <= (saved_values << 1) + 1;
                        prev <= 0;
                    end
                end
                else
                    prev <= prev + signal;
                // Check to see if the address code transferred correctly
                if (count == 73 && saved_values[15:8] != ~saved_values[7:0])
                begin:
                    count <= 0;
                    prev <= 0;
                end
                // Check to see if the data was transferred correctly (122 because value gets copied one cycle after output settles)
                else if (count == 122)
                begin
                    if (saved_values[15:8] == ~saved_values[7:0])
                        value <= saved_values;
                    count <= 0;
                    prev <= 0;
                end
                else
                    count <= count + 1;
            end
        end
endmodule
