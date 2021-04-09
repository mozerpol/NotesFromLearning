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
    6. [Carry Lookahead Adder](#cladder)
    7. [Cascading Adders](#cadders)
12. [ALU](#ALU)
    1. [Program counter](#counter)
    2. [Branching](#Branching)
    3. [Microcode](#Microcode)
    4. [Microarchitecture](#Microarchitecture)
    5. [Machine state register](#msr)
    6. [Instruction Decoder](#instr)
    7. [2-Bit ALU](#bit2alu)
    8. [Accumulator](#accum)
    9. [Register Stack](#regstac)
    10. [Register-and-Memory](#regMem)
    11. [IA-32](#iatrz)
    12. [MIPS](#mips)
13. [Register File](#regf)
    1. [Register Bank](#regbank)
14. [FPU](#fpu)
    1. [IEEE 754](#ieeesev)
    2. [Design FPU](#fpudesign)
15. [Control Unit](#cu)
16. [Shift and Rotate Blocks](#sarb)
    1. [Logical Shift](#logshft)
    2. [Arithmetic shift](#artshft)
17. [Multiplication and Division](#mulanddiv) 
    1. [Booth’s Algorithm](#both) <-- finish
18. [ALU Flags](#aluflag) 
    1. [Zero Flag](#zeroflag)
    2. [Overflow Flag](#overflowflag)
    3. [Carry/Borrow Flag](#carborflag)
    4. [Comparisons Flag](#compflag)
19. [Single Cycle Processors](#singlecycpr)
20. [Multi Cycle Processors](#multicycpro)
21. [Pipelined Processors](#pipelineproc)
22. [Superscalar Processors](#superscalar)
23. [VLIW Processors](#vilw)
24. [Vector Processors](#vectorproc)
25. [Multicore Processors](#multicore)
    1. [Symmetric Multi-core](#symetric)
    2. [Asymmetric Multi-core](#asymetric)
26. [Exceptions](#exceptions)
27. [Interrupts](#interrupts)
28. [Hazards](#hazards)

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
Most processors today, such as the processors inside standard keyboards and mice, don’thave any cache. The cache is used because reading external memory is very slow and reading a local cache is much faster. In modern processors, the cache can take up as much as 50% or more of the total area of the chip. Cache typically comes in 2 or 3 ”levels”, depending on the chip. Level 1 (L1) cache is smaller and faster than Level 2 (L2) cache, which is larger and slower. Some chips have Level 3 (L3) cache as well, which is larger still than the L2 cache (although L3 cache is still much faster than external RAM). Processors without a cache are usually limited in performance by the main memory access time. Without a cache, the processor fetches each instruction, one at a time, from main memory, and every *LOAD* or *STORE* goes to main memory before executing the next instruction.

#### Principal of Locality
Cache helps to speed up processors because it works on the **principle of locality**. <br/> *Principle of locality*, is the tendency of a processor to access to the same set of memory locations repetitively in a short period of time. There are two types of locality:
1. Spatial - for better understandign consider simple array with elements. In these cases, when one data item is accessed, it is a good idea to load the surrounding memory area into the cache at the same time. So *spatial locality* (also termed as *data locality*) refers to the use of data elements within relatively close storage locations.
2. Temporal - when data item is accessed, it is likely that the same data item will be accessed again. It is a good ideato keep recently used items in the cache, and not over-write data that has been recently used.

#### Hit or Miss
A **hit** when talking about cache is when the processor finds data in the cache that it is looking for. A **miss** is when the processor looks for data in the cache, but the data is not available.

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

#### Ripple-Carry Adder <a name="rcadder"></a> [UP↑](#tof)
**Ripple-Carry adder** consists of full adders connected in a chain where the output carry from each *full adder* is connected to the carry input of the next higher order full adder in the chain. For the two-bit number, two adders are needed while for four bit number, four adders are needed and so on.

| ![parAdder](https://user-images.githubusercontent.com/43972902/106361838-e27e5c00-631f-11eb-949d-96a047fa2128.png) |
|:--:|
| Ripple-Carry adder |
| Source: *https://media.geeksforgeeks.org/wp-content/cdn-uploads/full_adder.png*  [30.01.2021] |

[Here](https://github.com/mozerpol/NotesFromLearning/tree/main/Microprocessor-Design/code/adder) is implementatnion in Verilog for Ripple-Carry adder.

#### Carry Lookahead Adder <a name="cladder"></a> [UP↑](#tof)
*Ripple carry adder* is nice, but is slow. Each adder block waits for the carry to arrive from its previous block. So there will be a considerable time delay which is carry propagation delay. A *carry look-ahead adder* reduces the propagation delay by introducing more complex hardware, but I think the operation is simple. <br/>
Let's look on the truth table for full adder:
![claasdf](https://user-images.githubusercontent.com/43972902/106494891-47ba8480-64bb-11eb-9f3b-d980e69443fd.png)

Look at last two positions in our table: *8* and *7*. We can see if *A* and *B* is equal *1* then our *Ci+1* is also equal *1*. So if we want only *1* on our output we can formulate formula: <br/>
**Ci+1 = A * B** - we can name this case **carry generate** and this part we call *G* <br/>
Next look at position: *6, 5, 4* and *3*. If *A* **or** *B* is equal *1* **and** *Ci* is equal *1* then our output is equal *1*. So if we want only *1* on our output we can formulate formula: <br/>
**Ci+1 = A ⊕ B * Ci** - we can name this case **carry propagate**. So in this case output depends on *Ci* and this part we call *P*. <br/>
Let's summarize and it's very very important, thanks to this we know when we have carry output: </br>
Carry output is equal *1* if **(A * B) + (A ⊕ B * Ci)** = **G + P * Ci** <br/>
Ok, I said that *Carry Lookahead Adder* is faster than *Ripple-Carry adder* and it's true. In *Ripple-Carry adder* we must wait for carry output from last position like on this picture:
| ![parAdder](https://user-images.githubusercontent.com/43972902/106361838-e27e5c00-631f-11eb-949d-96a047fa2128.png) |
|:--:|
| Ripple-Carry adder |
| Source: *https://media.geeksforgeeks.org/wp-content/cdn-uploads/full_adder.png*  [30.01.2021] |

**BUT** we know when we have carry output from last position, because we can calculate: `G + P * Ci*`, thanks to this it's not necessary wait for last module for carry output. Just add more logic gates which calculate `G + P * Ci*`. <br/>
Ok, let's create now boolean function of each carry output:
- C1 = G0 + (P0 * Cin) --> here we calculate carry otput for first module
- C2 = G1 + (P1 * C1) = G1 + (P1 * G0) + (P1 * P0 * Cin) --> here we took also *G* and *P* from last input and calculate carry otput from previous module. Thanks to this we have info about carry output and we don't have to wait for the previous module.
- C3 = G2 + (P2 * C2) = G2 + (P2 * G1) + (P2 * P1 * G0) + (P2 * P1 * P0 * Cin) -->  the same situation like above, we don't have to wait for the previous module, because we can calculate carry output from previous module. <br/>
As we can see *Carry Lookahead Adder* can be faster than *Ripple-Carry adder*, because we can calculate carry output from previous module and we don't have to wait, but there is one problem. *Carry Lookahead Adder* requires a lot more logic gates :(

| ![claadder5](https://user-images.githubusercontent.com/43972902/106494590-e7c3de00-64ba-11eb-8f63-286fd3f8e791.png) |
|:--:|
| 4bit Carry Lookahead Adder |
| Source: *https://www.researchgate.net/publication/225594280_Modeling_leakage_power_reduction_in_VLSI_as_optimization_problems*  [01.02.2021] |


#### Cascading Adders <a name="cadders"></a> [UP↑](#tof)

A basic *carry-lookahead adder* is very fast but has the disadvantage that it takes a very large amount of logic hardware to implement. In fact, the amount of hardware needed is approximately quadratic with n, and begins to get very complicated for n greater than 4. Due to this, most *CLAs* are constructed from "blocks" contain 4-bit *CLAs*, which are cascaded to produce a larger *CLA*. 

### ALU <a name="ALU"></a> [UP↑](#tof)
*ALU* - arithmetic logic unit is a combinational digital circuit that performs arithmetic and bitwise operations on integer binary numbers. The inputs to an ALU are the data to be operated on, called *operands*.
| ![alu](https://user-images.githubusercontent.com/43972902/103954812-4a88ba80-5145-11eb-9e76-ac0dcff442a6.png) |
|:--:|
| A symbolic representation of an ALU |
| Source: *https://en.wikipedia.org/wiki/Arithmetic_logic_unit*  [08.01.2021] |

**Signals:**
1. *Data* - A basic *ALU* has three parallel data buses consisting of two input operands (A and B) and a result output (Y). Each data bus is a group of signals that conveys (pol. *przekazuje*) one binary integer number. Typically, the A, B and Y bus widths (the number of signals comprising (pol. *zawierający*) each bus) are identical and match the native word size of the external circuitry (pol. *obwody*).
2. *Opcode* - The opcode input is a parallel bus that conveys (pol. *przekazuje*) to the *ALU* an operation selection code, which is an enumerated (pol. *wyliczone*) value that specifies the desired arithmetic or logic operation to be performed by the ALU. **The opcode size (its bus width) determines the maximum number of different operations the ALU can perform**; for example, a four-bit opcode can specify up to sixteen different ALU operations. **Generally, an ALU opcode is not the same as a machine language opcode**, though in some cases it may be directly encoded as a bit field within a machine language opcode.
3. *Status* - The status outputs are various individual signals that convey supplemental (pol. *uzupełniający*) information about the result of the current *ALU* operation. General-purpose *ALUs* commonly have status signals such as: 
    - Carry-out - conveys (pol. *przekazuje*) the carry resulting from an addition operation, the borrow resulting from a subtraction operation, or the overflow bit resulting from a binary shift operation.
    - Zero - indicates all bits of Y are logic zero.
    - Negative - indicates the result of an arithmetic operation is negative.
    - Overflow - indicates the result of an arithmetic operation has exceeded (pol. *przekroczony*) the numeric range of Y.
    - Parity - indicates whether an even or odd number of bits in Y are logic one.

[Here](https://github.com/mozerpol/NotesFromLearning/tree/main/Microprocessor-Design/code/alu) you can find code in verilog for simple ALU and [here](#https://github.com/mozerpol/NotesFromLearning/tree/main/Microprocessor-Design#aluflag) you can find more details about these flags.

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

Ok, once again, but using different words. The microcode usually implements the more complicated instructions - the rest is in silicon. For example: the instruction `XOR r32, r32` will be in silicon, but some inventions like *PCMPISTRI* will not. One of the goals of the microcode was to break down the CISC instructions into a series of pseudo-RISC instructions, which are easier to optimize (they can be changed among themselves in some cases, performed simultaneously, etc; CISC is also possible, but it is more difficult). <br/>
Ok, once again... ;p <br/>
*RISC* units are typically faster and more efficient than *CISC* units. For this reason, many *CISC* processors have complicated instruction decoders that actually convert the *CISC* machine code into a *RISC*-like set of internal instructions known as **microcodes**. It means that **microcode** is *RISC* machine code after translation from *CISC* machine code. After this translation microcodes are going to the internal core of the processor, which is based on the *RISC* design.

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

#### Example: 2-Bit ALU <a name="bit2alu"></a> [UP↑](#tof)

![alu2_1](https://user-images.githubusercontent.com/43972902/104484629-cbbed200-55c9-11eb-842d-e3b8968b3ed7.png)

CPU designers have used a variety of names for the arithmetic logic unit, including *ALU*, *integerexecution unit*, and *E-box*.

This is an example of a basic 2-bit ALU. The boxes on the right hand side of the image are multiplexers and are used to select between various operations: OR, AND, XOR, and addition.

![alu2_2](https://user-images.githubusercontent.com/43972902/104485370-b4341900-55ca-11eb-92f6-577594152da2.png)

Notice that all the operations are performed in parallel, and the select signal (*OP*) is used to determine which result to pass on to the rest of the datapath. Notice that the carry signal, which is only used for addition, is generated and passed out of the ALU for every operation, so it is important that if we aren’t performing addition that we ignore the carry flag. <br/>
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
They are useful on their own (pol. *są przydatne same w sobie *), but they also are used in multiplication and division modules. In a binary computer, a left shift has the same effect as a multiplication by 2 and a right shift has the same effect as a division by 2. **Since shift and rotate operations perform much more quickly then multiplication and division**.

#### Logical Shift <a name="logshft"></a> [UP↑](#tof)

Logical shift is easy to understand. When shifting left, the most-significant bit is lost, and a 0 bit is inserted on the other end. A single **left shift multiplies a binary number by 2**:
1. We have: `0010 << 1`
2. After this we have: `0100`. `0010` is 2, `0100` is 4.

When shifting right with a logical right shift, the least-significant bit is lost and a 0 is inserted on the other end. **For positive numbers, a single logical right shift divides a number by 2**:
1. We have: `0101 >> 1`
2. After this we have: `0010`. `0101` is 5, `0010` is 2.

| ![logshft](https://user-images.githubusercontent.com/43972902/106618536-da1c6000-656f-11eb-9e61-9898d97aa4f4.png) |
|:--:|
| Source: *https://open4tech.com/wp-content/uploads/2016/11/Logical_Shift.jpg*  [02.02.2021] |

#### Arithmetic shift <a name="artshft"></a> [UP↑](#tof)

When shifting right with an **arithmetic right shift**, the least-significant bit is lost and the **most-significant bit is copiedThe arithmetic and logical shift to the left are the same. **. The result of a Right Shift operation is a division by *2^n* , where *n* is the number of shifted bit positions.
1. We have: `1010 >> 1`
2. After this we have: `1101`. `1010` is *-6*, `1101` is *-3*.

The result of a **Left Shift** operation is a multiplication by *2*.
1. We have: `0010 << 1`
2. After this we have: `0100`. `0010` is 2, `0100` is 4.

| ![artshift](https://user-images.githubusercontent.com/43972902/106618180-7f830400-656f-11eb-9f4b-b8b5fb9f9796.png) |
|:--:|
| Source: *https://open4tech.com/wp-content/uploads/2016/11/Arithmetic_Shift.jpg*  [02.02.2021] |

#### Arithmetic Shift vs. Logical Shift

The arithmetic and logical shift to the left are the same. <br/>
Arithmetic right shift save the most-significant bit.

#### Rotations
A rotation is like a shift, except the bit shifted off the end of the register is then shiftedinto the new spot. It's very easy I think.
![rotation](https://user-images.githubusercontent.com/43972902/106793593-f09de680-6657-11eb-9618-c146e4744941.png)

### Multiply and Divide Blocks <a name="mulanddiv"></a> [UP↑](#tof)

Multiplication and division operations are significantly more complicated then addition or subtraction operations. This additional complexity leads to more hardware, more complicated hardware, and longer processing time. In hardware, multiplication and division are performed by a series of sequential additions and arithmetic shifts. It is typically not possible, or not desirable (pol. *pożądane*) to use the main adder and shifter units of the ALU, so a microprocessorwill typically have multiple ALU units.

#### Booth’s Algorithm  <a name="both"></a> [UP↑](#tof)

**Booth's algorithm** is a multiplication algorithm that multiplies two signed binary numbers in two's complement notation in efficient way. <br/>
I'll show the analytical method below: <br/>
Let's assume we want to multiply *-12* and *-14*. 
1. The first thing is change *-12* and *-14* to the two's complement code. For *-12* is *10100* and for *-14* is *10010*.
2. The second thing is also change *12* and *14* to the two's complement code. I know, that we want multiply *-12* and *-14*, but in this method we need positive and negative numbers. So, for *12* is *01100* and for *14* is *01110*.
3. Then create a table that will facilitate (pol. *ułatwi*) multiplication. In the picture we can see four numbers: -12, 12, -14 and 14. Also we can see the table we'll fill. *L.P.:* means ordinal number (pol. ***L**iczba **P**orządkowa*), it determines how many steps we have taken. We also have five columns: *I*, *II*, *III*, *IV*, *V* and next five columns: *A*, *B*, *C*, *D*, *E*. Why five columns? Because our number *-14* has five bits. <br/>
![ba1](https://user-images.githubusercontent.com/43972902/106901715-62c60800-66f8-11eb-8436-67a3c456fa08.png)
4. Ok, we have two numbers that we want to multiply: *-12* and *-14*. Now we must select one number, any, it doesn't matter. In this case I selected *-14*. *-14* in two's complement code is equal *10010* and this number we must write in *ABCDE* cells. We can see, that *-14* has five bits, so we create also *I*, *II*, *III*, *IV*, *V* and fill this part with zeros: <br/>
![ba2](https://user-images.githubusercontent.com/43972902/106907392-7e341180-66fe-11eb-9ce9-128b3eb1345f.png)
5. The algorithm is to shift our number (*-14*) to the right when it is done it means that we have found a solution, so we should underline it (our number), for convenience, to know when is the end. Additionally, we must, after this red line add zero. <br/>
![ba3](https://user-images.githubusercontent.com/43972902/106909334-7aa18a00-6700-11eb-8eed-9039eab331a8.png)
6. Now a very important thing. There are several rules that govern what we do. To know what to do, look at the two numbers that are between the red dotted line. <br/>
![ba4](https://user-images.githubusercontent.com/43972902/106910571-a40ee580-6701-11eb-99b0-43e36259af7e.png)
7. In our case we have 0 and 0, it means that we should shift the number to the right one position. If we have a zero on the left side, we add next zero, as in this case. After shifting we should underline our number, for convenience, to know when wll be the end. 
![bas1](https://user-images.githubusercontent.com/43972902/107104979-648cea00-6824-11eb-8305-7ded72d37362.png)

#### Multiply and Accumulate
**Multiply and Accumulate (MAC)** - consists in multiplying the contents of two registers and adding third value and after this three operations save result to another register, most often the accumulator. *MAC* is the basic operation of signal processors. This operation is performed in one instruction cycle. For instance, the instruction: <br/>
`MAC A, B, C`, <br/>
will perform the operation: <br/>
`A = A + (B×C)` <br/>
In a processor with an accumulator architecture, MAC operations will use the accumulatoras the destination register, so the instruction: <br/>
`MAC B, C` <br/>
Will perform the operation: <br/>
`ACC = ACC + (B×C)` <br/>

### ALU Flags <a name="aluflag"></a> [UP↑](#tof)
#### Zero Flag <a name="zeroflag"></a> [UP↑](#tof)
The **zero flag** is a single bit flag that is a central feature on most conventional (pol. *standardowy/klasyczny*) CPU architectures (including *x86*, *ARM*, *PDP-11*, *68000*, *6502*, and numerous others). It is often stored in a dedicated register, typically called *status register* or *flag register*, along with other flags. The zero flag is typically abbreviated **Z** or **ZF**. The zero flag is used to check the result of an arithmetic operation, if is set to *1*, then arithmetic result is *zero*. In most processors, the zero flag is mainly used in conditional branch instructions.

#### Overflow Flag <a name="overflowflag"></a> [UP↑](#tof)
It is good to know when the result of an addition or multiplication is larger than the maximum result size. For this *overflow flag* is used to indicate when an arithmetic overflow has occurred in an operation, indicating that the signed two's-complement result would not fit in the number of bits used for the result. 

#### Carry/Borrow Flag <a name="carborflag"></a> [UP↑](#tof)
**Carry flag** (usually indicated as the C flag) - is used to indicate when an arithmetic carry or borrow (pol. *pożyczać*) has been generated for the most significant bit position in ALU.

#### Comparisons Flag <a name="compflag"></a> [UP↑](#tof)
Many ALUs need to compare data and determine if a value is greater tha nor less than another value. A comparison in a processor can typically be performed by a subtraction operation. If the result is a positive number, the first item is greater than the second item. If the result is a negative number, the first item is less than the second.

### Single Cycle Processors <a name="singlecycpr"></a> [UP↑](#tof)
Single-cycle processors: an instruction is fetched from memory, it's executed, and the results are stored, all in a single clock cycle. Single-cycle processors are the most simple in terms (in terms - *w odniesieniu*) of hardware requirements, and they are easy to design. Unfortunately, they tend to (tend to - *mają tendencję do*) have poor data throughput (poor data throughput - *słaba przepustowość danych*), and require long clock cycles (slow clock rate) in order to perform all the necessary computations in time. Why single-cycle processors need long clock cycles? Because you need to consider the longest possible delay in the processor. This means that some instructions (typically the arithmetic instructions) will complete quickly, and time will be wasted each cycle. Other instructions (typically memory read or write instructions) will have a much longer propagation delay.

#### Critical path
![cruticalpath](https://user-images.githubusercontent.com/43972902/107860107-ca3d2f80-6e3d-11eb-93a6-609849a61b4f.png)

As you can see in the picture, the instruction will finish when all 5 components work. This means that the length of the cycle must be the length of the longest instruction. The longest path from one end of the processor to the other is called the **critical path** and is used to determine the cycle time. <br/> <br/>
Summarizing: </br> 
Single-cycle processors suffer from poor speed performance. Control signals and data must pass completely through the processor in one cycle, it means that cycle times need to be long, and many parts of the hardware are inactive for most of the cycle. 

### Multi Cycle Processors <a name="multicycpro"></a> [UP↑](#tof)
Multi-cycle processors break up the instruction into its fundamental parts, and executes each part of the instruction in a different clock cycle. Since signals have less distance to travel in a single cycle, so the cycle times can be sped up. <br/>
Typically, an instruction is executed over at least 5 cycles, which are named as such:
- IF - fetch (pol. *sprowadzać*) the instruction from memory,
- ID - decode the instruction, and generate the necessary control signals,
- EX - feed the necessary control signals into the ALU and produce a result,
- MEM - read from memory,
- WB - write the result back to the register file or to memory.

In a multicycle processor, a single ALU can be used to update the instruction pointer (in the *IF* cycle), perform the operation (in the *EX* cycle), and calculate a necessary memory address (in the *MEM* cycle). 

### Pipelined Processors <a name="pipelineproc"></a> [UP↑](#tof)
*Pipelining Philosophy*: <br/>
- Use multi-cycle methodologies to reduce the amount of computation (pol. *obliczen*) in a single cycle.
- Shorter computations per cycle allow for faster clock cycles.
- Throughput (pol. *wydajność*) is increased by having instructions complete more frequently.

#### Pipelining Hardware
Okay, it's simple. We have a processor which is made from many elements. Pipelining is about making every element in the processor do some work. In *pipelinig* is about that every element in the processor does some work. We don't want any part of the CPU to be unemployed. 
![pipel](https://user-images.githubusercontent.com/43972902/107888389-371efb00-6f0c-11eb-93a3-1b0df87ce6b3.png)

As this diagram above shows, each element in the processor is active in every cycle. Rows represent instructions, so we have in this case five instructions loaded to our CPU, and every instruction is divided by five parts. Ok, but what extra do we need to implement this? The answer is adding storage registers between each pipeline state to store the partial results between cycles.
![pipel2](https://user-images.githubusercontent.com/43972902/107888542-27ec7d00-6f0d-11eb-9cef-8e38821b8c57.png)

It's easy, between each item such as *IF*, *ID* or *WB* we must add additional storage register to remebmer last result. <br/>
If we have 5 instructions, we can show them in our pipeline using different colors. In the diagram below, white corresponds to a NOP, and the different colors correspond to other instructions in the pipeline. Each stage, the instructions shift forward through the pipeline.
![pipel3](https://user-images.githubusercontent.com/43972902/107888593-a2b59800-6f0d-11eb-813c-e326cb3beb3f.png)

Pipelined processors generate the same results as a one-instruction-at-a-time processor does when running the same software -- they just generate those results much more quickly.

#### Superpipeline

Superpipelining is the technique of raising the pipeline depth in order to increase the clock speed and reduce the latency of individual stages. If the ALU takes three times longer than any other module, we can divide the ALU into three separate stages, which will reduce the amount of time wasted on shorter stages. <br/>
In different words. Super-pipelining is the breaking of stages of a given pipeline into smaller stages (thus making the pipeline deeper). Superpipelined machines can do only one instruction per cycle, but they have cycle times shorter than the time required for any operation. <br/>
It is not uncommon for modern high-end processors to have more than 20 pipeline stages.

### Superscalar Processors <a name="superscalar"></a> [UP↑](#tof)
In a superscalar design, the processor actually has multiple datapaths, and multiple in-structions can be exectuted simultaneously, one in each datapath. <br/>
Ok, but in brief what is difference between superscalar and pipeline processor? <br/>
- **Pipelining** divides an instruction into steps, and since each step is executed in a different part of the processor.
- **Superscalar design** involves the processor being able to do multiple instructions in a single clock. <br/>
We're talking about within a single core -- multicore processing is different. They're almost always used together. <br/>

![scalar](https://user-images.githubusercontent.com/43972902/108430477-b892c800-7241-11eb-9b34-dda94b0fa48e.png)

We can see in the picture above, that we have two instructions in the same time, In all the stages highlighted in green are executing simultaneously.

### VLIW Processors <a name="vilw"></a> [UP↑](#tof)
*VLIW* - *Very Long Instruction Words*. In this srchitecture also instructions can be executing simultaneously. So what is difference between *VLIW* and *Superscalar*. <br/>
In a *superscalar design*, the microprocessor will have multiple independant execution units. An instruction scheduler determines which instructions will be executed on which execution unit, at what time. This scheduler unit requires large amounts of additional hardware complexity. VLIW is similar to superscalar architecture except that instead of using scheduling hardware to map instructions to available execution units, instructions for all units are provided in every instruction word. The scheduling is performed by the compiler at compile time. The term VLIW comes from the fact that multiple instructions typically requires large instruction words. If each instruction is 32 bits (including opcode, source and destination registers, etc), and the processor has 4 execution cores, then the total instruction word length is 128 bits long!

### Vector Processors <a name="vectorproc"></a> [UP↑](#tof)
*Vector processors*, or (like [SIMD](#https://en.wikipedia.org/wiki/SIMD)) processors are microprocessors that are specialized for operatingon vector or matrix data elements. These processors have specialized hardware for performing vector operations such as vector addition, vector multiplication, and other operations. <br/>
Modern graphics processors tend to (pol. *mają tendencję do*) be vector-based processors. Modern Intel-based chips also have *Vector Processors* capabilities known as [SSE](#https://en.wikipedia.org/wiki/Streaming_SIMD_Extensions) or [MMX](#https://en.wikipedia.org/wiki/MMX_(instruction_set)) operations. 

### Multicore Processors <a name="multicore"></a> [UP↑](#tof)
Taking the idea of superscalar operations to the next level, it is possible to put multiple microprocessor cores onto a single chip, and have the cores operatein parallel with one another. 

#### Symmetric Multi-core
A symmetric multi-core processor is one that has multiple cores on a single chip, and all of those cores are identical. Each core has the same capabilities, so it requires that there is an arbitration unit to give each core a specific task. Software that uses techniques like [multithreading](#https://en.wikipedia.org/wiki/Multithreading_(computer_architecture)) makes the best use of a multi-core processor. For example *Intel Core 2*. The Core 2 can have either 2 cores on chip (*Core 2 Duo*) or 4 cores on chip (*Core 2 Quad*). Each core in the *Core 2* chip is symmetrical, and can function independently of one another. <br/>
Another example *symmetric multi-core* is [Parallax Propeller](#https://en.wikipedia.org/wiki/Parallax_Propeller). The *Parallax Propeller* has 8 cores on chip, each one a 32-bit RISC processor. Each core in the *Parallax Propeller* chip is symmetrical, and can function independently of one another.

#### Asymmetric Multi-core
An asymmetric multi-core processor is one that has multiple cores on a single chip, but those cores might be different designs. For instance, there could be 2 general purpose cores and 2 vector cores on a single chip. <br/>
An example of this type a processor could be *IBM’s Cell*. *IBM’s Cell* processor, used in the Sony PlayStation 3 video game console is an asymmetrical multi-core processor. The Cell has 9 processor cores on board, one general purpose processor, and 8 data-processing cores. The one multipurpose core, known as the *Power Processor Element (PPE)* controls the communication between the other cores, and distributes computing tasks to the other cores for processing. The other 8 cores are known as *Synergistic Processor Elements (SPE)*, and are specially designed to have high floating-point throughput, especially with vector operations.

| ![asmulti](https://user-images.githubusercontent.com/43972902/114079823-ee9c1200-98aa-11eb-941f-9943fff735b1.png) |
|:--:|
| *Notice how the SPE cores only connect to the PPE, and not to each other. Notice also that the PPE core is much larger then the individual SPE cores.* |

Another example *asymmetric multi-core* is *Kilocore*. The [Kilocore](#https://en.wikipedia.org/wiki/Kilocore) has one general purpose processor, a PowerPC processing core, and either 256 or 1024 data processing cores on-chip. The cores are designed to run at extremely low power, so the overall chip is faster and yet uses less power than typical desktop CPU.

### Exceptions <a name="exceptions"></a> [UP↑](#tof)
*Exceptions*, are situations where the processor needs to stop executing the current code because of an error. In these cases, the processor typically begins running an exception handling routine to resolve the error, and then returns to the normal program flow. For instance, if the *ALU* attempts to divide by zero, or if an addition causes overflow, an exception might be triggered. 

### Interrupts <a name="interrupts"></a> [UP↑](#tof)
An interrupt is a condition that causes the microprocessor to temporarily work on a different task, and then later return to its previous task. <br/> 
What happens when external hardware requests another interrupt while the processor is already in the middle of executing the *ISR* for a previous interrupt request? When the first interrupt was requested, hardware in the processor causes it to finish the current instruction, disable further interrupts, and jump to the interrupt handler. The processor ignores further interrupts until it gets to the part of the (until it gets to the part of the - *dopóki nie dotrze do części*) ”return from interrupt” instruction, which re-enables interrupts.

### Hazards <a name="hazards"></a> [UP↑](#tof)
A hazardis an error in the operation of the microcontroller, caused by the simultaneous execution of multiple stages in a pipelined processor.

#### Data Hazards
Data hazards are caused by attempting to access data or modify data simultaneously. There are three basic types of data hazards:
1. **Read After Write (RAW)** <br/> In these type of hazards, the read process happens after the write process, although (pol. *mimo że*) both processes happen in the same clock cycle.
2. **Write After Read (WAR)** <br/> The write from a previous instruction will not complete before the successive (pol. *kolejny*) read instruction. This means that the next value read will be a previous value,not the correct current value.
3. **Write After Write (WAW)** <br/> WAW hazards occur when two processes try to write to a data storage element at thesame time.
4. 
**Race condition** or **race hazard** - it will be easy to explain with an example. Consider, for example, a two-input AND gate with a logic signal *A* on one input and its negation, *NOT A*, on another input:

![hazardrace](https://user-images.githubusercontent.com/43972902/113597925-b394a700-963c-11eb-954e-415611f53d85.png)

In theory the output (*A* AND *NOT A*) should never be true. If, however, change the value of *A* take longer to propagate to the second input than the first when *A* changes from false to true then a short period will ensue during (will ensue during - *nastąpi w trakcie*) which both inputs are true, and so the gate's output will also be true. Using different words... We have two inputs in our gate: *A* and *NOT A*. Imagine that we have logic *1* on our input (*A* and *NOT A*). Before we get result we have short time when the result is wrong, because we have *NOT* gate, which need a few time to prepare the result. 

**Control Hazard** - *Control hazard* occurs when we have *branch* instructions. <br/>
**Structural Hazard** - it occurs when two separate instructions attempt to access a particular hardware module at the same time. <br/>
#### Fixing Hazards
##### Stall
A *stall* (pol. **ugrzęznąć**), or a ”bubble” in the pipeline occurs when the control unit detects that a hazard will occur. When this happens, the control unit stops the instruction fetch mechanism and puts *NOP*s into the pipeline instead. In this way, the sensitive instructions will be forced to occur alone, without any other instructions being processed at the same time. 

![bubhazard](https://user-images.githubusercontent.com/43972902/113710180-ada5d100-96e3-11eb-9487-12132382aebb.png)

In this image we can see ”bubbles” drawn where data hazards occur. A bubble signifies that the instruction has stalled in the pipeline until a previous instruction completes. Notice in this image that the yellow instruction stops at the ID stage for 2 cycles, while thered instruction continues.

##### Forwarding
When an result from one instruction is using as the input to the *ALU* in the next instruction, we can use **forwarding** to move data directly from the ALU output into the ALU input of the next cycle, before that data has been written to the register. In this way, we can avoid the need for a *stall* in these situations, but at the expense of adding anadditional *forwarding unit* to control this mechanism.

##### Register renaming
Register renaming - Przemianowanie rejestrów <br/>
Register renaming is a renaming technique that separate logical registers from physical registers. Every logical register has a set of physical registers associated with it. While a programmer in assembly language refers for instance to a logical register *accu*, the processor transposes (pol. *przeniesc*) this name to one specific physical register on the fly. The physical registers are opaque (pol. *nieprzejrzysty*) and cannot be referenced directly but only via the canonical names. Register renaming can be used to prevent hazards caused by *out-of-order execution* (OOOE). <br/>
**Out of order execution (OOOE)** is when a processor is capable of executing instructions out of their original order, in an attempt to do more work in parallel, and execute programs more quickly.

##### Speculative execution
Speculative execution - Wykonywanie spekulatywne (ale beznadziejnie brzmi po polsku) <br/>
It's the ability of pipelined microprocessors, which can execute instruction which is directly after conditional jump, even is not yet known whether occur (I mean that conditional jump can occur or not). Using different words. Some task can be done before it is known whether it is actually needed. However, if the guess is right, no time is wasted and the processor continues operation as normal. [Speculative multithreading](https://en.wikipedia.org/wiki/Speculative_multithreading) is a special case of speculative execution. 

##### Branch delay
A branch delay is an **instruction written in the assembly code** after the branch, that is designed to execute whether the branch is taken or not. If there are no instructions that can be executed without a dependency (pol. *zależność*) on the branch, then a NOP should be inserted instead.

##### Branch Predication
In this type of fixing hazards all instructions, or most instructions in the ISA maybe conditionally executed based on some conditions. In other words, the instruction will be loaded from memory, decoded, and then the processor will determine whether or not toexecute it (so I think instruction will be load to pipeline and after that will consider whether to execute this instruction). Branch predication is very closely related to speculative execution. **Branch prediction is the act of guessing about the direction a branch instruction will take.** In modern processors, branch prediction will frequently look at the history of recent branches to determine how to guess the outcome of a future branch. A branch predictor typically acts like a counter. Every time a branch is taken, the counter is incremented, and every time a branch is not taken, the counter is decremented. We can treat a branch predictor like a finite-state-machine (FSM).

### Performance Metrics <a name="PerfMetr"></a> [UP↑](#tof)

#### Runtime
Runtime is the time it takes to run a program. For any program running on any computer: <br/>
`time per program = clock period * cycles per instruction * instructions executed per program` <br/>
If you can reduce any one of those factors, then the time will be shorter, it means better.

##### Clock rate
Clock rate (often called ”clock speed”) is one of the easiest to measure performance metrics.

##### Cycles per Instruction
*CPI* is a throughput (pol. *wydajność*) measure of how many instructions are completed (on average) for agiven number of clocks. A CPU that can complete, on average, 2 instructions per cycle (a *CPI* of 0.5) may have a 20 stage pipeline. 

#### Instructions executed per program
If the program you need to run is a binary executable, this number can’t be changed. Early CPU designers attempted to reduce this number by adding new, more complicated instructions, that did more work. (Later this idea was called *CISC*). When a given program (perhaps a benchmark program) is re-compiled for this new instruction set and executed, it requires fewer total executed instructions to finish. Alas, these more complicated instructions often require more cycles to execute - or worse, a longer clock period, which slows down every instruction - so the net benefit was not as great as was hoped. 

Most CPUs in mobile electronics - cell phones, laptops, wireless keyboards, MP3 players, etc. - are **underclocked**. Why do people deliberately clock them at a rate far below their potential runtime performance? Because clocking them any faster **waste battery life**.

### Memory-Level Parallelism <a name="mlp"></a> [UP↑](#tof)
**Memory-Level Parallelism (MLP)** is the ability to perform multiple memory transactions at once. The possibility of multiple read at once is more common than multiple write at once, because of the risk of potential conflicts (trying to write two different values to the same location).

















