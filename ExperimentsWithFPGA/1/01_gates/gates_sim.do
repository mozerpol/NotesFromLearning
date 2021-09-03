# vlib - this command creates a design library
vlib work

# vlog - compiles Verilog source code and SystemVerilog extensions into a
# specified working library (or to the work library by default).
# The compiling order is important!
vlog gates.v 
vlog gates_tb.v

# vsim - invokes the VSIM simulator, which you can use to view the results of a
# previous simulation run
vsim work.gates_tb

add wave -color "light blue" -position end sim:/gates_tb/clk
add wave -color #ff7f7f -position end sim:/gates_tb/in1
add wave -color "blue" -position end sim:/gates_tb/in2
add wave -position end sim:/gates_tb/dut/in1_n
add wave -color "white" -position end sim:/gates_tb/dut/in2_n
add wave -color "red" -position end sim:/gates_tb/dut/led1
add wave -color "yellow" -position end sim:/gates_tb/dut/led2
add wave -color "purple" -position end sim:/gates_tb/dut/led3

# run -all - runs the entire simulation. All, until no signal changes any more, or until
# the $stop command appears
run -all

# wave zoom full - zoom the wave display to show the full simulation time
wave zoom full
