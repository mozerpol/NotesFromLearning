onerror {quit -code 1}
source "/home/mozerpol/Downloads/Vunit/UART/vunit_out/test_output/tb_lib.tb_example.test_case_name_cbfb0d99bd475a4d6183cd1be40b23deda010ff7/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
