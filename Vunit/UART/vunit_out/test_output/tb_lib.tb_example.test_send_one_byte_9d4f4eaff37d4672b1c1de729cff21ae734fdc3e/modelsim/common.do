
proc vunit_help {} {
    puts {List of VUnit commands:}
    puts {vunit_help}
    puts {  - Prints this help}
    puts {vunit_load [vsim_extra_args]}
    puts {  - Load design with correct generics for the test}
    puts {  - Optional first argument are passed as extra flags to vsim}
    puts {vunit_user_init}
    puts {  - Re-runs the user defined init file}
    puts {vunit_run}
    puts {  - Run test, must do vunit_load first}
    puts {vunit_compile}
    puts {  - Recompiles the source files}
    puts {vunit_restart}
    puts {  - Recompiles the source files}
    puts {  - and re-runs the simulation if the compile was successful}
}

proc vunit_run {} {
    if {[catch {_vunit_run} failed_or_err]} {
        echo $failed_or_err
        return true;
    }

    if {![is_test_suite_done]} {
        echo
        echo "Test Run Failed!"
        echo
        _vunit_run_failure;
        return true;
    }

    return false;
}

proc _vunit_source_init_files_after_load {} {
    return 0
}
proc _vunit_source_init_files_before_run {} {
    return 0
}

proc vunit_load {{vsim_extra_args ""}} {
    set vsim_failed [catch {
        eval vsim ${vsim_extra_args} {-modelsimini /home/mozerpol/Downloads/Vunit/UART/vunit_out/modelsim/modelsim.ini -wlf {/home/mozerpol/Downloads/Vunit/UART/vunit_out/test_output/tb_lib.tb_example.test_send_one_byte_9d4f4eaff37d4672b1c1de729cff21ae734fdc3e/modelsim/vsim.wlf} -quiet -t ps -onfinish stop  -g/tb_example/runner_cfg={"active python runner : true,enabled_test_cases : test_send_one_byte,output path : /home/mozerpol/Downloads/Vunit/UART/vunit_out/test_output/tb_lib.tb_example.test_send_one_byte_9d4f4eaff37d4672b1c1de729cff21ae734fdc3e/,tb path : /home/mozerpol/Downloads/Vunit/UART/,use_color : false"} tb_lib.tb_example(tb) -coverage -voptargs=+acc -L vunit_lib -L osvvm -L tb_lib}
    }]

    if {${vsim_failed}} {
       echo Command 'vsim ${vsim_extra_args} -modelsimini /home/mozerpol/Downloads/Vunit/UART/vunit_out/modelsim/modelsim.ini -wlf {/home/mozerpol/Downloads/Vunit/UART/vunit_out/test_output/tb_lib.tb_example.test_send_one_byte_9d4f4eaff37d4672b1c1de729cff21ae734fdc3e/modelsim/vsim.wlf} -quiet -t ps -onfinish stop  -g/tb_example/runner_cfg={"active python runner : true,enabled_test_cases : test_send_one_byte,output path : /home/mozerpol/Downloads/Vunit/UART/vunit_out/test_output/tb_lib.tb_example.test_send_one_byte_9d4f4eaff37d4672b1c1de729cff21ae734fdc3e/,tb path : /home/mozerpol/Downloads/Vunit/UART/,use_color : false"} tb_lib.tb_example(tb) -coverage -voptargs=+acc -L vunit_lib -L osvvm -L tb_lib' failed
       echo Bad flag from vsim_extra_args?
       return true
    }

    if {[_vunit_source_init_files_after_load]} {
        return true
    }

    global BreakOnAssertion
    set BreakOnAssertion 2

    global NumericStdNoWarnings
    set NumericStdNoWarnings 0

    global StdArithNoWarnings
    set StdArithNoWarnings 0

    coverage save -onexit -testname {tb_lib.tb_example.test_send_one_byte} -assert -directive -cvg -codeAll {/home/mozerpol/Downloads/Vunit/UART/vunit_out/test_output/tb_lib.tb_example.test_send_one_byte_9d4f4eaff37d4672b1c1de729cff21ae734fdc3e/modelsim/coverage.ucdb}
    return false
}

proc is_test_suite_done {} {
    set fd [open "/home/mozerpol/Downloads/Vunit/UART/vunit_out/test_output/tb_lib.tb_example.test_send_one_byte_9d4f4eaff37d4672b1c1de729cff21ae734fdc3e/vunit_results" "r"]
    set contents [read $fd]
    close $fd
    set lines [split $contents "
"]
    foreach line $lines {
        if {$line=="test_suite_done"} {
           return true;
        }
    }

    return false;
}


proc _vunit_run_failure {} {
    catch {
        # tb command can fail when error comes from pli
        echo "Stack trace result from 'tb' command"
        echo [tb]
        echo
        echo "Surrounding code from 'see' command"
        echo [see]
    }
}

proc _vunit_run {} {
    if {[_vunit_source_init_files_before_run]} {
        return true
    }

    proc on_break {} {
        resume
    }
    onbreak {on_break}

    run -all
}

proc _vunit_sim_restart {} {
    restart -f
}

proc vunit_compile {} {
    set cmd_show {/usr/bin/python3 -u run.py --compile -qg}
    puts "Re-compiling using command ${cmd_show}"

    set chan [open |[list {/usr/bin/python3} {-u} {-c} {import sys;import subprocess;exit(subprocess.call(['/usr/bin/python3', '-u', 'run.py', '--compile', '-qg'], cwd='/home/mozerpol/Downloads/Vunit/UART', bufsize=0, universal_newlines=True, stdout=sys.stdout, stderr=sys.stdout))}] r]

    while {[gets $chan line] >= 0} {
        puts $line
    }

    if {[catch {close $chan} error_msg]} {
        puts "Re-compile failed"
        puts ${error_msg}
        return true
    } else {
        puts "Re-compile finished"
        return false
    }
}

proc vunit_restart {} {
    if {![vunit_compile]} {
        _vunit_sim_restart
        vunit_run
    }
}
