module AudioDriver(input logic clk, input logic [12:0] freq, output logic signal);
    logic [17:0] count;
    always_ff @(posedge clk)
        if(count == 50000000/freq/2)
            begin
                count <= 0;
                signal <= ~signal;
            end
        else
            count <= count + 1;
endmodule