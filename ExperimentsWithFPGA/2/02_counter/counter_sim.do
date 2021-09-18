vlib work

vlog counter.v
vlog counter_tb.v

vsim work.counter_tb

add wave -position end sim:/counter_tb/clk
add wave -position end sim:/counter_tb/rst
add wave -position end sim:/counter_tb/ce
add wave -position end -unsigned sim:/counter_tb/dut1/q
add wave -position end sim:/counter_tb/dut1/ov
add wave -position end sim:/counter_tb/dut2/ce
add wave -position end -unsigned sim:/counter_tb/dut2/q
add wave -position end sim:/counter_tb/dut2/ov

run 40us
wave zoom full
