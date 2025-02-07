from pathlib import Path
from vunit import VUnit


# ROOT
ROOT = Path(__file__).resolve().parent


# Sources path for DUT
DUT_PATH = ROOT


# Sources path for TB
TEST_PATH = ROOT


# Create Vunit instance
VU = VUnit.from_argv(compile_builtins=False)
# Add VUnit VHDL builtin libraries
VU.add_vhdl_builtins()


# Create testbench library
tb_lib = VU.add_library("tb_lib")
# Add testbench source files to tb_lib
tb_lib.add_source_files([TEST_PATH / "*.vhdl"])


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
