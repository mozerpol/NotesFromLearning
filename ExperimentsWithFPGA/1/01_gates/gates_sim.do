vlib work

vlog gates.v 
vlog gates_tb.v

vsim work.gates_tb

add wave -color "light blue" -position end sim:/gates_tb/clk
add wave -color #ff7f7f -position end sim:/gates_tb/in1
add wave -color "blue" -position end sim:/gates_tb/in2
add wave -position end sim:/gates_tb/dut/in1_n
add wave -color "white" -position end sim:/gates_tb/dut/in2_n
add wave -color "red" -position end sim:/gates_tb/dut/led1
add wave -color "yellow" -position end sim:/gates_tb/dut/led2
add wave -color "purple" -position end sim:/gates_tb/dut/led3

run -all

wave zoom full
