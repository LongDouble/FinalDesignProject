module KeyboardSevSeg(input  logic clk, data_in, reset,
                      output logic [6:0] segments [5:0]);

    logic ready;
    logic [7:0] converted_data;
    logic [7:0] registered_data [5:0];

PS2Converter converter(
.clk(clk),
.data_in(data_in),
.reset(reset),
.ready(ready),
.data_out(converted_data)
);

ScanCodeRegister register(
.clk(ready),
.reset(reset),
.data_in(converted_data),
.data_out(registered_data)
);

endmodule