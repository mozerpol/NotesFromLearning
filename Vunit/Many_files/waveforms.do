add wave -expand -group ALL_GATES   -radix bin /all_gates_tb/inst_dut/i_a_all
add wave -expand -group ALL_GATES   -radix bin /all_gates_tb/inst_dut/i_b_all
add wave -expand -group ALL_GATES   -radix bin /all_gates_tb/inst_dut/i_c_all
add wave -expand -group ALL_GATES   -radix bin /all_gates_tb/inst_dut/o_d_all

add wave -expand -group AND_GATE    -radix bin /all_gates_tb/inst_dut/inst_and_gate/i_a_and
add wave -expand -group AND_GATE    -radix bin /all_gates_tb/inst_dut/inst_and_gate/i_b_and
add wave -expand -group AND_GATE    -radix bin /all_gates_tb/inst_dut/inst_and_gate/o_c_and

add wave -expand -group OR_GATE     -radix bin /all_gates_tb/inst_dut/inst_or_gate/i_a_or
add wave -expand -group OR_GATE     -radix bin /all_gates_tb/inst_dut/inst_or_gate/i_b_or
add wave -expand -group OR_GATE     -radix bin /all_gates_tb/inst_dut/inst_or_gate/o_c_or


# Waveform window settings:
quietly wave cursor active 1
configure wave -namecolwidth 194
configure wave -valuecolwidth 125
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
