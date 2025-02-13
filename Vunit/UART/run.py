from pathlib import Path
from vunit import VUnit


# Create Vunit instance
VU = VUnit.from_argv(compile_builtins=False)
# Add VUnit VHDL builtin libraries
VU.add_vhdl_builtins()
# UART can be check thankts to verification components, additionally in test
# bench context shoudl be added
VU.add_verification_components()


# Create testbench library
tb_lib = VU.add_library("tb_lib")
# Add testbench source files to tb_lib
tb_lib.add_source_files(["*.vhdl"])


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
tb_dut = tb_lib.test_bench("tb_example")
tb_dut.add_config(
    name=f"G_BAUD_TB.G_FREQUENCY_HZ_TB",
    generics=dict(G_BAUD_TB=115200, G_FREQUENCY_HZ_TB=50000000)
    )


# Run test
VU.main()
