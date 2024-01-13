# Questions and answers to basic questions that I think you need to know
_____________

## Table of contents <a name="tof"></a>
1. [1. FPGA](#1)

================================================================================
                                    FPGA <a name="1"></a>
================================================================================
1. What is an FPGA and how does it differ from a microcontroller or ASIC?
- FPGA - it's a type of integrated circuit that can be reconfigured to perform
custom digital functions and perform parallel processing tasks.
- ASIC - is an integrated circuit customized for a particular use. For example,
the CPU inside your phone is an ASIC.
The biggest differences: ASIC can't be reconfigured, ASIC fabricated using the
same process node can run at much higher frequency than FPGAs.
- Microcontrollers are typically programmed using high-level languages like C or
C++. Microcontrollers are commonly used in applications that require low-power
consumption and small-scale computing.

2. What is the difference between a combinational and sequential circuit?
Give examples of each.
- Combinational circuit - can't remember the previous states, the output is 
determined by the current input values. Examples: Adder, Subtractor, Decoder,
Encoder, Multiplexer, and De-multiplexer.
- Sequential circuit - can remember the previous states, the output is
determined by the current input values and previous states. Examples: flip-flops,
counters, shift registers, RAM.
