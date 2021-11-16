#-
# SPDX-License-Identifier: BSD-3-Clause
#
# Copyright (c) 2019 Rafal Kozik
# All rights reserved.
#

vlib work

vlog counter.sv
vlog uart_pkg.sv
vlog uart_tx.sv
vlog uart_rx.sv
vlog uart_rx_tb.sv

vsim work.uart_rx_tb

add wave -position end sim:/uart_rx_tb/clk
add wave -position end sim:/uart_rx_tb/rst
add wave -position end sim:/uart_rx_tb/bus_tx/valid
add wave -position end -hex sim:/uart_rx_tb/bus_tx/data
add wave -position end sim:/uart_rx_tb/rtx

add wave -position end -hex sim:/uart_rx_tb/dut/rxb
add wave -position end sim:/uart_rx_tb/dut/s
add wave -position end sim:/uart_rx_tb/dut/i
add wave -position end sim:/uart_rx_tb/dut/rx_clk
add wave -position end -hex sim:/uart_rx_tb/dut/bus/data
add wave -position end -hex sim:/uart_rx_tb/dut/bus/valid

run 100us

wave zoom full
