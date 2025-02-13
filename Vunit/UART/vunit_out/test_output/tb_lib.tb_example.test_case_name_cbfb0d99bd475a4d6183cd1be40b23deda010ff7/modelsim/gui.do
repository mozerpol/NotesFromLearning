source "/home/mozerpol/Downloads/Vunit/UART/vunit_out/test_output/tb_lib.tb_example.test_case_name_cbfb0d99bd475a4d6183cd1be40b23deda010ff7/modelsim/common.do"
proc vunit_user_init {} {

    set vunit_tb_path "/home/mozerpol/Downloads/Vunit/UART"
    set file_name "/home/mozerpol/Downloads/Vunit/UART/waveforms.do"
    puts "Sourcing file ${file_name} from modelsim.init_file.gui"
    if {[catch {source ${file_name}} error_msg]} {
        puts "Sourcing ${file_name} failed"
        puts ${error_msg}
        return true
    }
    return 0
}
if {![vunit_load]} {
  vunit_user_init
  vunit_help
}
