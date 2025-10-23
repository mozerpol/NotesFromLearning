add wave -expand -group SYSTEM            -radix bin /testbench/a_in
add wave         -group SYSTEM            -radix bin /testbench/b_in
add wave         -group SYSTEM            -radix bin /testbench/c_out


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
