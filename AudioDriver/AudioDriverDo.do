vsim work.AudioDriver -t 1ns
add wave *

force reset 1 @ 0, 0 @ 12

force clk 0 @ 0, 1 @ 10 -r 20
force freq 10#500

run 50000000