add wave -expand -group SYSTEM            -radix dec /tb_example/G_FREQUENCY_HZ_TB
add wave         -group SYSTEM            -radix dec /tb_example/G_BAUD_TB
add wave         -group SYSTEM            -radix bin /tb_example/rst_n_tb
add wave         -group SYSTEM            -radix bin /tb_example/clk_tb
add wave         -group SYSTEM            -radix hex /tb_example/uart_data_tb
add wave         -group SYSTEM            -radix bin /tb_example/uart_rx_tb
add wave         -group SYSTEM            -radix bin /tb_example/uart_tx_tb
add wave         -group SYSTEM            -radix hex /tb_example/uart_wdata_tb
add wave         -group SYSTEM            -radix bin /tb_example/uart_we_tb


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
