# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# Available simulators: icarus, modelsim, ghdl, xcelium, ius, questa
SIM ?= questa

# Supported languages: verilog, vhdl
TOPLEVEL_LANG ?= vhdl

# Set this to 1 to enable the GUI mode in the simulator (if supported), in my
# case it's only to see waveforms
GUI = 1

# A list of the VHDL source files to include, for verilog change to
# VERILOG_SOURCES. Remember the files order!
VHDL_SOURCES += $(PWD)/my_design_top.vhd

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = my_design

# MODULE is the basename of the Python test file
MODULE = test_my_design

# Include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
