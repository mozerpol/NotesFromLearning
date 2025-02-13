source "/home/mozerpol/Downloads/Vunit/UART/vunit_out/test_output/tb_lib.tb_example.G_BAUD_TB.G_FREQUENCY_HZ_TB.test_send_one_byte_695b0daa8a06132bcd63459a62d5d0fbaa2eb1b2/modelsim/common.do"
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
