module seriestoparallel(input logic clk, reset, clklatch,
                        input logic data, 
                        output logic [7:0] dataOut);

    logic [7:0] dataNext;
	 


    always_ff @(posedge clk, posedge reset) //shift registers so the input can be broken into sepeate channels.
        begin
            if(reset) dataNext <= 0;
            else
                dataNext <= dataNext >> 1;
                dataNext[7] <= data;
        end

    always @(posedge clklatch, posedge reset) //buffer registers so outputs are all readable at once.
        begin
            if(reset) dataOut <= 0;
            else
                dataOut <= dataNext;
        end

endmodule     

