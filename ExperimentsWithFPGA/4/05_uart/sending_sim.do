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
vlog data_source.sv
vlog to_ascii.sv
vlog sending.sv
vlog sending_tb.sv

vsim work.sending_tb

add wave -position end sim:/sending_tb/clk
add wave -position end sim:/sending_tb/rst

add wave -position end sim:/sending_tb/dut/bus_num/data
add wave -position end sim:/sending_tb/dut/bus_num/valid
add wave -position end sim:/sending_tb/dut/bus_num/ready

add wave -position end sim:/sending_tb/dut/bus_ascii/data
add wave -position end sim:/sending_tb/dut/bus_ascii/valid
add wave -position end sim:/sending_tb/dut/bus_ascii/ready

add wave -position end sim:/sending_tb/dut/uart/tx

run 3200ms

wave zoom full
