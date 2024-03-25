# Questions and answers
Questions and answers to basic questions that I think you need to know
_____________

## Table of contents <a name="tof"></a>
1. [FPGA](#1)
    1. [What is an FPGA and how does it differ from a microcontroller or ASIC?](#11)
    2. [What is the difference between a combinational and sequential circuit?](#12)
    3. [Explain the concept of clock skew and how it can affect FPGA designs.](#13)
    4. [How do you implement a synchronous reset in an FPGA design?](#14)
    5. [What is the difference between a flip-flop and a latch? When would you use each?](#15)
    6. [Describe the process of synthesis and how it is used in FPGA design.](#16)
    7. [How do you optimize power consumption in an FPGA design?](#17)
    8. [Explain the concept of pipelining and how it can improve performance in an FPGA design.](#18)
    9. [What is the purpose of a constraint file in FPGA design? Give examples of common constraints.](#19)
    10. [How do you debug and troubleshoot issues in an FPGA design?](#110)
    11. [What is an FPGA and how does it differ from other digital electronic devices?](#111)
    12. [Explain the steps involved in the FPGA design flow.](#112)
    13. [What is the difference between synchronous and asynchronous design in FPGAs?](#113)
    14. [How do you implement a flip-flop in an FPGA design?](#114)
    15. [What is the purpose of a look-up table (LUT) in an FPGA?](#115)
    16. [How do you implement a multiplexer in an FPGA design?](#116)
    17. [How do you handle timing constraints (pol. radzić sobie z ograniczeniami czasowymi) in FPGA designs?](#117)
    18. [Describe the basic architecture of an FPGA.](#118)
    19. [Describe the process of place and route in FPGA design.](#119)
    20. [What are the advantages and disadvantages of using an FPGA in a design?](#120)
    21. [How do you handle clock domain crossing in an FPGA design?](#121)
    22. [What are some common challenges and considerations when designing for FPGAs?](#122)
2. [VHDL](#2)

## FPGA <a name="1"></a>

### 1. What is an FPGA and how does it differ from a microcontroller or ASIC? <a name="11"></a> [UP↑](#tof)
- **FPGA** - it's a type of integrated circuit that can be reconfigured to
perform custom digital functions and perform parallel processing tasks.
- **ASIC** - is an integrated circuit customized for a particular use. It is
designed for a specific application or task. It is typically customized for a
particular purpose, such as a specific algorithm or function.
- **Microcontroller** - is a general-purpose device that combines a
microprocessor core, memory, and peripheral devices. It is designed to control
and execute tasks based on code instructions.
- **The biggest differences**: ASIC can't be reconfigured, ASIC fabricated using
the same process node can run at much higher frequency than FPGAs.
Microcontroller offers a higher level of flexibility than ASICs.

### 2. What is the difference between a combinational and sequential circuit? <a name="12"></a> [UP↑](#tof)
- **Combinational circuit** - can't remember the previous states, the output is
determined by the current input values. Examples: Adder, Subtractor, Decoder,
Encoder, Multiplexer, and De-multiplexer.
- **Sequential circuit** - can remember the previous states, the output is
determined by the current input values and previous states. Examples: flip-flops,
counters, shift registers, RAM.

### 3. Explain the concept of clock skew and how it can affect FPGA designs. <a name="13"></a> [UP↑](#tof)
**Clock skew** (pol. *Przesunięcie zegara*) - it's in synchronous digital
circuit systems (such as computer systems) in which the same sourced clock
signal arrives at different components at different times due to gate or, in
more advanced semiconductor
technology, wire signal propagation delay. <br/>
One problem is caused when the clock reaches the first register and the clock
signal towards the second register travels slower than output of the first
register into the second register - the output of the first register reaches the
second register input faster and therefore is clocked replacing the initial data
on the second register, or maybe destroying the integrity of the latched data.
This is called a **hold violation** because the previous data is not held long
enough at the destination flip-flop to be properly clocked through.

![clock_skew](https://github.com/mozerpol/NotesFromLearning/assets/43972902/c7acad71-7e15-499a-9d57-98810e82977f)

### 4. How do you implement a synchronous reset in an FPGA design? <a name="14"></a> [UP↑](#tof)
**Synchronous reset** - it's a circuit which always dependent on clock pulse
input. It can assert and desert a flip-flop synchronously.
VHDL code:
```VHDL
if rising_edge(clock) then
  if reset = '0' then
    q <= '0';
  else
    q <= data;
  end if;
end if;
```

### 5. What is the difference between a flip-flop and a latch? When would you use each? <a name="15"></a> [UP↑](#tof)
A flip-flop and a latch are both fundamental building blocks used in digital
logic circuits to store and manipulate binary data. <br/>
A **flip-flop**  is a circuit
that has a clock input and can store digital information, while a **latch** is a
circuit that can store data as long as its enable input is active, without the
need for a clock signal.
Latches are commonly used in applications where the circuit requires continuous
operation based on the input condition.
Flip-flops are widely used in synchronous digital systems, especially for
designing sequential circuits like counters or shift registers especially when
precise timing control is required.

![latch_vs_ff](https://github.com/mozerpol/NotesFromLearning/assets/43972902/b9909205-0e0f-4ea2-8263-42b8425d0b22)

### 6. Describe the process of synthesis and how it is used in FPGA design. <a name="16"></a> [UP↑](#tof)
**Synthesis** - is the process of converting a high-level Hardware Description
Language (HDL) code into a low-level netlist of logical gates and flip-flops
(a configuration file that can be loaded onto the FPGA).

### 7. How do you optimize power consumption in an FPGA design? <a name="17"></a> [UP↑](#tof)
There are several techniques:
- minimizing the use of power-hungry components such as high-frequency clocks.
Running the design at a lower frequency reduces power consumption.
- optimize the routing to minimize long interconnects which consume more power.
- clock gating techniques - disable unused parts of the design and reduce
switching activities
- voltage scaling - lowering the supply voltage reduces power consumption.

Advantages:
- Pipelining enables the processing of multiple data elements simultaneously
- Pipelining can help optimize the utilization of FPGA
resources. By breaking down complex operations into smaller stages, it becomes
easier to map the design onto the available logic elements and routing resources
of the FPGA
- Pipelining can enable higher clock frequencies by
reducing the critical path delay.

### 8. Explain the concept of pipelining and how it can improve performance in an FPGA design. <a name="18"></a> [UP↑](#tof)
Pipelining is a technique to improve the performance of a system by breaking
down a complex computation into smaller, sequential stages. In pipelining, the
input data is divided into multiple sub-tasks, which are then processed in a
series of pipeline stages. Each pipeline stage performs a specific operation on
the data and passes it to the next stage.

### 9. What is the purpose of a constraint file in FPGA design? Give examples of common constraints. <a name="19"></a> [UP↑](#tof)
Constraint file is a text file that specifies certain requirements and
limitations for the design implementation. These constraints are used by the
synthesis tools to guide the physical implementation on the FPGA. <br/>
Examples of common constraints in an FPGA:
- **Timing Constraints** - define the required timing characteristics of the
design, such as maximum clock frequency, setup and hold times for registers.
- **Pin Placement Constraints** - specify the physical locations of the input
and output pins on the FPGA device
- **Resource Constraints** these limitations specify the usage of specific FPGA
resources, such as DSP blocks, memory blocks, and lookup tables (LUTs)

### 10. How do you debug and troubleshoot issues in an FPGA design? <a name="110"></a> [UP↑](#tof)
- Use a simulator to validate the functionality of design, simulate different
test cases,
- Review RTL code for any syntax errors, incorrect connections, or logic issues,
- Ask on forum.

### 11. What is an FPGA and how does it differ from other digital electronic devices? <a name="111"></a> [UP↑](#tof)
**FPGA** - it's a type of integrated circuit that can be reconfigured to perform
custom digital functions and perform parallel processing tasks. Characteristics:
- Flexibility - FPGAs can be reprogrammed or reconfigured to implement different
digital circuits, functions, or systems.
- Parallel Processing - contain a large number of configurable logic blocks
(CLBs) and a mesh of programmable interconnects. This architecture enables
simultaneous execution of multiple operations in parallel,
- Hardware-based Implementation - unlike (pol. *w odróżnieniu*) traditional
software-based approaches, FPGAs allow for the implementation of hardware-based
solutions. By mapping algorithms or designs directly into the FPGA's logic
blocks and interconnects.

### 12. Explain the steps involved in the FPGA design flow. <a name="112"></a> [UP↑](#tof)
**FPGA design flow**:
- Design Entry: <br/>
This is the initial step where you define and describe your
design using a hardware description language. It involves creating a
high-level representation of the desired functionality and behavior of your
design.
- Simulation: <br/>
After the design entry, simulate a design using a simulation tool.
The simulation allows to verify the correctness and functionality of a design
before proceeding further.
- Synthesis: <br/>
In this step, the HDL code is transformed into a gate-level
representation. The synthesis tool translates design description into a netlist
comprising logic gates and registers.
- Floorplanning: <br/>
It is the process of assigning physical locations on the FPGA
for each functional unit and interconnect. It involves deciding the optimal
placement of logic elements, I/O pins, and other components to minimize delays
and power consumption.
- Place and Route: <br/>
In this step, the placement and routing tools generate a
detailed physical layout by determining the optimal routing paths for
interconnects. The tools consider factors like timing constraints, signal
integrity, and resource utilization. The output of this step is a bitstream
file that represents the programmed FPGA.
- Verification: <br/>
After configuration, you need to verify that the implemented
design performs as expected on the FPGA. This involves testing the design using
test cases and verifying the output against expected results. Verification can
include functional, timing, and performance analysis.

### 13. What is the difference between synchronous and asynchronous design in FPGAs? <a name="113"></a> [UP↑](#tof)
"Synchronous" and "asynchronous" refer to different approaches for handling the
timing behavior of signals within the design. <br/>
**Synchronous Design**:
- Timing Dependencies: <br/>
Synchronous design relies on a clock signal to coordinate
and synchronize the behavior of different parts of the design. All signals and
operations within a design are tied to the same clock domain.
- Clock Signal: <br/>
A global clock signal is used as a reference point for
triggering the execution of all operations in the design.
- Registers: <br/>
Synchronous designs extensively use flip-flops or registers to
store and synchronize signals at specific points in time.
- Advantages: <br/>
Synchronous designs offer predictable timing behavior, easier
debugging, and better control over signal integrity and synchronization.

**Asynchronous Design**:
- Timing Independence: <br/>
Asynchronous design does not rely on a global clock
signal. Instead, it allows signals and operations to be processed independently
based on their own local timing.
- Handshake Protocols: <br/>
In asynchronous designs, handshake protocols or other
signaling methods are used to communicate between sequential stages without
relying on a shared clock. These protocols define the rules for exchanging data
and ensuring proper synchronization.
- Hazard Considerations: <br/>
Asynchronous designs need to consider potential hazards
such as metastability and data contention that can arise due to timing variations.
- Advantages: <br/>
Asynchronous designs offer flexibility in terms of timing
independence, power efficiency, and reduced clock skew. They can be useful in
low-power designs, in scenarios where where data is received asynchronously from
external sources.

It's important to note that synchronous design is more commonly used in FPGA
designs due to its simplicity, ease of implementation, and better control over
timing.

### 14. How do you implement a flip-flop in an FPGA design? <a name="114"></a> [UP↑](#tof)
1. Choose the type of flip-flop that suits to design
requirements.
2. In hardware description language code and
instantiate the flip-flop by declaring a variable based on
the chosen type. For example, in VHDL for a D flip-flop: <br/>
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

### 15. What is the purpose of a look-up table (LUT) in an FPGA? <a name="115"></a> [UP↑](#tof)
A look-up table in an FPGA serves as a fundamental building block for
implementing digital logic functions. The purpose of a LUT is to provide a flexible and
efficient way to implement complex logic functions within an FPGA, enabling the
device to perform various tasks such as data processing, arithmetic operations,
and control functions.

### 16. How do you implement a multiplexer in an FPGA design? <a name="116"></a> [UP↑](#tof)
1. Determine the number of inputs and select
lines required for your multiplexer. For example, if you have 4 inputs, you'll
need 2 select lines.
2. Create a truth table
3. Use the logic elements available in the FPGA,
such as LUTs, to implement the logic expressions derived (pol. *pochodny*) from the truth table.
4. Use FPGA synthesis tools to convert your design into a
 configuration file compatible with the specific FPGA device you are using.

### 17. How do you handle timing constraints (pol. radzić sobie z ograniczeniami czasowymi) in FPGA designs? <a name="117"></a> [UP↑](#tof)
General steps involved:
- Determine the timing requirements for your design,
including maximum and minimum clock frequencies, setup and hold times for input
and output signals, and any other specific timing constraints.
- Run static timing analysis tools provided by
the FPGA development environment to verify if the design meets the timing
requirements
- Make design modifications to improve timing performance.
For example this can include techniques such as pipelining.
- Use timing analysis tools provided by the FPGA development
environment to analyze the design and identify critical paths. These are the
paths that have the highest impact on meeting timing requirements.

**Setup time** is the amount of time required for the input to a Flip-Flop to be
stable before a clock edge. **Hold time** is the minimum amount of time required
for the input to a Flip-Flop to be stable after a clock edge.

|![time](https://github.com/mozerpol/NotesFromLearning/assets/43972902/b00822fd-6f71-4a13-9119-0b39d0f81e85)|
|:--:|
|Source: *https://nandland.com/lesson-12-setup-and-hold-time/*|

### 18. Describe the basic architecture of an FPGA. <a name="118"></a> [UP↑](#tof)
The basic architecture of an FPGA consists of three main components:
- **Configurable logic blocks** - CLBs are the fundamental building blocks of
an FPGA. They consist of look-up tables (LUTs), flip-flops, and other logic
elements. CLBs can be interconnected to implement complex logic functions.

|![clb](https://github.com/mozerpol/NotesFromLearning/assets/43972902/d1d2e717-a928-491c-b651-f20ba80a0768)|
|:--:|
|Source: *https://www.fpgakey.com/uploads/images/original/20200618/102505CLB_Block_Diagram.png*|
- **input/output blocks** - IOBs provide the interface between the external
world and the internal logic of the FPGA. They consist of input and output
buffers, I/O standards converters, and other circuitry necessary for interfacing
with external devices.
- **programmable interconnects** - The programmable interconnects form a network of
routing resources that connect the CLBs and IOBs. They consist of a matrix of
programmable switches and wires. These interconnects allow for the flexible
routing of signals between different logic elements within the FPGA. By
configuring the interconnects, designers can establish the desired connections
and pathways for data flow.

|![fpga_3](https://github.com/mozerpol/NotesFromLearning/assets/43972902/47e538bf-04eb-43dc-bb9f-63bf6ecb9f73)|
|:--:|
|Source: *https://www.researchgate.net/figure/A-basic-FPGA-fabric-following-Wolf-2004-where-CLB-and-IOB-stand-for-Combinational-Logic_fig1_278329485*|

In addition to these main components, an FPGA also includes other supporting
elements such as clock management resources, configuration memory, and power
distribution networks.

### 19. Describe the process of place and route in FPGA design. <a name="119"></a> [UP↑](#tof)
The place and route process is a step that follows the synthesis stage. It
involves mapping the synthesized logic elements onto specific locations
(placement) within the FPGA device and establishing the interconnections
(routing) between these elements.

### 20. What are the advantages and disadvantages of using an FPGA in a design? <a name="120"></a> [UP↑](#tof)
Advantages of using an FPGA in a design:
- **Flexibility**: they can be reprogrammed or reconfigured to implement different
functionalities,
- **Customizability**: FPGAs allow designers to create custom digital logic circuits
tailored to their specific application requirements,
- **Parallelism**: allowing for the execution of multiple tasks simultaneously,
- **Integration**: FPGAs often include various on-chip resources such as memory
blocks, DSP (Digital Signal Processing) units, and high-speed I/O interfaces,
facilitating the integration of multiple functions into a single device.

Disadvantages of using an FPGA in a design:
- **Cost**: FPGAs can be more expensive compared to other off-the-shelf integrated
circuits,
- **Power consumption**: FPGAs typically consume more power compared to
application-specific integrated circuits (ASICs) or microcontrollers,
- **Complexity**: Designing for FPGAs requires specialized knowledge and expertise
in digital logic design, hardware description languages, and FPGA-specific tools,
- **Non-volatile limitations**: Traditional FPGAs lose their configuration when
powered off, requiring reprogramming at startup.

### 21. How do you handle clock domain crossing in an FPGA design? <a name="121"></a> [UP↑](#tof)
Are some common techniques to handle CDC:
- Identify the signals or interfaces that cross between different clock domains.
- Insert synchronization elements at the crossing points to synchronize the data
between the different clock domains. Common synchronizer techniques include
using dual-flip flops.

| ![metastability_fix](https://github.com/mozerpol/NotesFromLearning/assets/43972902/66a55f57-341e-45f6-923d-3694c8f63695) |
|:--:|
|Source: *https://nandland.com/lesson-14-crossing-clock-domains/*|

### 22. What are some common challenges and considerations when designing for FPGAs? <a name="122"></a> [UP↑](#tof)
- **Timing and performance**: FPGAs have a fixed number of resources, including
logic gates and flip-flops, which can limit the performance of the design.
Timing analysis are required to ensure that the design meets the desired
performance goals,
- **Power consumption**: FPGAs can consume significant power, so power optimization
techniques need to be considered during the design process,
- **Design complexity**: Partitioning the design into smaller modules, using
hierarchical design approaches, and proper design documentation can help manage
complexity,
- **Debugging and verification**: Tools like simulation, formal verification, and
on-chip debugging techniques can be used to ensure the correctness of the design.

## VHDL <a name="2"></a>

### 1. What is VHDL and why is it used in digital design?
VHDL is used for various reasons:
- **Modeling and Simulation** - VHDL allows to describe the behavior and
functionality of digital circuits. It provides
testing and verification before actual implementation.
- **Design Reusability**: VHDL code can be easily reused and shared across different
projects.
- **Synthesis and Implementation** - VHDL can be synthesized into a gate-level
representation, which can then be implemented on a specific hardware platform.
This synthesis process translates the higher-level description into actual
digital hardware.

### 2. Explain the difference between a concurrent signal assignment and a sequential signal assignment in VHDL.
- **Concurrent Signal Assignment** - the assignment is made for
multiple signal assignments that occur simultaneously. Concurrent
(pol. równoległy) signal assignments are typically used in the architecture
body, outside any process statement. Example:
```VHDL
architecture Behavioral of Example is
  signal A, B, C: std_logic;
begin
  A <= '1';
  B <= '0' after 10 ns;
  C <= A and B;
end architecture;
```

- **Sequential Signal Assignment** - the assignment is made one after another in a
specific order as defined by a process statement. Sequential signal assignments
are used inside a process statement. Sequential signal assignments are executed
from top to bottom. Example:
```VHDL
architecture Behavioral of Example is
  signal A, B, C: std_logic;
begin
  process
  begin
    A <= '1';
    wait for 10 ns;
    B <= '0';
    wait for 5 ns;
    C <= A and B;
    wait;
  end process;
end architecture;
```

### 3. What are the different types of modeling in VHDL and when would you use each type?
In VHDL, are two types of modeling:
- **Behavioral Modeling** - used for higher-level description, algorithm
development, and simulation:
a) Describes the functionality and behavior of the design at a higher level of
abstraction.
b) It focuses on the algorithm or procedure rather than the specific hardware
implementation.
c) Behavioral models are often used for system-level modeling, algorithm
development, simulation, and verification.
d) These models are more readable, making them easier to understand and modify.
- **Structural Modeling** - used for detailed design, synthesis, and gate-level
simulation:
a) Describes the hardware implementation of the design using specific
components and their interconnections.
b) It involves representing the design as a network of interconnected
components, such as gates, flip-flops, multiplexers, etc.
c) Structural models are used for detailed design, synthesis, and gate-level
simulation.
d) These models reflect the actual structure and connections of the hardware.
e) They provide a more accurate representation of timing, delays, and resource
utilization.

### 4. How do you declare and use a component in VHDL?
A component declaration is similar to an entity declaration, where you define
the inputs, outputs, and other attributes of the component. Example:
```VHDL
component MyComponent
   port (
      input1 : in std_logic;
      input2 : in std_logic;
      output1 : out std_logic
   );
end component;
```

To use the declared component, you need to instantiate it in the architecture
section of your VHDL code. Example:
```VHDL
architecture myArchitecture of MyEntity is
   -- Signal declaration and other components/entities

   -- Instantiate the component
   componentInst : MyComponent
      port map (
         input1 => signal1,
         input2 => signal2,
         output1 => signal3
      );
begin
   -- Architecture implementation
end architecture;
```

### 5. Describe the process of writing a testbench in VHDL.
- Define the testbench entity
- Declare the necessary signals and components
- Instantiate the entity
- Stimulate the inputs
- Capture and verify the outputs
- Run the simulation

```VHDL
entity testbench is
end entity testbench;

architecture tb of testbench is

  component simpleram is
    port (
      clk  : in    std_logic;
      we   : in    std_logic;
      addr : in    std_logic_vector(4 downto 0);
      data : inout std_logic_vector(7 downto 0)
    );
  end component;

  signal clk_in : std_logic;
  signal we     : std_logic;
  signal addr   : std_logic_vector(4 downto 0);
  signal data   : std_logic_vector(7 downto 0);

begin

  dut : component simpleram
    port map (
      clk  => clk_in,
      we   => we,
      addr => addr,
      data => data
    );

  tb_process : process is
  begin
    wait for 10 ns;
    we   <= '1';
    addr <= (others => '0');
    stop;
  end process tb_process;

end architecture tb;
```

### 6. What is the purpose of generics and how are they used in VHDL?
Is to provide a mechanism for making a design
parameterizable, i.e., allowing a design to be configured and customized without
modifying its source code. An example:
```VHDL
entity my_component is
  generic (
    WIDTH   : integer := 8;     -- Default generic value
    ENABLE  : boolean := true   -- Default generic value
  );
  port (
    input   : in  std_logic_vector(WIDTH-1 downto 0);
    output  : out std_logic_vector(WIDTH-1 downto 0)
  );
end entity my_component;
```

### 7. Explain the concept of VHDL packages and libraries.
- **Library** - collection of related packages, where each package contains one
or more VHDL entities. They can be easily accessed and shared across different
designs or  projects. For example, a library may contain packages for arithmetic
operations, I/O interfaces, or specific functions.
- **Packages** - provide a mechanism to encapsulate and organize
VHDL entities within a library. They are essentially a container for
declarations that can be shared and used by multiple designs. Packages
can include type definitions, constant declarations, functions, procedures, and
component declarations.

### 8. How do you handle clock and reset signals in VHDL designs?
- **Clock signal handling**: <br/>
a) Declare a signal for the clock input,
b) The *rising_edge* and *falling_edge* functions allow to specify the edge of
the clock signal on which a particular process should execute.
- **Reset signal handling**:
a) Declare a signal for the reset: <br/>
Asynchronous reset: An asynchronous reset is typically used to clear the system
to a known state when the physical reset button is pressed. <br/>
Synchronous reset: A synchronous reset is used to reset the system based on the
clock edge and is usually preferred for robust (pol. *solidny*) design.

### 9. Can you explain the difference between VHDL and Verilog?
VHDL and Verilog are both hardware description languages commonly used in
digital design and verification. Key differences between them:
- **Syntax**: VHDL has a more verbose and natural language-like syntax with
English keywords, while Verilog has a more concise and C-like syntax.
- **Modeling Features**: VHDL provides a rich set of modeling constructs,
including processes and functions, which makes it suitable for complex
system-level modeling. Verilog, on the other hand, offers a simpler event-driven
modeling style that is more suitable for hardware modeling at the
register-transfer level.
- **Simulation Performance**: Verilog is generally known to have better
simulation performance and efficiency than VHDL due to its event-driven nature.

### 10. What are the different types of data types available in VHDL? Explain their usage.
Data types available:
- **Bit** - The 'bit' type is the smallest data type in VHDL and represents a
single binary digit (0 or 1),
- **Boolean** - The 'boolean' type represents a logical value, either true or
false,
- **Integer** - The 'integer' type is used to represent whole numbers. It is
commonly used for indexing arrays or counting in loops,
- **Real** - The 'real' type represents real numbers, which include both
integers and fractions. Real numbers are used to perform floating-point
arithmetic and are often used in mathematical computations.
- **Time** - The 'time' type is used to represent time values. It is used in
simulation models to specify timing delays or durations,
- **Character** - The 'character' type is used to represent individual
characters. It is commonly used in text-based operations,
- **Enumerated** - The 'enumerated' type is a user-defined type that allows the
creation of a set of named values. It is often used to define state machines.

### 11. How do you describe a combinational logic circuit using VHDL?
**Combinational logic** - a type of digital logic circuit whose output is 
dependent on the input values. There is no memory. An example can be gates. <br/>
```VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_gate is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
end AND_gate;

architecture Behavioral of AND_gate is
begin

    Y <= A AND B;

end Behavioral;
```

### 12. What is the purpose of a process statement and a concurrent statement in VHDL?
**Concurrent statement** - these statements are executed concurrently 
(pol. *jednocześnie*) and can be used to represent concurrent processes. 
Example: <br/>

```VHDL
library ieee;
use ieee.std_logic_1164.all;

entity concurrent_example is
port(
    a, b: in std_logic;
    y1, y2, y3: out std_logic
);
end concurrent_example;

architecture behavioral of concurrent_example is
begin
    -- Concurrent signal assignments
    y1 <= a and b;
    y2 <= a or b;
    y3 <= a xor b;

end behavioral;
```

**Process statement** is used to define a block of sequential statements that 
are executed in a specific order. <br/>
```VHDL
process (input1, input2)
begin
  if input1 = '1' then
    output <= input2;
  else
    output <= '0';
  end if;
end process;
```

### 13. Explain the concept of generics and how they are used in VHDL.
Generics in VHDL allow for the creation of parameterized components and 
entities, allowing them to be more easily reused in different parts of a design. 
Generics are declared at the beginning of a component or entity declaration, and 
their values can be set when using the component or entity in a higher-level 
design.


