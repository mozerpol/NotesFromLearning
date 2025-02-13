onerror {quit -code 1}
source "/home/mozerpol/Downloads/Vunit/UART/vunit_out/test_output/tb_lib.tb_example.test_send_one_byte_9d4f4eaff37d4672b1c1de729cff21ae734fdc3e/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
