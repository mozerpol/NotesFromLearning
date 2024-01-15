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

3. Explain the concept of clock skew and how it can affect FPGA designs.
clock skew -

Add screenshot

4. How do you implement a synchronous reset in an FPGA design?
Synchronous reset - it's a circuit which always dependent on clock pulse input.
It can assert and desert a flip-flop synchronously.
VHDL code:
```VHDL
if Rising_edge(clock) then
  if Reset = '0' then
    q <= '0';
  else
    q <= data;
  end if;
end if;
```
Add screenshot

5. What is the difference between a flip-flop and a latch? When would you use each?
A flip-flop and a latch are both fundamental building blocks used in digital
logic circuits to store and manipulate binary data. A flip-flop is a circuit
that has a clock input and can store digital information, while a latch is a
circuit that can store data as long as its enable input is active, without the
need for a clock signal.
Latches are commonly used in applications where the circuit requires continuous
operation based on the input condition.
Flip-flops are widely used in synchronous digital systems, especially for
designing sequential circuits like counters or shift registers especially when
precise timing control is required.

Add screenshot latch vs flip-flop

6. Describe the process of synthesis and how it is used in FPGA design.
Synthesis - is the process of converting a high-level Hardware Description
Language (HDL) code into a low-level netlist of logical gates and flip-flops
(a configuration file that can be loaded onto the FPGA).

7. How do you optimize power consumption in an FPGA design?
There are several techniques:
- minimizing the use of power-hungry components such as high-frequency clocks.
Running the design at a lower frequency reduces power consumption.
- optimize the routing to minimize long interconnects which consume more power.
- clock gating techniques - disable unused parts of the design and reduce
switching activities
- voltage scaling - lowering the supply voltage reduces power consumption.
