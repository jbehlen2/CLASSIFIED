vsim datapath
view wave

add wave IR
add wave clock
add wave reset
add wave DataD

force clock 0 0, 1 5 -repeat 20
force reset 0 0, 1 10 -repeat 40
force IR 011000000000001100100000 0
run 1000