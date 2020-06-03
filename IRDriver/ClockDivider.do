add wave *
change divide_by 10#4
change N 10#3 
force clk 0 @ 0, 1 @ 100 -r 200
force reset 1 @ 0, 0 @ 5
run 10000