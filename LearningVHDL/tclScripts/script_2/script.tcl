########################################
# SET LIBRARY NAME
set library_name              "and_lib"
# SET TESTBENCH ENTITY
set testbench_entity_name     "testbench"
########################################

proc s_show_description {} {
   echo "\n********************************************************************************************"
   echo "* Select testcase                                                                          *"
   echo "********************************************************************************************"
   echo "* Usage: s_run_tb { <testcase number> }                                                    *"
   echo "* E.g. s_run_tb { 00 } or s_run_tb { 00 10 01 } or s_run_tb { 10 11 11 00 } or ...         *"
   echo "********************************************************************************************"
   echo "*    1. 00                : description                                                    *"
   echo "*    2. 01                : description                                                    *"
   echo "*    3. 10                : description                                                    *"
   echo "*    4. 11                : description                                                    *"
   echo "********************************************************************************************\n"
}

proc s_clear {} {
   # Delete ModelSim trash
   global library_name
   file delete -force work $library_name transcript vsim.wlf
}

proc s_create_lib_main {} {
   # Create library
   global library_name
   vlib $library_name
}

proc s_comp_design_main {} {
   # Compile design
   global library_name
   vcom -2008 -cover bcs -quiet -work $library_name design.vhdl
}

proc s_comp_test_main {} {
   # Compile testbench
   global library_name
   vcom -2008 -cover bcs -quiet -work $library_name tb.vhdl
}

proc s_load_waves {} {
   # Load waveforms
   global library_name testbench_entity_name
   vsim -coverage -voptargs=+acc $library_name.$testbench_entity_name
   view wave -undock -title wave_TOP
   do waveforms.do
}

proc s_start_sim {} {
   # Run tests
   echo "----> Run tests"
   run -all
}

proc s_run_tb {testcase} {
   # Compile selected testcase and connect with header
   set filesrc    header.vhdl
   set fileres    tb.vhdl

   set pattern    "! Insert Testcase Here !"
   set src        [open $filesrc r]
   set res        [open $fileres w]

   set srcData    [read $src]
   set lines      [split $srcData \n]

   foreach line $lines {
      if { [regexp $pattern $line ] } {
         foreach i $testcase {
            set tc     [open testcase_$i.vhdl r]
            set tcData [read $tc]
            puts       $res $tcData
            close      $tc
         }
      } else {
         puts     $res $line
      }
   }

   close    $src
   close    $res

   s_clear
   s_create_lib_main
   s_comp_design_main
   s_comp_test_main
   s_load_waves
   s_start_sim
}

s_show_description
s_clear
s_create_lib_main
s_comp_design_main
# s_run_tb {00 01 10}
