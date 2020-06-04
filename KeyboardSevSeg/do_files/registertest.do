add wave *
add wave data_out

force reset 0 @ 50, 1 @ 100, 0 @ 150
force clk 1 0, 0 {100 ps} -r 200
force data_in 00101010 @ 200, 01001010 @ 400, 10011001 @ 600, 11100110 @ 800, 10100100 @ 1000, 01010110 @ 1200

run 1400


