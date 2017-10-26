vsim datapath
view wave

add wave IR
add wave clock
add wave reset
add wave rD
add wave rS
add wave rT

force rS 0000000000000001
force rT 0000000000000001
force rD 0000000000000000

force IR 000000000000001100100001 0, 000000000000010100110000 10 -repeat 50
force clock 0 0, 1 5 -repeat 20
force reset 0 0, 1 10 -repeat 40
run 100