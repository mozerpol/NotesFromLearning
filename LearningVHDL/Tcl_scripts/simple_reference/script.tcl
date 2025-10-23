set library_name              "and_lib"
set testbench_entity_name     "testbench"

# Delete ModelSim trash
file delete -force work $library_name transcript vsim.wlf

# Create library
vlib $library_name

# Design
vcom -2008 -cover bcs -quiet -work $library_name design.vhdl

# Testbench
vcom -2008 -cover bcs -quiet -work $library_name test.vhdl

# Load waveforms
vsim -coverage -voptargs=+acc $library_name.$testbench_entity_name
view wave -undock -title wave_TOP
do waveforms.do

# Run tests
echo "----> Run tests"
run -all
