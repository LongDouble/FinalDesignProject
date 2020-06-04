/*
This is the top-level module for the 
PS/2 keyboard to seven-segment display
output.
*/

module KeyboardSevSeg(input  logic       clk, data_in, reset,
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

    SevenSeg segment0(registered_data[0], segments[0]);
    SevenSeg segment1(registered_data[1], segments[1]);
    SevenSeg segment2(registered_data[2], segments[2]);
    SevenSeg segment3(registered_data[3], segments[3]);
    SevenSeg segment4(registered_data[4], segments[4]);
    SevenSeg segment5(registered_data[5], segments[5]);

endmodule