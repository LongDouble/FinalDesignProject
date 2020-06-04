// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.0.0 Build 614 04/24/2018 SJ Lite Edition"
// CREATED		"Tue Jun 02 21:36:19 2020"

module IRtoAudio(
	ir_signal,
	clk_50MHz,
	reset,
	audio_out
);


input wire	ir_signal;
input wire	clk_50MHz;
input wire	reset;
output wire	audio_out;

wire	SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_1;
wire	[3:0] SYNTHESIZED_WIRE_2;
wire	[12:0] SYNTHESIZED_WIRE_3;





IRDriver	b2v_inst(
	.clk(SYNTHESIZED_WIRE_0),
	.reset(reset),
	.signal(ir_signal),
	.value(SYNTHESIZED_WIRE_1));


IRDecoder	b2v_inst2(
	.value(SYNTHESIZED_WIRE_1),
	.result(SYNTHESIZED_WIRE_2));


NoteEncoder	b2v_inst3(
	.note(SYNTHESIZED_WIRE_2),
	.freq(SYNTHESIZED_WIRE_3));


AudioDriver	b2v_inst4(
	.clk(clk_50MHz),
	.reset(reset),
	.freq(SYNTHESIZED_WIRE_3),
	.signal(audio_out));


ClockDivider	b2v_inst5(
	.clk(clk_50MHz),
	.reset(reset),
	.clk_div(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst5.divide_by = 28125;
	defparam	b2v_inst5.N = 15;


endmodule
