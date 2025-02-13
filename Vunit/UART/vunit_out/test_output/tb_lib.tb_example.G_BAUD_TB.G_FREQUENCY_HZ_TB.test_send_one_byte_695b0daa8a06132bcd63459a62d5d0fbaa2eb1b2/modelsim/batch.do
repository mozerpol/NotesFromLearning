onerror {quit -code 1}
source "/home/mozerpol/Downloads/Vunit/UART/vunit_out/test_output/tb_lib.tb_example.G_BAUD_TB.G_FREQUENCY_HZ_TB.test_send_one_byte_695b0daa8a06132bcd63459a62d5d0fbaa2eb1b2/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
