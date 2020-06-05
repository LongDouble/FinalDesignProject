add wave -position end  sim:/nestovga/inputclk
add wave -position end  sim:/nestovga/data
add wave -position end  sim:/nestovga/reset
add wave -position end  sim:/nestovga/background
add wave -position end  sim:/nestovga/outred
add wave -position end  sim:/nestovga/outgreen
add wave -position end  sim:/nestovga/outblue
add wave -position end  sim:/nestovga/hsync
add wave -position end  sim:/nestovga/vsync
add wave -position end  sim:/nestovga/clklatch
add wave -position end  sim:/nestovga/clkout
force reset 0 @ 1, 1 @ 3, 0 @ 5
force inputclk 0 @ 10, 1 @ 20 -r 20
force background 000000001111
force data 0
run 34000000