##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.


##### Add waves: #####
add wave -expand -group TB -radix binary /all_gates_tb/a_all
add wave -expand -group TB -radix binary /all_gates_tb/b_all
add wave -expand -group TB -radix binary /all_gates_tb/c_all
add wave -expand -group TB -radix binary /all_gates_tb/d_all

add wave -expand -group DESIGN -radix binary /all_gates_tb/inst_dut/i_a_all
add wave -expand -group DESIGN -radix binary /all_gates_tb/inst_dut/i_b_all
add wave -expand -group DESIGN -radix binary /all_gates_tb/inst_dut/i_c_all
add wave -expand -group DESIGN -radix binary /all_gates_tb/inst_dut/o_d_all

add wave -expand -group OR -radix binary /all_gates_tb/inst_dut/a_or
add wave -expand -group OR -radix binary /all_gates_tb/inst_dut/b_or
add wave -expand -group OR -radix binary /all_gates_tb/inst_dut/c_or

add wave -expand -group AND -radix binary /all_gates_tb/inst_dut/a_and
add wave -expand -group AND -radix binary /all_gates_tb/inst_dut/b_and
add wave -expand -group AND -radix binary /all_gates_tb/inst_dut/c_and


##### Waveform window settings: #####
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
