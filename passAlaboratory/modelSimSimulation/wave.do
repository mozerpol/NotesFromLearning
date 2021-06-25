onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /comb_complex_tb/b1_i_tb
add wave -noupdate /comb_complex_tb/b2_i_tb
add wave -noupdate /comb_complex_tb/b3_i_tb
add wave -noupdate /comb_complex_tb/b4_o_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {5 ps}
