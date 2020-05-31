add wave -position end  sim:/sprite/inputclk
add wave -position end  sim:/sprite/reset_b
add wave -position end  sim:/sprite/background
add wave -position end  sim:/sprite/up
add wave -position end  sim:/sprite/down
add wave -position end  sim:/sprite/left
add wave -position end  sim:/sprite/right
add wave -position end  sim:/sprite/outred
add wave -position end  sim:/sprite/outgreen
add wave -position end  sim:/sprite/outblue
add wave -position end  sim:/sprite/hsync
add wave -position end  sim:/sprite/vsync
add wave -position end  sim:/sprite/hrow
add wave -position end  sim:/sprite/vcolumn
add wave -position end  sim:/sprite/clkvga
add wave -position end  sim:/sprite/colorin
add wave -position end  sim:/sprite/sprite
add wave -position end  sim:/sprite/select
add wave -position end  sim:/sprite/address
add wave -position end  sim:/sprite/display
add wave -position end  sim:/sprite/validh
add wave -position end  sim:/sprite/validv
add wave -position end  sim:/sprite/hshift
add wave -position end  sim:/sprite/vshift
force reset_b 0 @ 1, 1 @ 3, 0 @ 5
force inputclk 1 @ 5, 0 @ 10 -r 10
force background 111100000000
force up 0
force down 0
force left 0
force right 0
run 170000000
