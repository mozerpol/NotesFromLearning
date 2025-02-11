from pathlib import Path
from vunit import VUnit
import random


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


# Assign values to generic in test bench
# One value
'''
tb_dut = tb_lib.test_bench("tb_example")
tb_dut.add_config(
    name=f"G_GENERATE_TB.G_NUMBER_1_TB.G_NUMBER_2_TB",
    generics=dict(G_GENERATE_TB=3, G_NUMBER_1_TB=4, G_NUMBER_2_TB=5)
)
'''

# Many random values, each value is a separate test case (it's obvious, can't
# change generic during one test). If there are two identical random numbers
# then the test ends with an error, there can't be two identical generic numbers
generate_list = [0, 1, 2, 3]
number_1_list = [3, 10, 7, 4]
number_2_list = [14, 2, 5, 4]

tb_dut = tb_lib.test_bench("tb_example")
for i in range(len(generate_list)):
    tb_dut.add_config(
        name=f"G_GENERATE_TB={generate_list[i]}.G_NUMBER_1_TB= \
        {number_1_list[i]}.G_NUMBER_2_TB={number_2_list[i]}",
        generics=dict(G_GENERATE_TB={generate_list[i]}, G_NUMBER_1_TB= \
        {number_1_list[i]}, G_NUMBER_2_TB={number_2_list[i]})
    )


# Run test
VU.main()
