vsim ClaAdder
view wave

add wave x
add wave y
add wave c_In

add wave c_Gen1
add wave c_Prop1
add wave sum

force x 0000000000000000 0, 1111111111111111 5 -repeat 10
force y 0000000000000000 0, 1101010101010101 10 -repeat 20
force c_In 0 0, 1 20 -repeat 40
run 500