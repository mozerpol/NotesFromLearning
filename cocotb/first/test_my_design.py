# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def my_first_test(dut):
    """Try accessing the design."""

    for cycle in range(10):
        dut.clk.value = 0
        await Timer(1, units="ns")
        dut.clk.value = 1
        await Timer(1, units="ns")

    # Print out the signal values
    dut._log.info("my_signal_1 is %s", dut.my_signal_1.value)
    dut._log.info("my_signal_2 is %s", dut.my_signal_2.value)
    # Test if a condition in your code returns True
    assert dut.my_signal_1.value[0] == 1, "my_signal_1[0] is not 1!"
    assert dut.my_signal_2.value[0] == 0, "my_signal_2[0] is not 0!"


@cocotb.test()
async def my_second_test(dut):
    """Try accessing the design."""

    await Timer(20, units="ns")  # wait a bit

    # Print out the signal values
    dut._log.info("my_signal_1 is %s", dut.my_signal_1.value)
    dut._log.info("my_signal_2 is %s", dut.my_signal_2.value)
    # Test if a condition in your code returns True
    assert dut.my_signal_1.value[0] == 1, "my_signal_1[0] is not 1!"
    assert dut.my_signal_2.value[0] == 1, "my_signal_2[0] is not 1!"
