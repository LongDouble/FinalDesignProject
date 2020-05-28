module AudioDriver(input logic clk, input logic reset, input logic [12:0] freq, output logic signal);
    logic [17:0] count;
    always_ff @(posedge clk, posedge reset)
        if (reset)
            begin
                count <= 0;
                signal <= 0;
            end
        else if(count == 50000000/freq/2 - 1)
            begin
                count <= 0;
                signal <= ~signal;
            end
        else
            count <= count + 1;
endmodule