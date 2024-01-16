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

8. Explain the concept of pipelining and how it can improve performance in an
FPGA design.
Pipelining is a technique to improve the performance of a system by breaking
down a complex computation into smaller, sequential stages. In pipelining, the
input data is divided into multiple sub-tasks, which are then processed in a
series of pipeline stages. Each pipeline stage performs a specific operation on
the data and passes it to the next stage.

9. What is the purpose of a constraint file in FPGA design? Give examples of
common constraints.
Constraint file is a text file that specifies certain requirements and
limitations for the design implementation. These constraints are used by the
synthesis tools to guide the physical implementation on the FPGA.
Examples of common constraints in an FPGA:
- Timing Constraints: These define the required timing characteristics of the
design, such as maximum clock frequency, setup and hold times for registers.
- Pin Placement Constraints: These specify the physical locations of the input
and output pins on the FPGA device
- Resource Constraints: These limitations specify the usage of specific FPGA
resources, such as DSP blocks, memory blocks, and lookup tables (LUTs)

10. How do you debug and troubleshoot issues in an FPGA design?
- Use a simulator to validate the functionality of design, simulate different
test cases
- Review RTL code for any syntax errors, incorrect connections, or logic issues
- Ask on forum

11. What is an FPGA and how does it differ from other digital electronic devices?
FPGA - it's a type of integrated circuit that can be reconfigured to perform
custom digital functions and perform parallel processing tasks.
- Flexibility - FPGAs can be reprogrammed or reconfigured to implement different
digital circuits, functions, or systems.  
- Parallel Processing - contain a large number of configurable logic blocks 
(CLBs) and a mesh of programmable interconnects. This architecture enables 
simultaneous execution of multiple operations in parallel,
- Hardware-based Implementation - unlike (pol. w odróżnieniu) traditional 
software-based approaches, FPGAs allow for the implementation of hardware-based 
solutions. By mapping algorithms or designs directly into the FPGA's logic 
blocks and interconnects

12. Explain the steps involved in the FPGA design flow.
FPGA design flow:
- Design Entry: This is the initial step where you define and describe your 
design using a hardware description language (HDL). It involves creating a 
high-level representation of the desired functionality and behavior of your 
design.
- Simulation: After the design entry, simulate a design using a  simulation tool. 
The simulation allows to verify the correctness and functionality of a design 
before proceeding further. 
- Synthesis: In this step, the HDL code is transformed into a gate-level
representation. The synthesis tool translates design description into a netlist 
comprising logic gates and registers.
- Floorplanning: it is the process of assigning physical locations on the FPGA 
for each functional unit and interconnect. It involves deciding the optimal 
placement of logic elements, I/O pins, and other components to minimize delays 
and power consumption.
- Place and Route: In this step, the placement and routing tools generate a 
detailed physical layout by determining the optimal routing paths for 
interconnects. The tools consider factors like timing constraints, signal 
integrity, and resource utilization. The output of this step is a bitstream
file that represents the programmed FPGA.
- Bitstream Generation: The bitstream file contains the binary representation of
design that can be loaded onto the FPGA.
- Verification: After configuration, you need to verify that the implemented
design performs as expected on the FPGA. This involves testing the design using 
test cases and verifying the output against expected results. Verification can 
include functional, timing, and performance analysis.

13. What is the difference between synchronous and asynchronous design in FPGAs?
"Synchronous" and "asynchronous" refer to different approaches for handling the 
timing behavior of signals within the design.
Synchronous Design:
- Timing Dependencies: Synchronous design relies on a clock signal to coordinate
and synchronize the behavior of different parts of the design. All signals and 
operations within a design are tied to the same clock domain. 
- Clock Signal: A global clock signal is used as a reference point for 
triggering the execution of all operations in the design.
- Registers: Synchronous designs extensively use flip-flops or registers to 
store and synchronize signals at specific points in time.
- Advantages: Synchronous designs offer predictable timing behavior, easier 
debugging, and better control over signal integrity and synchronization. 
Asynchronous Design:
- Timing Independence: Asynchronous design does not rely on a global clock 
signal. Instead, it allows signals and operations to be processed independently 
based on their own local timing.
- Handshake Protocols: In asynchronous designs, handshake protocols or other
 signaling methods are used to communicate between sequential stages without 
 relying on a shared clock. These protocols define the rules for exchanging data 
 and ensuring proper synchronization.
- Hazard Considerations: Asynchronous designs need to consider potential hazards 
such as metastability and data contention that can arise due to timing variations.
-     Advantages: Asynchronous designs offer flexibility in terms of timing 
independence, power efficiency, and reduced clock skew. They can be useful in 
low-power designs, in scenarios where clock distribution is challenging, or in 
cases where data is received asynchronously from external sources.
It's important to note that synchronous design is more commonly used in FPGA 
designs due to its simplicity, ease of implementation, and better control over 
timing. 

14. How do you implement a flip-flop in an FPGA design?
- Select Flip-Flop Type: choose the type of flip-flop that suits to design 
requirements. FPGAs typically offer different types, such as D flip-flops, 
JK flip-flops, or T flip-flops.
- Instantiate Flip-Flop: In hardware description language (HDL) code and 
instantiate the flip-flop by declaring a variable or flip-flop object based on 
the chosen type. For example, in VHDL for a D flip-flop:
```VHDL
architecture rtl of your_module is
    signal d: std_logic;
    signal q: std_logic;
begin
    your_flipflop: process(clk)
    begin
        if rising_edge(clk) then
            q <= d;
        end if;
    end process;
end architecture;
```

15. What is the purpose of a look-up table (LUT) in an FPGA?
A look-up table (LUT) in an FPGA serves as a fundamental building block for 
implementing digital logic functions. It is a configurable memory element that 
stores pre-defined logic values and outputs the corresponding result based on 
the input combination. The purpose of a LUT is to provide a flexible and 
efficient way to implement complex logic functions within an FPGA, enabling the 
device to perform various tasks such as data processing, arithmetic operations, 
and control functions.

16. How do you implement a multiplexer in an FPGA design?
A general approach:
- Define the inputs and select lines: Determine the number of inputs and select 
lines required for your multiplexer. For example, if you have 4 inputs, you'll 
need 2 select lines.
- Create a truth table
- Implement the logic expressions: Use the logic elements available in the FPGA,
such as LUTs, to implement the logic expressions derived from the truth table.
- Synthesize and program: Use FPGA synthesis tools to convert your design into a
 configuration file compatible with the specific FPGA device you are using.
 
17. Explain the concept of pipelining in FPGA designs and its advantages.
Pipelining in FPGA designs is a technique used to improve the performance of 
digital circuits by breaking down the sequential execution of operations into a 
series of stages. Each stage performs a specific part of the overall computation,
and the output of one stage becomes the input for the next stage. This allows 
for parallel processing of multiple data elements, resulting in increased
efficiency and speed.
Advantages:
- Increased throughput: Pipelining enables the processing of multiple data 
elements simultaneously
- Resource utilization: Pipelining can help optimize the utilization of FPGA 
resources. By breaking down complex operations into smaller stages, it becomes 
easier to map the design onto the available logic elements and routing resources
of the FPGA
- Clock frequency improvement: Pipelining can enable higher clock frequencies by
reducing the critical path delay.

