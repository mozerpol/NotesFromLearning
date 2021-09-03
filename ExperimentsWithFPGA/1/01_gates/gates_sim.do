vlib work

vlog gates.v
vlog gates_tb.v

vsim work.gates_tb

add wave -position end sim:/gates_tb/clk
add wave -position end sim:/gates_tb/in1
add wave -position end sim:/gates_tb/in2
add wave -position end sim:/gates_tb/dut/in1_n
add wave -position end sim:/gates_tb/dut/in2_n
add wave -position end sim:/gates_tb/dut/led1
add wave -position end sim:/gates_tb/dut/led2
add wave -position end sim:/gates_tb/dut/led3

run -all

wave zoom full

