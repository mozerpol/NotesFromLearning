from pathlib import Path
from vunit import VUnit


# Create Vunit instance
VU = VUnit.from_argv(compile_builtins=False)
# Add VUnit VHDL builtin libraries
VU.add_vhdl_builtins()


# Create and_gate library
and_gate_lib = VU.add_library("and_gate_lib")
# Add and_gate source files
and_gate_lib.add_source_files([
  "And_gate/and_gate_pkg.vhdl",
  "And_gate/and_gate_design.vhdl"
  ])


# Create or_gate library
or_gate_lib = VU.add_library("or_gate_lib")
# Add or_gate source files
or_gate_lib.add_source_files([
  "Or_gate/or_gate_pkg.vhdl",
  "Or_gate/or_gate_design.vhdl"
  ])


# Create testbench library
tb_lib = VU.add_library("tb_lib")
# Add testbench source files to tb_lib
tb_lib.add_source_files([
  "All_gates/all_gates_pkg.vhdl",
  "All_gates/all_gates_design.vhdl",
  "All_gates/all_gates_tb.vhdl"
  ])


# Compilation options (vcom command)
# -2008       -  use VHDL 2008
# -quiet      -  disable 'loading' messages
# +cover=bcs  -  coverage report
VU.set_compile_option("modelsim.vcom_flags", ["-2008", "-quiet", "+cover=bcs"])


# Simulation options (vsim command)
# TCL-file is sourced after the design has been loaded in the GUI. For example
# this can be used to configure the waveform viewer.
VU.set_sim_option("modelsim.init_file.gui", "waveforms.do")
# Extra arguments passed to vsim when loading the design in GUI mode.
# -voptargs=+acc  -  apply full visibility to all modules, Questa need this.
VU.set_sim_option("modelsim.vsim_flags.gui", ["-voptargs=+acc"])
# Enable coverage
VU.set_sim_option("enable_coverage", True)


# Run test
VU.main()
