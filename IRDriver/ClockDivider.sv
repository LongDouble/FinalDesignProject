module ClockDivider #(parameter divide_by = 2, N = 2) (input logic clk, reset, output logic clk_div);
    logic [N-1:0] count;

    always_ff @(posedge clk, negedge clk, posedge reset)
        if (reset)
        begin
            count <= 0;
            clk_div <= 0;
        end
        else
        begin
            if (count < divide_by)
                count <= count + 1;
            else
            begin
                clk_div <= ~clk_div;
                count <= 0;
            end
        end
endmodule