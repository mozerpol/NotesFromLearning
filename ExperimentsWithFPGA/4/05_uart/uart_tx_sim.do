vlib work

vlog counter.v
vlog uart_tx.v
vlog uart_tx_tb.v

vsim work.uart_tx_tb

add wave -position end sim:/uart_tx_tb/clk
add wave -position end sim:/uart_tx_tb/rst
add wave -position end sim:/uart_tx_tb/data
add wave -position end sim:/uart_tx_tb/valid
add wave -position end sim:/uart_tx_tb/ready

add wave -position end sim:/uart_tx_tb/dut/handshake

add wave -position end -hex sim:/uart_tx_tb/dut/txb
add wave -position end -hex sim:/uart_tx_tb/dut/i
add wave -position end sim:/uart_tx_tb/dut/state

add wave -position end sim:/uart_tx_tb/dut/tx

run 100us

wave zoom full
