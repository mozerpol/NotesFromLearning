# Microprocessor-Design
Notes from reading the Microprocessor Design book, which is availble on the wiki 
https://upload.wikimedia.org/wikipedia/commons/7/71/MicroprocessorDesign.pdf

### Table of contents <a name="tof"></a>
1. [Processor classification](#procclas)
2. [Assembly Language](#asemb)
3. [Von Neumann Architecture](#neumann)
4. [Harvard Architecture](#harvard)
5. [Pipelining](#Pipelining)
    1. [Pipeline Hazards](#pipehaz)
    2. [Superscalar processing](#superScal)
6. [Cache](#Cache)
7. [Endianness](#Endianness)
8. [Stack](#Stack)
9. [Design steps MCU](#design)
10. [Multiplexers](#Multiplexers)
11. [Adder](#Adder)
    1. [Half adder](#half)
    2. [Full adder](#full)
    3. [Serial Adder](#serial)
    4. [Parallel Adder](#paradder)
    5. [Ripple Carry Adder](#rcadder)
    6. [Carry Lookahead Adder](#cladder) --> finish!
    7. [Cascading Adders](#cadders) --> finish!
12. [ALU](#ALU)
    1. [Program counter](#counter)
    2. [Branching](#Branching)
    3. [Microcode](#Microcode)
    4. [Microarchitecture](#Microarchitecture)
    5. [Machine state register](#msr)
    6. [Instruction Decoder](#instr)
13. [Register File](#regf)
    1. [Register Bank](#regbank)
14. [ALU](#alu2) --> Another, different description of ALU
    1. [2-Bit ALU](#bit2alu)
    2. [Accumulator](#accum)
    3. [Register Stack](#regstac)
    4. [Register-and-Memory](#regMem)
    5. [IA-32](#iatrz)
    6. [MIPS](#mips)
15. [FPU](#fpu)
    1. [IEEE 754](#ieeesev)
    2. [Design FPU](#fpudesign)
16. [Control Unit](#cu)
17. [Shift and Rotate Blocks](#sarb)
    1. [Logical Shift](#logshft)
    2. [Arithmetic shift](#artshft)
18. [Multiplication and Division](#mulanddiv) 

### Processor classification <a name="procclas"></a>

#### Purpose
1. general purpose - typical processor, which is designed to be integrated into a larger system with peripherals and external RAM.
2. DSP - is a chip that is specifically designed for fast arithmetic operations, especially addition and multiplication.
3. Embedded Controller or microcontroller - **not microprocessor**, it's microprocessor with additional hardware integrated into a single chip. 
4. Programmable State Machine - it's minimalist microprocessor that is designed for very small and simple operations. Usually it's embedded directly into the design of a larger chip.

#### Type of use
1. Signal Processing - Signal processing systems typically need to have low latency (pol. *czas oczekiwania*), and are very deadline driven (pol. *terminowy*). An example of a signal processing applicationis the decoding of digital television and radio signals.
2. Real Time Applications - timing is of the utmost (utmost - *najwyzszy*) importance. An example of a real-time system is the anti-lock braking system (ABS) controller in modern automobiles.
3. Throughput and Routing - An example is an internet router, that reads in data packets and sends them out on a different port. (Throughput - *wydajnosc*)
4. General Computing - general purpose processor is like the kind of processor that is typically found inside a desktop PC.

### Assembly Language <a name="asemb"></a> [UP↑](#tof)
*Assembly Language* - small language that contains a short word or ”mnemonic” for each individual command that a microcontroller can follow. Each command gets a single mnemonic, and each mnemonic corresponds to a single machine command. Assembly language gets converted (by a program called an ”assembler”) into the binary machine code. <br/>
Examples of ISA:
- ARM
- IA-32 (Intel x86)
- MIPS 
- Motorola 68K
- PowerPC
- Hitachi SH
- SPARC

### Moore’s Law
*Moore’s Law* - the number of transistors on a single chip at the same price will double every 18 to 24 months. This law has held (has held - *orzekl*) without fail since it was originally stated in 1965. Moore’s Law has been used incorrectly to calculate the speed of an integrated circuit. <br/>
The amount of work that a processor can complete in a single cycle is measured in **cycles per instruction**. For somesystems, such as MIPS, there is 1 cycle per instruction. For other systems, such as modern *x86* chips, there are typically very many cycles per instruction.

### Von Neumann Architecture (a.k.a. Princeton) <a name="neumann"></a> [UP↑](#tof)
It was developed for [ENIAC](https://en.wikipedia.org/wiki/ENIAC). It uses the same memory and data paths for both program and data storage. In other words Von Neumann architecture is based on the stored-program computer concept, where instruction data and program data are stored in the same memory.

 ![von1](https://user-images.githubusercontent.com/43972902/102547890-255eda00-40ba-11eb-92a2-02efd58b855e.png) 
| ![von2](https://user-images.githubusercontent.com/43972902/102547956-3dcef480-40ba-11eb-956e-d3d3e922b339.png) |
|:--:|
| Source: *https://www.computerscience.gcse.guru/theory/von-neumann-architecture*  [17.12.2020] |

intermediate - *pośredni*.

### Harvard Architecture <a name="harvard"></a> [UP↑](#tof)
Computer architecture with separate storage and signal path ways for instructions and data. Many DSPs are modified Harvard architectures.
| ![harvard](https://user-images.githubusercontent.com/43972902/102548963-b1253600-40bb-11eb-8fd0-b68952f707c7.png) |
|:--:|
| Source: *https://en.wikipedia.org/wiki/Harvard_architecture*  [17.12.2020] |

**Programmer-visible registers (User-Visible Registers)** - are the registers which are used during application programming and are directly used in the instructions. For example reserved registers like *UCSRA* (for *AVR*) or general purpose registers X1, ..., x31.  <br/>
The registers are the fastest accessible memory locations, and because they are so fast, there are typically very few of them. In most processors, there are fewer than 32 registers. The size of the registers defines the size of the computer. For instance, a ”32 bit computer” has registers that are 32 bits long. The length of a register is known as the **word length** of the computer.

Factors (pol. *czynniki*) limiting the number of registers:
- new CPU should be software-compatible with an old CPU. This requires the new chip to have exactly the same number of programmer-visible registers as the old chip.
- Doubling the number general-purpose registers requires adding another bit to each instruction that selects a particular register. Each 3-operand instruction (that specify 2-source operands and a destination operand) would expand by 3 bits. 
- Adding more registers adds more wires to the critical path, adding capacitance, which reduces the maximum clock speed of the CPU.

*General purpose registers* - registers that can be used by the programmer to store arbitrary data (pol. *dowolne dane*). <br/>
*Reserved registers* - registers that cannot be accessed by the programmer directly.

*Microarchitectural registers (physical registers)* - registers that are not programmer-visible these registers include:
- memory address register
- memory data register
- instruction register
- microinstruction register
- microprogram counter
- pipeline registers

### Pipelining <a name="Pipelining"></a> [UP↑](#tof)
Pipelining (*pol.* potokowość) - technology of building processors consisting in the division (pol. *polegający na podziale*) of the processor logic responsible for the program execution process (processor instructions) into specialized groups in such a way that each group performs a part of the work related to the execution of the instruction. These groups are linked sequentially - into a *pipe* and perform their work simultaneously (czyt. *simultejnisli*) download data from the previous element in the sequence. In each of these groups, the task is in a different stage of execution. Processor instruction execution phases can be as follows:
1. Get instructions from memory - instruction fetch (IF)
2. Decode the instruction - instruction decode (ID)
3. Execute the instruction - execute (EX)
4. Memory access (MEM)
5. Save the results of the instruction - store; write back (WB)

| ![pipeline](https://user-images.githubusercontent.com/43972902/102655285-5a2e6800-4172-11eb-99c2-eff0dd2317c7.png) |
|:--:|
| Source: *https://pl.wikipedia.org/wiki/Potokowo%C5%9B%C4%87*  [18.12.2020] |

In the above 5-step pipeline, it takes five clock cycles to go through all the steps in the pipeline. In other words, executing one instruction take 5 clock cycles, because instruciotn must go to through all five steps. However, due to the simultaneous operation of all stages of the pipeline, 5 instructions are executed simultaneously, each at a different stage of execution. This means that processor starts and stops one instruction every one clock cycle and *statistically* executes the one instruction in every clock cycle. Each stage from the pipeline does less work compared to a single logic, so it can do it faster - with greater frequency - so by increasing the number of stages additionally, it can achieve ever higher operating frequencies.

**Features of the pipeline architecture:**
- Instructions are executed "overlapped" (but not in parallel!). The execution of the next instruction begins before the current instruction finishes executing.
- Each block of processor is used on each clock cycle, processing different phases of different instructions. 
- The execution time for all instructions must be the same. If the instruction can be executed earlier, the processor must wait to complete instruction.
- The performance grows in a pipeline architecture over traditional architecture are proportional to the number of instruction phases.

#### Pipeline Hazards <a name="pipehaz"></a> [UP↑](#tof)
[Control Hazard](https://web.cs.iastate.edu/~prabhu/Tutorial/PIPELINE/controlHaz.html) - (pol. *konflikt sterowania*) - disturbance of the processing sequence at branching.
The reduction of this problem can be achived by using the prediction of branching (jumps). The prediction can be static (based on the command code analysis) or dynamic (based on processing history - branching chance analysis). 

#### Methods of increasing the efficiency of pipeline processing in case of conditional jump instruction:
1. Program fragment caching - consists in storing a program fragment in the processor's cache memory. This method is useful for handling loops. If the buffer is large enough to accommodate all loops, these commands only need to be fetched once. 
2. Out-of-order execution
3. Branch prediction

[Data Hazard](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#Data_hazards) - (pol. *konflikt danych*) - simultaneous use of the same data. <br/>
[Struktural Hazard](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#Structural_hazards) - (pol. *konflikt zasobow*) - simultaneously requesting access to memory or other unique resource in the computer.
#### Superscalar processing <a name="superScal"></a> [UP↑](#tof)

[Superscalar processing](https://en.wikipedia.org/wiki/Superscalar_processor) - (pol. *przetwarzanie superskalarne*) - it's based on the use of several scalar data processing pipelines run in parallel, which allows for the execution of more than one instruction in one clock cycle. <br/>
Nice link about pipelining [18.12.2020]: https://cs.stanford.edu/people/eroberts/courses/soco/projects/2000-01/risc/pipelining/index.html

### Cache <a name="Cache"></a> [UP↑](#tof)
Most CPUs manufactured do not have any cache. The cache is used because reading external memory is very slow and reading a local cache is much faster. In modern processors, the cache can take up as much as 50% or more of the total area of the chip. Cache typically comes in 2 or 3 ”levels”, depending on the chip. Level 1 (L1) cache is smaller
and faster than Level 2 (L2) cache, which is larger and slower. Some chips have Level 3
(L3) cache as well, which is larger still than the L2 cache (although L3 cache is still much
faster than external RAM).

### Endianness <a name="Endianness"></a> [UP↑](#tof)
[Endianness](https://en.wikipedia.org/wiki/Endianness) - is the order or sequence of bytes of a word of digital data in computer memory. Endianness is primarily expressed as big-endian (BE) or little-endian (LE). A big-endian system stores the most significant byte of a word at the smallest memory address and the least significant byte at the largest. A little-endian system, in contrast, stores the least-significant byte at the smallest address. 

| ![endian](https://user-images.githubusercontent.com/43972902/102886883-3a3ec300-4456-11eb-8abf-990583caa77e.png) |
|:--:|
| Source: *https://en.wikipedia.org/wiki/Endianness*  [22.12.2020] |

#### NUXI problem 
NUXI problem -  Refers to the problem of transferring data between machines with differing byte-order. The string **UNIX** might look like **NUXI** on a machine with a different byte sex (e.g., when transferring data from a little-endian to a big-endian, or vice-versa). [source](https://ckziumragowo.pl/pub/app/Jargon/index.php/word/NUXI+problem) 

### Stack <a name="Stack"></a> [UP↑](#tof)
**Stack** - The stack is a sequential set of memory locations that is set to act like a LIFO (last in, first out) buffer. Most computer architectures include at least a register that is usually reserved for the stack pointer.<br/>
**push** - operation add data to the top of the stack <br/>
**pop** - remove add data from the top of the stack <br/>
**CISC** - Complex Instruction Set Computer. The most well known/commoditized CISC ISAs are the Motorola 68k and Intel x86 architectures. <br/>
**RISC** - Reduced Instruction Set Computer. The most well known/commoditized RISC ISAs are the PowerPC, ARM, MIPS and SPARC
architectures. <br/>
**Program Counter** (PC) - a register inside the microprocessor, that contains the address of the current instruction. During the fetch cycle, the instruction from the address indicated by the program counter is read from memory into the instruction
register (IR), and the program counter is incremented by *n* , where *n* is the word length of the machine (in bytes). <br/>

Branching and Jumping is the ability to load the PC register with a new address that is not the next sequential address. In general, a **jump** or **call** occurs unconditionally, and a **branch** occurs on a given condition. A **call** instruction is a branch instruction with the additional effect of storing the current address in a specific location, e.g. pushing it on the stack, to allow for easy return to continue execution. In many programs, ”call” is the second-most-frequently used instruction (after ”move”). 

**NOP**, short for ”no operation” is an instruction that produces no result and causes no side effects. NOPs are useful for timing and preventing hazards.

**Random Access Memory** (RAM), also known as *main memory*. Dynamic RAM (DRAM) is a type of RAM that contains a single transistor and a capacitor. DRAM is smaller than SRAM, and therefore can store more data in a smaller area. Because of the charge and discharge times of the capacitor, however, DRAM tends to be slower than SRAM. Many modern types of Main Memory are based on DRAM design because of the high memory densities. Because DRAM is simpler than SRAM, it is typically cheaper to produce.

**Static RAM** (SRAM) is a type of memory storage that uses 6 transistors to store data. These transistors store data so long as power is supplied to the RAM and do not need to be refreshed. SRAM is typically used in processor caches because of its faster speed, but not in main memory because it takes up more space.
| ![sram](https://user-images.githubusercontent.com/43972902/103000615-ab03df00-452b-11eb-8ac3-f5ac6a4c7baa.png) |
|:--:|
| Source: *https://pl.wikipedia.org/wiki/Pami%C4%99%C4%87_statyczna*  [23.12.2020] |

Most processors and other complicated hardware circuits are typically divided into two components: a **datapath** and a **control unit**. The **datapath** contains all the hardware necessary to perform all the necessary operations. In many cases, these hardware modules are parallel to one another, and the final result is determined by multiplexing all the partial results. The **control unit** determines the operation of the datapath, by activating switches and passing control signals to the various multiplexers. In this way, **the control unit can specify how the data flows through the datapath**.

**Relative jump** - the instruction’s operand tells how many bytes the program counter should be increased or decreased. <br/> 
**Absolute jump** - the instruction’s operand is copied to the program counter; the operand is an absolute memory address where the execution should continue. 

### Design steps microprocessor or microcontroller unit: <a name="design"></a> [UP↑](#tof)
1. Determine the capabilities the new processor should have.
2. Lay out (pol. *rozlozyc*) the datapath to handle the necessary capabilities (pol. *do obsługi niezbędnych możliwości*).
3. Define the machine code instruction format (ISA)
4. Construct the necessary logic to control the datapath.

#### 1. Determine machine capabilities
Some questions to start:
1. Is this chip an embedded chip, a general-purpose chip, or a different type entirely? 
2. What, if any, are the limitations in terms of resources, price, power, or speed?
3. With that in mind (pol. *Pamiętając o tym*), we need to ask what our chip will do:
    - Does it have integer, floating-point, or fixed point arithmetic, or a combination of all three?
    - Does it have scalar or vector operation abilities?
    - Is it self-contained (pol. *samowystarczalny*), or must it interface with a number of external peripherals?
    - Will it support interrupts? If so, How much interrupt latency is tolerable? How much interrupt-response jitter (pol. *drganie*) is tolerable?
    - We also need to ask ourselves whether the machine will support a wide array of instructions, or if it will have a limited set of instructions. More instructions make the design more difficult, but make programming and using the chip easier. On the other hand, having fewer instructions is easier to design, but can be harder and more costly to program.

Lay out the basic arithmetic operations you want your chip to have:
- Addition/Subtraction
- Multiplication
- Division 
- Shifting and Rotating
- Logical Operations: AND, OR, XOR, NOR, NOT, etc. 

List other capabilities that your machine has:
- Unconditional jumps
- Conditional Jumps (and what conditions?)
- Stack operations (push, pop)

#### 2. Design the datapath
We need to determine what ALU architecture that our processor will use:
- Accumulator
- Stack
- Register
- A combination of the above 3

#### 3. Create ISA
There are a few things that we need to consider:
- Is this processor RISC, CISC, or VLIW?
- How long is a machine word?
- How do you deal with immediate values? What kinds of instructions can accept immediate values?

A **register** is a storage element typically composed of an array of flip-flops. <br/>
A **register file** is a whole collection of registers, typically all of which (pol. *z których każda*) are the same length. A register file takes three inputs, an index address value, a data value, and an enable signal. A signal decoder is used to pass the data value from the register file input to the particular register with the specified address.

### Multiplexers <a name="Multiplexers"></a> [UP↑](#tof)
| ![mux](https://user-images.githubusercontent.com/43972902/103135238-38276f00-46b7-11eb-86f4-eacf6f62a873.png)|
|:--:|
| A 2-to-1 mux |
| Source: *https://en.wikipedia.org/wiki/Multiplexer*  [25.12.2020] |

A multiplexer is an input selector. A multiplexer has 1 output, a control input, and several data inputs. For ease, we number multiplexer inputs from zero, at the top. If the control signal is ”0”, the 0th input is moved to the output. If the control signal is ”3”, the 3rd input is moved to the output. A multiplexer with *N* control signal bits can support <img src="https://render.githubusercontent.com/render/math?math=2^{N}"> inputs. For example, a multiplexer with 3 control signals can support <img src="https://render.githubusercontent.com/render/math?math=2^{3} = 8"> inputs. Multiplexers are typically abbreviated as *”MUX”*.

| ![mux441](https://user-images.githubusercontent.com/43972902/103135454-bb959000-46b8-11eb-9202-fd5b04be5052.png) |
|:--:|
| A 4-to-1 mux |
| Source: *https://en.wikipedia.org/wiki/Multiplexer*  [25.12.2020] |


| ![asdfaa](https://user-images.githubusercontent.com/43972902/105250764-96daee00-5b7a-11eb-9092-522be527bf9a.png) |
|:--:|
| A 8-to-1 mux |
| Source: *https://en.wikipedia.org/wiki/Multiplexer*  [25.12.2020] |

I'll translate it once again, but in different way. <br/>
It will be easier use this true table for four input mux:
| ![mul](https://user-images.githubusercontent.com/43972902/103803417-d0770980-5050-11eb-92b1-65bae9c80bae.png) |
|:--:|
| A 4-to-1 mux |
| Source: *https://i1.wp.com/technobyte.org/wp-content/uploads/2020/01/TRUTH-TABLE-4X1-MUX.png?ssl=1*  [06.01.2021] |

We have four outputs and four inputs. If we have four inputs we need two select lines, because:
- 0b00 means first input
- 0b01 means second input
- 0b10 means third input
- 0b11 means fourth input

If we select second input (s1 = 0, s0 = 0), then we must carry input to output like on this pseudocode:

```
if((s0 == 0) && (s1 == 1)) then (out == second_input)
```
You can find verilog file for mux [here](https://github.com/mozerpol/NotesFromLearning/tree/main/Microprocessor-Design/code/multiplexer)

### Adder <a name="Adder"></a> [UP↑](#tof)
An adder is a digital circuit that performs addition of numbers. They are also used in other parts of the processor, where they are used to calculate addresses, table indexes, increment and decrement operators and similar operations. 
Adders can be divided into:
1. serial adder - during each operation, they add two component bits and a carry bit
2. parallel adder - they add together the bits from all positions, and the carry bit is performed depending on how the one-bit adders are connected.
    - ripple-carry adder
    - carry look-ahead adder
    
Each adder has a completion type:
- full adder
- half adder

Each full full adder consists of two half adders.

#### Half adder <a name="half"></a> [UP↑](#tof)
The half adder adds two single binary digits A and B. It has two outputs, sum (S) and carry (C). The carry signal represents an overflow. The truth table:
| ![halfAdder](https://user-images.githubusercontent.com/43972902/103895819-492da280-50f1-11eb-8409-38ec5e2aa301.png) |
|:--:|
| Half adder |
| Source: *https://en.wikipedia.org/wiki/Adder_(electronics)*  [07.01.2021] |

| ![halfAdderDiagram](https://user-images.githubusercontent.com/43972902/103943954-45bb0b00-5133-11eb-8088-c986e5057c83.png) |
|:--:|
| Half adder logic diagram |
| Source: *https://en.wikipedia.org/wiki/Adder_(electronics)*  [07.01.2021] |

#### Full adder <a name="full"></a> [UP↑](#tof)
Each full full adder consists of two half adders. A one-bit full-adder adds three one-bit numbers, often written as *A*, *B*, and *Cin*. <br/>
The truth table:
| ![fullAdder](https://user-images.githubusercontent.com/43972902/103943523-86665480-5132-11eb-959d-8157e7783c7c.png) |
|:--:|
| The truth table half adder  |
| Source: *https://en.wikipedia.org/wiki/Adder_(electronics)*  [07.01.2021] |

| ![fullAdderDiagram](https://user-images.githubusercontent.com/43972902/103944001-57041780-5133-11eb-8c73-f792a7446a0d.png) |
|:--:|
| Full adder logic diagram |
| Source: *https://en.wikipedia.org/wiki/Adder_(electronics)*  [07.01.2021] |

[Here](https://github.com/mozerpol/NotesFromLearning/tree/main/Microprocessor-Design/code/adder) you can find code in verilog for full and half adder.

#### Serial Adder <a name="serial"></a> [UP↑](#tof)
Serial Adder - serial binary adder performs binary addition bit by bit. Serial binary addition is done by a flip-flop and a full adder. The flip-flop takes the signal on each clock cycle and provides its value as the carry-in signal on the next clock cycle. After all of the bits of the input operands have arrived, all of the bits of the sum have come out of the sum output. <br/>
**Example:** <br/>
Decimal: 5 + 9 = 14 <br/>
X = 5, Y = 9, Sum = 14 <br/>
Binary: 0101 + 1001 = 1110 <br/>
Addition of each step: <br/>
![adderres](https://user-images.githubusercontent.com/43972902/104843852-03c95c00-58cd-11eb-9b24-1dac58177fd3.png)

**Result** = 1110 or 14

Ok, I'll try explain how it works, but using different words. I think it's easy. Everything is based on *XOR* gate. Let's look at truth table for two input *XOR*: <br/>

| A | B | Output |
|:--:|:--:|:--:|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

So, if we have only one *true*, then the result is *true*. Let's look at truth table for three input *XOR*: <br/>

| A | B | C | Output |
|:--:|:--:|:--:|:--:|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 1 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 1 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 1 |

Situation is almost the same like in two input case. If we have odd *true* in our input, then we have *true* on output. Why am I talking about this? Because *serial adder* works similarly. <br/>
*Serial adder* is like three input *XOR*, but the third input/otuput is connected with *Memory element*, which is in our case is *flip-flop*:
| ![serialAdder2](https://user-images.githubusercontent.com/43972902/104928523-0ac29e00-59a3-11eb-9fb9-f8be726f219e.png) |
|:--:|
| Serial adder logic diagram |
| Source: *https://beingelectricalengineer.blogspot.com/2019/03/serial-adder.html*  [18.01.2021] |

Let's look at truth table for *serial adder*: <br/>
| Input_1 | Input_2 | Cin | Cout | Output |
|:--:|:--:|:--:|:--:|:--:|
| 0 | 0 | 0 | 0 | 0 |
| 0 | 1 | 0 | 0 | 1 |
| 1 | 0 | 0 | 0 | 1 |
| 1 | 1 | 0 | 1 | 0 |
| 0 | 0 | 1 | 0 | 1 |
| 0 | 1 | 0 | 0 | 1 |
| 1 | 0 | 0 | 0 | 1 |
| 1 | 1 | 0 | 1 | 0 |
| 0 | 0 | 1 | 0 | 1 |

If we have odd *true* in our input, then we have *true* on output. Below is a more accuracy diagram:

| ![serialAdder3](https://user-images.githubusercontent.com/43972902/104935129-2467e380-59ab-11eb-9bce-13d021a7c5b3.png) |
|:--:|
| Serial adder logic diagram |
| Source: *https://www.ece.mcmaster.ca/~shirani/2di4/chapter8p2.pdf*  [18.01.2021] |

[Here](https://github.com/mozerpol/NotesFromLearning/tree/main/Microprocessor-Design/code/adder) is implementatnion in Verilog for serial adder.

#### Parallel Adder <a name="paradder"></a> [UP↑](#tof)

**Parallel Adder** is a digital circuit that compute the addition of variable binary strings of equivalent or different size in parallel.<br/>
A *single full adder* performs the addition of two one bit numbers and an input carry. It's easy I think. The *parallel adder* is a group of different adders, which work in parallel, like *ripple carry adder* or *carry-lookahead adder*.

#### Ripple Carry Adder <a name="rcadder"></a> [UP↑](#tof)
**Ripple-Carry adder** consists of full adders connected in a chain where the output carry from each *full adder* is connected to the carry input of the next higher order full adder in the chain. For the two-bit number, two adders are needed while for four bit number, four adders are needed and so on.

| ![parAdder](https://user-images.githubusercontent.com/43972902/106361838-e27e5c00-631f-11eb-949d-96a047fa2128.png) |
|:--:|
| Ripple-Carry adder |
| Source: *https://media.geeksforgeeks.org/wp-content/cdn-uploads/full_adder.png*  [30.01.2021] |

[Here](https://github.com/mozerpol/NotesFromLearning/tree/main/Microprocessor-Design/code/adder) is implementatnion in Verilog for Ripple-Carry adder.

#### Carry Lookahead Adder <a name="cladder"></a> [UP↑](#tof)

*Ripple carry adder* is nice, but is slow. Each adder block waits for the carry to arrive from its previous block. So there will be a considerable time delay which is carry propagation delay. A *carry look-ahead adder* reduces the propagation delay by introducing more complex hardware, but I think the operation is simple. <br/>
First, let's remember how the *full adder* works. 

| ![fulltruthtable](https://user-images.githubusercontent.com/43972902/106389450-a90f2480-63e3-11eb-9654-575c892a60c0.png) |
|:--:|
| The truth table full adder  |
| Source: *https://www.electronicshub.org/carry-look-ahead-adder/* [31.01.2021] |

| ![fulladderrec](https://user-images.githubusercontent.com/43972902/106389364-33a35400-63e3-11eb-9b94-92bbc0751641.png) |
|:--:|
| Full adder logic diagram |
| Source: *https://www.electronicshub.org/carry-look-ahead-adder/* [31.01.2021] |

Ok, so now define some auxiliary variables:
- Pi = Ai ⊕ Bi - it's easy I think. It's simple XOR, if we have two the same inputs (like 1,1 or 0,0), then we have 0. **Pi means carry propagate**.
- Gi = Ai * Bi - simple multiplication. **Gi means carry generate**. *Gi* produces the carry when both *Ai*, *Bi* are logic one, independently of the input carry.
- Si = Pi ⊕ Ci - it's sum output.
- Ci + 1 = Gi + Pi*Ci - carry output.

Ok, let's assume we have a four bit *Carry Lookahead Adder*. Let's create now boolean function of each carry output:
- C1 = G0 + (P0 * Cin)
- C2 = G1 + (P1 * C1) = G1 + (P1 * G0) + (P1 * P0 * Cin)

#### Cascading Adders <a name="cadders"></a> [UP↑](#tof)

### ALU <a name="ALU"></a> [UP↑](#tof)
*ALU* - arithmetic logic unit is a combinational digital circuit that performs arithmetic and bitwise operations on integer binary numbers. The inputs to an ALU are the data to be operated on, called *operands*.
| ![alu](https://user-images.githubusercontent.com/43972902/103954812-4a88ba80-5145-11eb-9e76-ac0dcff442a6.png) |
|:--:|
| A symbolic representation of an ALU |
| Source: *https://en.wikipedia.org/wiki/Arithmetic_logic_unit*  [08.01.2021] |

The ALU will be explain also later.

**Signals:**
1. Data - A basic ALU has three parallel data buses consisting of two input operands (A and B) and a result output (Y). Each data bus is a group of signals that conveys (pol. *przekazuje*) one binary integer number. Typically, the A, B and Y bus widths (the number of signals comprising (pol. *zawierający*) each bus) are identical and match the native word size of the external circuitry (pol. *obwody*).
2. Opcode - The opcode input is a parallel bus that conveys (pol. *przekazuje*) to the ALU an operation selection code, which is an enumerated (pol. *wyliczone*) value that specifies the desired arithmetic or logic operation to be performed by the ALU. **The opcode size (its bus width) determines the maximum number of different operations the ALU can perform**; for example, a four-bit opcode can specify up to sixteen different ALU operations. **Generally, an ALU opcode is not the same as a machine language opcode**, though in some cases it may be directly encoded as a bit field within a machine language opcode.
3. Status - The status outputs are various individual signals that convey supplemental (pol. *uzupełniający*) information about the result of the current ALU operation. General-purpose ALUs commonly have status signals such as: 
    - Carry-out - conveys (pol. *przekazuje*) the carry resulting from an addition operation, the borrow resulting from a subtraction operation, or the overflow bit resulting from a binary shift operation.
    - Zero - indicates all bits of Y are logic zero.
    - Negative - indicates the result of an arithmetic operation is negative.
    - Overflow - indicates the result of an arithmetic operation has exceeded (pol. *przekroczony*) the numeric range of Y.
    - Parity - indicates whether an even or odd number of bits in Y are logic one.

[Here](https://github.com/mozerpol/NotesFromLearning/tree/main/Microprocessor-Design/code/alu) you can find code in verilog for simple ALU.

#### Program counter <a name="counter"></a> [UP↑](#tof)
*Program counter* - is a register structure that contains the address pointer value of the current instruction. Each cycle, the value at the pointer is read into the instruction decoder and the program counter is updated to point to the next instruction. 

**RISC computer have all the instructions are the same length.** <br/>
**In CISC computers each instruction can be a different length.**

#### Branching <a name="Branching"></a> [UP↑](#tof)
Branching occurs at one of a set of special instructions known collectively (pol. *zbiorowo*) as ”branch” or ”jump” instructions. During a branch, a new address for the PC is loaded, typically from the instruction or froma register. A **non-offset branch**, frequently referred to as a ”jump” is a branch where the previous PC value is discarded (pol. *odrzucone*) and a new PC value is loaded from an external source:

![branching](https://user-images.githubusercontent.com/43972902/104107763-3ec10380-52bf-11eb-93c6-7f6feb8a2031.png)

An **offset branch** is a branch where a value is added (or subtracted) to the current PC valueto produce the new value:
![branching2](https://user-images.githubusercontent.com/43972902/104107819-ceff4880-52bf-11eb-9346-53c02a36b111.png)

**Offset and Non-Offset Branching** - many systems have capabilities to use both offset and non-offset branching:
![branching3](https://user-images.githubusercontent.com/43972902/104107847-0a9a1280-52c0-11eb-910a-43b1af898596.png)

#### Microcode <a name="Microcode"></a> [UP↑](#tof)
*Microcode* - is a computer hardware technique that insert a layer of organisation between the CPU hardware and the programmer-visible instruction set architecture of the computer. Microcode typically resides in special high-speed memory and translates machine instructions. It separates the machine instructions from the underlying (pol. *zasadniczy*) electronics, so that instructions can be designed and altered (pol. *zmieniony*) more freely. The lowest layer in a computer's software stack is traditionally raw binary machine code instructions for the processor. Microcode sits one level below this. To avoid confusion, each microprogram-related element is differentiated (pol. *rozróżniać*) by the micro prefix: microinstruction, microassembler, microprogrammer, microarchitecture, etc. A high-level programmer, or even an assembly programmer, does not normally see or change microcode. Some hardware vendors, especially IBM, use the term microcode as a synonym for firmware. Microprograms consist of series of microinstructions, which control the CPU at a very fundamental level of hardware circuitry. For example, a single typical horizontal microinstruction might specify the following operations: 
- Connect register 1 to the A side of the ALU
- Connect register 7 to the B side of the ALU
- Set the ALU to perform [two's-complement](https://en.wikipedia.org/wiki/Two%27s_complement) addition
- Store the result value in register 8

Ok, once again, but using different words. The microcode usually implements the more complicated instructions - the rest is in silicon. For example: the instruction `XOR r32, r32` will be in silicon, but some inventions like *PCMPISTRI* will not. One of the goals of the microcode was to break down the CISC instructions into a series of pseudo-RISC instructions, which are easier to optimize (they can be changed among themselves in some cases, performed simultaneously, etc; CISC is also possible, but it is more difficult). 

#### Microarchitecture <a name="Microarchitecture"></a> [UP↑](#tof)
*Microarchitecture* - also called computer organization and sometimes abbreviated (pol. *w skrocie*) as µarch or uarch, is the way a given instruction set architecture (ISA) is implemented in a particular (pol. *szczególny*) processor. A given ISA may be implemented with different microarchitectures. **Computer architecture is the combination of microarchitecture and instruction set architecture.** Examples of Intel microarchitectures:
- 8086
- i386
- Intel Core
- Sandy Bridge
- Haswell
- Skylake

| ![microarchitecture](https://user-images.githubusercontent.com/43972902/104111760-798a6200-52e6-11eb-93be-7e6a75f1dd97.png) |
|:--:|
| Block diagram of the i386 microarchitecture |
| Source: *https://en.wikipedia.org/wiki/Intel_80386*  [10.01.2021] |

#### Machine state register <a name="msr"></a> [UP↑](#tof)
*Machine state register (MSR)* - is one of three process control registers present in the [PowerPC](https://en.wikipedia.org/wiki/PowerPC) processor architecture. 

#### Control store
*Control store* - part of a CPU's control unit that stores the CPU's microprogram. 

#### Instruction Decoder <a name="instr"></a> [UP↑](#tof)
*Instruction Decoder* - reads the next instruction from memory, and sends the component pieces of that instruction to the necessary destinations. A CISC decoder is typically set up (*typically set up* - *zwykle skonfigurowane
*) as a state machine. The RISC instruction decoder is typically a very simple device. Its purpose is to translate an instruction code into the address in the micro memory where the micro code for the instruction starts.

### Register File <a name="regf"></a> [UP↑](#tof)
Registers are temporary storage locations inside the CPU that hold data and addresses. The register file is the component that contains all the general purpose registers of the microprocessor. A few CPUs also place special registers such as the PC and the status register in the register file. Other CPUs keep them separate. A simple register file is a set of registers and a decoder. The register file requires an address and a data input:
![registerFile](https://user-images.githubusercontent.com/43972902/104124091-08cb6000-534f-11eb-831c-a4bb5f77b26a.png)

#### Register Bank <a name="regbank"></a> [UP↑](#tof)
Consider a situation where the machine word is very small, and therefore (pol. *w związku z tym*) the available address space for registers is very limited. If we have a machine word that can only accommodate (pol. *pomieścić*) 2 bits of register address, we can only address 4 registers. However, register files are small to implement, so we have enough space for 32 registers. The solution to this dilemma is to utilize a *register bank* which consists of a series of register files combined together. 
A *register bank* contains a number of register files or pages. Only one page can be active at a time, and there are additional instructions added to the ISA to switch between the available register pages. Data values can only be written to and read from the currently active register page, but instructions can exist to move data from one page to another.
![registerBank](https://user-images.githubusercontent.com/43972902/104124348-bee37980-5350-11eb-8b9d-81467cb88db9.png) 

If the register bank has *N* registers, and a page can only show *M* registers (with *N* > *M*), we can address registers with two values, *n* and *m* respectively. We can define these values as:
![reg](https://user-images.githubusercontent.com/43972902/104124513-90b26980-5351-11eb-86f2-0cd4c441b40c.png)

In other words, *n* and *m* are the number of bits required to address *N* and *M* registers, respectively. We can break down the address into a single value as such:
![reg2](https://user-images.githubusercontent.com/43972902/104124580-e9820200-5351-11eb-9242-787dad79213c.png)

Where *p* is the number of bits reserved to specify the current register page. As we can see from this graphic, the current register address is simply the concatenation of the pagea ddress and the register address.

[Here](https://github.com/mozerpol/NotesFromLearning/tree/main/Microprocessor-Design/code/programCounter) you can find code in verilog for simple 4 x 16 register file.

#### Memory unit
Most modern PC computer systems are Princeton (von Neumann), not Harvard, so the memory unit must handle all instruction and data transactions. This can serve as a bottleneck (pol. *waskie gardlo*) in the design. <br/>
The memory unit is typically one of the slowest components of a microcontroller, becausethe external interface with RAM is typically much slower than the speed of the processor.

### ALU <a name="alu2"></a> [UP↑](#tof)
![alu2_1](https://user-images.githubusercontent.com/43972902/104484629-cbbed200-55c9-11eb-842d-e3b8968b3ed7.png)

CPU designers have used a variety of names for the arithmetic logic unit, including *ALU*, *integerexecution unit*, and *E-box*.

#### Example: 2-Bit ALU <a name="bit2alu"></a> [UP↑](#tof)
This is an example of a basic 2-bit ALU. The boxes on the right hand side of the image are multiplexers and are used to select between various operations: OR, AND, XOR, and addition.
![alu2_2](https://user-images.githubusercontent.com/43972902/104485370-b4341900-55ca-11eb-92f6-577594152da2.png)

Notice that all the operations are performed in parallel, and the select signal (*OP*) is usedto determine which result to pass on to the rest of the datapath. Notice that the carry signal, which is only used for addition, is generated and passed out of the ALU for every operation, so it is important that if we aren’t performing addition that we ignore the carry flag. <br/>
Each category of instruction set architecture (ISA): *stack*, *accumulator*, *register-memory* or *register-register-load-store* requires a different way of connecting the *ALU*. In all images below, the orange represents memory structures internal to the CPU (registers), and the purple represents external memory (RAM).

#### Accumulator <a name="accum"></a> [UP↑](#tof)
![acu](https://user-images.githubusercontent.com/43972902/104486744-7d5f0280-55cc-11eb-9001-66b1ab929c18.png)

An *accumulator machine* has one special register, called the *accumulator*. The accumulator stores the result of every ALU operation, and is also one of the operands to every instruction (pol. *jest takze jednym z operandow kazdej instrukcji*). This means that our ISA can be less complicated, because instructions only need to specify one operand, instead of two operands and a destination. Accumulator architectures have simple ISAs and are typically very fast. Unfortunately, accumulator machines are difficult to pipeline. One example of a type of computer system that is likely to use an accumulator is a common desk calculator.

#### Register-to-Register
![regtoreg](https://user-images.githubusercontent.com/43972902/104588861-4be84480-5669-11eb-9f5e-a258659b406f.png)

One of the more common architectures is a Register-to-register architecture, also called a 3 register operand machine. In this configuration, the programmer can specify both source operands, and a destination register. Unfortunately, the ISA needs to be expanded to include fields for both source operands and the destination operands. This requires longer instruction word length.
 
#### Register Stack <a name="regstac"></a> [UP↑](#tof)
![regstack](https://user-images.githubusercontent.com/43972902/104589436-26a80600-566a-11eb-9677-a948f1794bee.png)

In a register stack, the ALU reads the operands from the top of the stack, and the result is pushed onto the top of the stack. Complicated mathematical operations required ecomposition into [Reverse-Polish](https://en.wikipedia.org/wiki/Reverse_Polish_notation) form. The benefit comes from a highly simplified ISA. These machines are called *0-operand* or *zero address machines* because operands don’t need to be specified, because all operations act on specified stack locations. In the diagram, *SP* is the pointer to the top of the stack.

#### Register-and-Memory <a name="regMem"></a> [UP↑](#tof)
![regMem](https://user-images.githubusercontent.com/43972902/104590418-9a96de00-566b-11eb-83af-41b86452bdea.png)
One complicated structure is a *Register-and-Memory* structure. In this structure, one operand comes from a register file, and the other comes from external memory. In this structure, the ISA is complicated because each instruction word needs to be able to store a complete memory address, which can be very long. 

#### IA-32 <a name="iatrz"></a> [UP↑](#tof)
*The Intel IA-32* ISA (*x86* processors) use a **register stack architecture for the floating point unit**, but it uses a **modified Register-to-Register structure for integer operations**. All integer operations can specify a register as the first operand, and a register or memory location as the second operand. The first operand acts as an accumulator, so that the result is stored in the first operand register. The downside (pol. *minusem*) to this is that the instruction words are not uniform in length, which means that the instruction fetch and decode modules of the processor need to be very complex. A typical IA-32 instruction is written as: <br/>
`ADD AX, BX` <br/>
Where *AX* and *BX* are the names of the registers, so the result is stored back into *AX*.

#### MIPS <a name="mips"></a> [UP↑](#tof)
*MIPS* uses a **Register-to-Register structure**. Each operation can specify two register operands, and a third destination register. The downside (pol. *minusem*) is that memory reads need to be made in separate operations, and the small format of the instruction words means that space is at a premium, and some tasks are difficult to perform. An example of a MIPS instruction is: <br/>
`ADD R1, R2, R3` <br/>
Where *R1*, *R2* and *R3* are the names of registers. The resulting equation is save into *R1* register.

### FPU <a name="fpu"></a> [UP↑](#tof)
The FPU performs arithmetic operations on floating point numbers. An FPU is complicated to design, although the [IEEE 754](https://en.wikipedia.org/wiki/IEEE_754) standard helps to answer some of the specific questions about implementation.

#### Floating point numbers
Floating point numbers are specified in two parts: the exponent (*e*), and the mantissa (*m*). The value of a floating point number, *v*, is generally calculated as: <img src="https://render.githubusercontent.com/render/math?math=v=m*2^{e}">

#### IEEE 754 <a name="ieeesev"></a> [UP↑](#tof)
IEEE 754 format numbers are calculated as: <img src="https://render.githubusercontent.com/render/math?math=v=(1%2Bm)*2^{e}">
The mantissa, *m*, is normalized in this standard, so that it falls between the numbers *1.0* and *2.0*.
| ![ieee754](https://user-images.githubusercontent.com/43972902/104811649-49b6ef00-57fd-11eb-8c79-e798fb0b6d32.png) |
|:--:|
| Source: *https://pl.wikipedia.org/wiki/IEEE_754*  [16.01.2021] |

| ![ieee7542](https://user-images.githubusercontent.com/43972902/104811790-48d28d00-57fe-11eb-9e61-b9a2a5f42c3d.png) |
|:--:|
| Source: *https://www.geeksforgeeks.org/ieee-standard-754-floating-point-numbers/*  [16.01.2021] |

We write a single precision number in *IEEE-754* format on 32 bits. The first bit is the *S* bit. If the number is negative, it means *S* will be equal to *1*. If it is positive, *S* is *0*. Then we have *8* bits which represent the exponent, wherein (pol. *przy czym*) we have range of exponent from *-127* to *128*. The next 23 bits are the mantissa of the number, the leading non-zero bit is omitted (pol. *pominięty*). This gives about 7-8 decimal significant places. Ok, it's time for example. Let's convert single-precision IEEE 754 number into a floating-point decimal value. Let's take: <br/> `1 10000001 10110011001100110011010` <br/>
But exceptionally I will not write an example by yourself, but will just paste the screenshot.
| ![exampleiee](https://user-images.githubusercontent.com/43972902/104812255-589fa080-5801-11eb-9676-a5ec1a520247.png) |
|:--:|
| Source: *https://class.ece.iastate.edu/arun/CprE281_F05/ieee754/ie5.html*  [16.01.2021] |

[Here](https://babbage.cs.qc.cuny.edu/IEEE-754/) is calcualtor, which can help converts floating point numbers in the IEEE 754 standard. 

Multiplying two floating point numbers is done as such:
![mult](https://user-images.githubusercontent.com/43972902/104842083-dc6f9080-58c6-11eb-95f5-4b39fedb011e.png)

Likewise, division can be performed by:
![div](https://user-images.githubusercontent.com/43972902/104842488-f9a45f00-58c6-11eb-97ff-2ae9bf238e9b.png)

**Floating point addition and subtraction is more difficult than multiplication**. The only way that floating point numbers can be added together is if the exponents of both numbers are the same. This means that when we add two numbers together, we need first to scale the numbers so that they have the same exponent. 

#### Floating Point Unit Design <a name="fpudesign"></a> [UP↑](#tof)
FPU needs the following components: <br/>
**For addition/Subtraction:**
- A comparator (subtractor) to determine the difference between exponents, and to determine the smaller of the two exponents,
- An adder unit to add that difference to the smaller exponent,
- A shift unit, to shift the mantissa the specified number of spaces.

**An adder to add the mantissas together:**
- A multiplier (or a divider) for the mantissa part,
- An adder for the exponent prts.

### Control Unit <a name="cu"></a> [UP↑](#tof)
*Control Unit* - reads the opcode and instruction bits from the machine code instruction,and creates a series of control codes to activate and operate the various components to perform the desired task.

### Shift and Rotate Blocks <a name="sarb"></a> [UP↑](#tof)

#### Logical Shift <a name="logshft"></a> [UP↑](#tof)

#### Arithmetic shift <a name="artshft"></a> [UP↑](#tof)

#### Rotations

#### Fast Shift Implementations

### Multiply and Divide Blocks <a name="mulanddiv"></a> [UP↑](#tof)












