module FinalDesign(input  logic        ps2_clk, ps2_data_in, reset,
                   input  logic        clock_50mhz, nes_data, 
                   input  logic [11:0] background,  
                   input  logic        ir_signal, 
                   output logic [6:0]  segments [5:0],
                   output logic [3:0]  outred, outgreen, outblue,
                   output logic        hsync, vsync, clklatch, clkout,
                   output logic        audio_out
                   );

    KeyboardSevSeg keyboard_sevenseg_module(
        .clk(ps2_clk),
        .data_in(ps2_data_in),
        .reset(reset),
        .segments(segments)
    );

    nestovga nes_vga_module(
        .inputclk(clock_50mhz), 
        .data(nes_data), 
        .reset(reset), 
        .background(background), 
        .outred(outred), 
        .outgreen(outgreen), 
        .outblue(outblue), 
        .hsync(hsync), 
        .vsync(vsync), 
        .clklatch(clklatch), 
        .clkout(clkout)
    );

    IRtoAudio ir_to_audio_module(
        .ir_signal(ir_signal),
        .clk_50MHz(clock_50mhz),
	    .reset(reset),
	    .audio_out(audio_out)
    );


endmodule