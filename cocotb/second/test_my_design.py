# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import cocotb
from cocotb.triggers import FallingEdge, Timer, RisingEdge


async def generate_clock(dut):
    """Generate clock pulses."""

    for cycle in range(10):
        dut.i_clk.value = 0
        await Timer(1, units="ns")
        dut.i_clk.value = 1
        await Timer(1, units="ns")


async def first_test(dut):
    cocotb.log.info("Start the first test")

    dut.i_select.value = 0
    dut.i_data.value   = 0
    await RisingEdge(dut.i_clk)    # wait for rising edge
    await RisingEdge(dut.i_clk)    # wait for rising edge
    assert dut.o_data.value == 1, "o_data is not 1!"
    assert dut.internal_signal.value == 0, "internal_signal is not 0!"

    dut.i_select.value = 1
    dut.i_data.value   = 1
    await RisingEdge(dut.i_clk)    # wait for rising edge
    await RisingEdge(dut.i_clk)    # wait for rising edge
    assert dut.o_data.value == 2, "o_data is not 2!"
    assert dut.internal_signal.value == 0, "internal_signal is not 0!"

    dut.i_select.value = 2
    dut.i_data.value   = 2
    await RisingEdge(dut.i_clk)    # wait for rising edge
    await RisingEdge(dut.i_clk)    # wait for rising edge
    assert dut.o_data.value == 4, "o_data is not 4!"
    assert dut.internal_signal.value == 0, "internal_signal is not 0!"

    dut.i_select.value = 3
    dut.i_data.value   = 4
    await RisingEdge(dut.i_clk)    # wait for rising edge
    await RisingEdge(dut.i_clk)    # wait for rising edge
    assert dut.o_data.value == 8, "o_data is not 8!"
    assert dut.internal_signal.value == 1, "internal_signal is not 1!"


@cocotb.test()
async def tb(dut):
    # Run two coroutines concurrently
    await cocotb.start(generate_clock(dut))
    await cocotb.start(first_test(dut))
    await Timer(20, units="ns") # End after 20 ns
