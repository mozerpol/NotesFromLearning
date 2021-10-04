vlib work

vlog ../3/03_shiftreg/counter.sv
vlog uart_pkg.sv
vlog uart_tx.sv
vlog uart_tx_tb.sv

vsim work.uart_tx_tb

add wave -position end sim:/uart_tx_tb/clk
add wave -position end sim:/uart_tx_tb/rst
add wave -position end sim:/uart_tx_tb/bus/data
add wave -position end sim:/uart_tx_tb/bus/valid
add wave -position end sim:/uart_tx_tb/bus/ready

add wave -position end sim:/uart_tx_tb/dut/handshake

add wave -position end -hex sim:/uart_tx_tb/dut/txb
add wave -position end -hex sim:/uart_tx_tb/dut/i
add wave -position end sim:/uart_tx_tb/dut/state

add wave -position end sim:/uart_tx_tb/dut/tx

run 100us

wave zoom full
