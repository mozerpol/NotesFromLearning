onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ADS8588H_tb/sys_clk
add wave -noupdate /ADS8588H_tb/refsel_tb
add wave -noupdate /ADS8588H_tb/stby_tb
add wave -noupdate /ADS8588H_tb/convsta_tb
add wave -noupdate /ADS8588H_tb/convstb_tb
add wave -noupdate /ADS8588H_tb/reset_tb
add wave -noupdate /ADS8588H_tb/range_tb
add wave -noupdate /ADS8588H_tb/cs_tb
add wave -noupdate /ADS8588H_tb/rd_sclk_tb
add wave -noupdate /ADS8588H_tb/par_ser_tb
add wave -noupdate /ADS8588H_tb/db_tb
add wave -noupdate /ADS8588H_tb/os_tb
add wave -noupdate /ADS8588H_tb/db_bus_ctrl
add wave -noupdate /ADS8588H_tb/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {633581 ns}
