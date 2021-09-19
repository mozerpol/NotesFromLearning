# 50 MHz 
create_clock -name {clk} -period 125.000 -waveform { 0.000 62.500 } [get_ports { clk }]

set_input_delay -clock { clk } 2 [get_ports {rst}]
set_output_delay -clock { clk } 2 [get_ports {led[0] led[1] led[2] led[3]}]
