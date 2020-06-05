/*
This is the top level module for the IR to Audio functional unit.
*/

module IRtoAudio(input logic ir_signal, clk_50MHz, reset, output logic audio_out);

logic clk_div;
logic [7:0] scancode;
logic [3:0] btn_pressed;
logic [12:0] frequency;

IRDriver ir_driver(
	.clk(SYNTHESIZED_WIRE_0),
	.reset(reset),
	.signal(ir_signal),
	.value(scancode));

IRDecoder ir_decoder(
	.value(scancode),
	.result(btn_pressed));

NoteEncoder note_encoder(
	.note(btn_pressed),
	.freq(frequency));

AudioDriver audio_driver(
	.clk(clk_50MHz),
	.reset(reset),
	.freq(frequency),
	.signal(audio_out));

ClockDivider clock_divider(
	.clk(clk_50MHz),
	.reset(reset),
	.clk_div(clk_div));
	defparam clock_divider.divide_by = 28125;
	defparam clock_divider.N = 15;

endmodule