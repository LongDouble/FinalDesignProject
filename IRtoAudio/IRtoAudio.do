restart -f

add wave *
force reset 1 @ 0, 0 @ 50
force clk_50MHz 0 @ 0, 1 @ 10000 -r 20000
force ir_signal 1 @ 0, 0 @ 16900999999, 1 @ 25834999999, 0 @ 30235999999, 1 @ 30823999999, 0 @ 32494999999, 1 @ 33086999999, 0 @ 33662999999, 1 @ 34229999999, 0 @ 34808999999, 1 @ 35375999999, 0 @ 37068999999, 1 @ 37635999999, 0 @ 38214999999, 1 @ 38781999999, 0 @ 39356999999, 1 @ 39928999999, 0 @ 40503999999, 1 @ 41070999999, 0 @ 42762999999, 1 @ 43350999999, 0 @ 43930999999, 1 @ 44497999999, 0 @ 46189999999, 1 @ 46761999999, 0 @ 48453999999, 1 @ 49020999998, 0 @ 49595999999, 1 @ 50167999999, 0 @ 51859999999, 1 @ 52426999999, 0 @ 54118999999, 1 @ 54689999999, 0 @ 56382999999, 1 @ 56953999999, 0 @ 57545999999, 1 @ 58116999999, 0 @ 59788999999, 1 @ 60380999999, 0 @ 62068999999, 1 @ 62639999999, 0 @ 63215999999, 1 @ 63786999999, 0 @ 64361999999, 1 @ 64928999999, 0 @ 65504999999, 1 @ 66075999999, 0 @ 66650999999, 1 @ 67217999999, 0 @ 68888999999, 1 @ 69481999999, 0 @ 70077999999, 1 @ 70648999999, 0 @ 71224999999, 1 @ 71791999999, 0 @ 72366999999, 1 @ 72937999999, 0 @ 74608999999, 1 @ 75196999999, 0 @ 76889999999, 1 @ 77485999999, 0 @ 79152999999, 1 @ 79745999999, 0 @ 81416999999, 1 @ 82008999999, 0 @ 82558999998, 1 @ 83151999999, 0 @ 84796999999, 1 @ 85410999999
run 2085411000099