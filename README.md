# Microprocessor-Design
Notes from reading the Microprocessor Design book which is availble on the wiki 
https://upload.wikimedia.org/wikipedia/commons/7/71/MicroprocessorDesign.pdf

### Processor classification

#### Purpose
1. general purpose - typical processor, which is designed to be integrated into a larger system with peripherals and external RAM.
2. DSP - is a chip that is specifically designed for fastarithmetic operations, especially addition and multiplication.
3. Embedded Controller or microcontroller - **not microprocessor**, it's microprocessor with additional hardware integrated into a single chip. 
4. Programmable State Machine - it's minimalist microprocessor that is designed for very small and simple operations. Usually it's embedded directly into thedesign of a larger chip.
#### Type of use
1. Signal Processing - Signal processing systems typically need to have low latency (latency - *czas oczekiwania*), and are very deadline driven (deadline driven - *terminowy*). An example of a signal processing applicationis the decoding of digital television and radio signals.
2. Real Time Applications - timing is ofthe utmost (utmost - *najwyzszy*) importance. An example of a real-time system is the anti-lock braking system(ABS) controller in modern automobiles.
3. Throughput and Routing - An example is an internetrouter, that reads in data packets and sends them out on a different port. (Throughput - *wydajnosc*)
4. General Computing - general purpose processor is like the kind of processor that is typically found insidea desktop PC.

Assembly Language - small language that contains a short word or ”mnemonic” foreach individual command that a microcontroller can follow. Each command gets a singlemnemonic, and each mnemonic corresponds to a single machine command. Assembly lan-guage gets converted (by a program called an ”assembler”) into the binary machine code. Examples of ISA:
- ARM
- IA-32 (Intel x86)
- MIPS 
- Motorola 68K
- PowerPC
- Hitachi SH
- SPARC

Moore’s Law - the number of transistors on a single chip at the same price will double every 18 to 24 months. This law has held without fail since it wasoriginally stated in 1965. Moore’s Law has been used incorrectly to calculate the speed of an integrated circuit. <br/>
The amount of work that aprocessor can complete in a single cycle is measured in ”cycles per instruction”. For somesystems, such as MIPS, there is 1 cycle per instruction. For other systems, such as modernx86 chips, there are typically very many cycles per instruction.
### Von Neumann Architecture (a.k.a. Princeton)
It was developed for [ENIAC](https://en.wikipedia.org/wiki/ENIAC). It uses the same memory and data paths for both program and data storage. In other words Von Neumann architecture is based on the stored-program computer concept, where instruction data and program data are stored in the same memory.

 ![von1](https://user-images.githubusercontent.com/43972902/102547890-255eda00-40ba-11eb-92a2-02efd58b855e.png) 
| ![von2](https://user-images.githubusercontent.com/43972902/102547956-3dcef480-40ba-11eb-956e-d3d3e922b339.png) |
|:--:|
| Source: *https://www.computerscience.gcse.guru/theory/von-neumann-architecture*  [17.12.2020] |

### Harvard Architecture
Computer architecture with separate storage and signal pathways for instructions and data. Many DSPs are modified Harvard architectures.
| ![harvard](https://user-images.githubusercontent.com/43972902/102548963-b1253600-40bb-11eb-8fd0-b68952f707c7.png) |
|:--:|
| Source: *https://en.wikipedia.org/wiki/Harvard_architecture*  [17.12.2020] |

**Programmer-visible registers (User-Visible Registers)** - are the registers which are used during application programming and are directly used in the instructions. For example reserved registers like *UCSRA* (for *AVR*) or general purpose registers X1, ..., x31. 

The registers are the fastest accessible memory locations, and because they are so fast, there are typically very few of them. In most processors, there are fewer than 32 registers. The size of the registers defines the size of the computer. For instance, a ”32 bit computer” has registers that are 32 bits long. The length of a register is known as the **word length** of the computer.

Factors limiting the number of registers:
- new CPU should be software-compatible with an old CPU. This requires the new chip to have exactly the same number of programmer-visible registersas the old chip.
- Doubling the number general-purpose registers requires adding another bit to each in-struction that selects a particular register. Each 3-operand instruction (that specify 2source operands and a destination operand) would expand by 3 bits. 
- Adding more registers adds more wires to the critical path, adding capacitance, which reduces the maximum clock speed of the CPU.

*General purpose registers* - registers that can be used by the programmerto store arbitrary data. <br/>
*Reserved registers* - registers thatcannot be accessed by the programmer directly.

*Microarchitectural registers (physical registers)* - registers that are not programmer-visible these registers include:
- memory address register
- memory data register
- instruction register
- microinstruction register
- microprogram counter
- pipeline registers

### Pipelining
Pipelining (*pol.* potokowość) - technology of building processors consisting in the division of the processor logic responsible for the program execution process (processor instructions) into specialized groups in such a way that each group performs a part of the work related to the execution of the instruction. These groups are linked sequentially - into a *pipe* and perform their work simultaneously download data from the previous element in the sequence. In each of these groups, the task is in a different stage of execution. Processor instruction execution phases can be as follows:
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
- instructions are executed "overlapped" (but not in parallel!). The execution of the next instruction begins before the current instruction finishes executing.
- Each block of processor is used on each clock cycle, processing different phases of different instructions. 
- The execution time for all instructions must be the same. If the instruction can be executed earlier, the processor must wait to complete instruction.
- The performance grows in a pipeline architecture over traditional architecture are proportional to the number of instruction phases.
#### Pipeline Hazards
[Control Hazard](https://web.cs.iastate.edu/~prabhu/Tutorial/PIPELINE/controlHaz.html) - (pol. *konflikt sterowania*) - disturbance of the processing sequence at branching.
The reduction of this problem can be achived by using the prediction of branching (jumps). The prediction can be static (based on the command code analysis) or dynamic (based on processing history - branching chance analysis). 

#### Methods of increasing the efficiency of pipeline processing in case of conditional jump instruction:
1. Program fragment caching - consists in storing a program fragment in the processor's cache memory. This method is useful for handling loops. If the buffer is large enough to accommodate all loops, these commands only need to be fetched once. 
2. out-of-order execution
3. branch prediction

[Data Hazard](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#Data_hazards) - (pol. *konflikt danych*) - simultaneous use of the same data. <br/>
[Struktural Hazard](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#Structural_hazards) - (pol. *konflikt zasobow*) - simultaneously requesting access to memory or other unique resource in the computer.
#### Superscalar processing
[Superscalar processing](https://en.wikipedia.org/wiki/Superscalar_processor) - (pol. *przetwarzanie superskalarne*) - it's based on the use of several scalar data processing pipelines run in parallel, which allows for the execution of more than one instruction in one clock cycle. <br/>
Nice link about pipelining [18.12.2020]: https://cs.stanford.edu/people/eroberts/courses/soco/projects/2000-01/risc/pipelining/index.html
### Cache
Most CPUs manufactured do not have any cache. The cache is used because reading external memory is very slow and reading a local cache is much faster. In modern processors, the cache can take up as much as 50% or more of the total area of the chip. Cache typically comes in 2 or 3 ”levels”, depending on the chip. Level 1 (L1) cache is smaller
and faster than Level 2 (L2) cache, which is larger and slower. Some chips have Level 3
(L3) cache as well, which is larger still than the L2 cache (although L3 cache is still much
faster than external RAM).

### Endianness
[Endianness](https://en.wikipedia.org/wiki/Endianness) - is the order or sequence of bytes of a word of digital data in computer memory. Endianness is primarily expressed as big-endian (BE) or little-endian (LE). A big-endian system stores the most significant byte of a word at the smallest memory address and the least significant byte at the largest. A little-endian system, in contrast, stores the least-significant byte at the smallest address. 

| ![endian](https://user-images.githubusercontent.com/43972902/102886883-3a3ec300-4456-11eb-8abf-990583caa77e.png) |
|:--:|
| Source: *https://en.wikipedia.org/wiki/Endianness*  [22.12.2020] |

#### NUXI problem 
NUXI problem -  Refers to the problem of transferring data between machines with differingbyte-order. The string **UNIX** might look like **NUXI** on a machine with adifferent byte sex (e.g., when transferring data from a little-endian toa big-endian, or vice-versa). [source](https://ckziumragowo.pl/pub/app/Jargon/index.php/word/NUXI+problem) 

### Stack 
**Stack** - The stack is a sequential set of memory locations that is set to act like a LIFO (last in, first out) buffer. Most computer architectures include at least a register that is usually reserved for the stack pointer.<br/>
**push** operation add data to the top of the stack <br/>
**pop** remove add data from the top of the stack <br/>
**CISC** - Complex Instruction Set Computer. The most well known/commoditized CISC ISAs are the Motorola 68k and Intel x86 architectures. <br/>
**RISC** - Reduced Instruction Set Computer. The most well known/commoditized RISC ISAs are the PowerPC, ARM, MIPS and SPARC
architectures. <br/>
**Program Counter** (PC) - a register inside the microprocessor, that contains the address of the current instruction. During the fetch cycle, the instruction from the address indicated by the program counter is read from memory into the instruction
register (IR), and the program counter is incremented by n , where n is the word length of the machine (in bytes). <br/>

Branching and Jumping is the ability to load the PC register with a new address that isnot the next sequential address. In general, a **jump** or **call** occurs unconditionally, and a **branch** occurs on a given condition. A **call** instruction is a branch instruction with the additional effect of storing the current address in a specific location, e.g. pushing it on the stack, to allow for easy return to continue execution. In many programs, ”call” is the second-most-frequently used instruction (after ”move”). 

**NOP**, short for ”no operation” is an instruction that produces no result and causes no side effects. NOPs are useful for timing and preventing hazards.

**Random Access Memory** (RAM), also known as *main memory*. Dynamic RAM (DRAM) is a type of RAM that contains a single transistor anda capacitor. DRAM is smaller than SRAM, and therefore can store more data in a smaller area. Because of the charge and discharge times of the capacitor, however, DRAM tends to be slower than SRAM. Many modern types of Main Memory are based on DRAM design because of the high memory densities. Because DRAM is simpler than SRAM, it is typically cheaper to produce.

**Static RAM** (SRAM) is a type of memory storage that uses 6 transistors to storedata. These transistors store data so long as power is supplied to the RAM and do not needto be refreshed. SRAM is typically used in processor caches because of its faster speed, but not in main memory because it takes up more space.
| ![sram](https://user-images.githubusercontent.com/43972902/103000615-ab03df00-452b-11eb-8ac3-f5ac6a4c7baa.png) |
|:--:|
| Source: *https://pl.wikipedia.org/wiki/Pami%C4%99%C4%87_statyczna*  [23.12.2020] |

Most processors and other complicated hardware circuits are typically divided into two components: a **datapath** and a **control unit**. The **datapath** contains all the hardware necessary to perform all the necessary operations. In many cases, these hardware modules are parallel to one another, and the final result is determined by multiplexing all the partial results. The **control unit** determines the operation of the datapath, by activating switches and passing control signals to the various multiplexers. In this way, **the control unit can specify how the data flows through the datapath**.

**Relative jump** - the instruction’s operand tells how many bytes the program counter should be increased or decreased. <br/> 
**Absolute jump** - the instruction’s operand is copied to the program counter; the operand is an absolute memory address where the execution should continue. 

### Design Steps microprocessor or microcontroller unit:
1. Determine the capabilities the new processor should have.
2. Lay out the datapath to handle the necessary capabilities.
3. Define the machine code instruction format (ISA)
4. Construct the necessary logic to control the datapath.
##### 1. Determine machine capabilities
Some questions to start:
1. Is this chip an embedded chip, a general-purpose chip, or a different type entirely? 
2. What, if any, are the limitations in terms of resources, price, power, or speed?
3. With that in mind, we need to ask what our chip will do:
    - Does it have integer, floating-point, or fixed point arithmetic, or a combination of allthree?
    - Does it have scalar or vector operation abilities?
    - Is it self-contained, or must it interface with a number of external peripherals?
    - Will it support interrupts? If so, How much interrupt latency is tolerable? How muchinterrupt-response jitter is tolerable?
    - We also need to ask ourselves whether the machine will support a wide array of instructions, or if it will have a limited set of instructions. More instructions make the design more difficult, but make programming and using the chip easier. On the other hand, having fewer instructions is easier to design, but can be harder and more costly to program.

Lay out the basic arithmetic operations you want your chip to have:
- Addition/Subtraction
- Multiplication
- Division 
- Shifting and Rotating
- Logical Operations: AND, OR, XOR, NOR, NOT, etc. 

List other capabilities that your machine has:
- Unconditional jumps•Conditional Jumps (and what conditions?)
- Stack operations (Push, pop)
##### 2. Design the datapath
We need to determine what ALU architecture that our processor will use:
- Accumulator
- Stack
- Register
- A combination of the above 3
##### 3. Create ISA
There are a few things that we need to consider:
- Is this processor RISC, CISC, or VLIW?
- How long is a machine word?
- How do you deal with immediate values? What kinds of instructions can accept immediate values?

A **register** is a storage element typically composed of an array of flip-flops. <br/>
A **register file** is a whole collection of registers, typically all of which are the same length. A register file takes three inputs, an index address value, a data value, and an enable signal.A signaldecoderis used to pass the data value from the register file input to the particular register with the specified address.

### Multiplexers
| ![mux](https://user-images.githubusercontent.com/43972902/103135238-38276f00-46b7-11eb-86f4-eacf6f62a873.png)|
|:--:|
| A 2-to-1 mux |
| Source: *https://en.wikipedia.org/wiki/Multiplexer*  [25.12.2020] |

A multiplexer is an input selector. A multiplexer has 1 output, a control input, and several data inputs. For ease, we number multiplexer inputs from zero, at the top. If the control signal is ”0”, the 0th input is moved to the output. If the control signal is ”3”, the 3rd inputis moved to the output.A multiplexer with *N* control signal bits can support <img src="https://render.githubusercontent.com/render/math?math=2^{N}"> inputs. For example, a multiplexer with 3 control signals can support <img src="https://render.githubusercontent.com/render/math?math=2^{3} = 8"> inputs. Multiplexers are typically abbreviated as *”MUX”*.

| ![mux441](https://user-images.githubusercontent.com/43972902/103135454-bb959000-46b8-11eb-9202-fd5b04be5052.png) |
|:--:|
| A 4-to-1 mux |
| Source: *https://en.wikipedia.org/wiki/Multiplexer*  [25.12.2020] |
<br/>
| ![81](https://user-images.githubusercontent.com/43972902/103786157-681e2d00-503c-11eb-8c88-b5e0778b5f30.png) |
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
You can find verilog file for mux [here](https://github.com/mozerpol/Microprocessor-Design/tree/main/code/multiplexer)
### Adder
An adder is a digital circuit that performs addition of numbers. They are also used in other parts of the processor, where they are used to calculate addresses, table indices, increment and decrement operators and similar operations. 
Adders can be divided into:
1. serial adder - during each operation, they add two component bits and a carry bit
2. parallel adder - they add together the bits from all positions, and the carry bit is performed depending on how the one-bit adders are connected.
    - ripple-carry adder
    - carry look-ahead adder
    
Each adder has a completion type:
- full adder
- half adder

Each full full adder consists of two half adders.

###### Half adder
The half adder adds two single binary digits A and B. It has two outputs, sum (S) and carry (C). The carry signal represents an overflow. The truth table:
| ![halfAdder](https://user-images.githubusercontent.com/43972902/103895819-492da280-50f1-11eb-8409-38ec5e2aa301.png) |
|:--:|
| Half adder |
| Source: *https://en.wikipedia.org/wiki/Adder_(electronics)*  [07.01.2021] |

| ![halfAdderDiagram](https://user-images.githubusercontent.com/43972902/103943954-45bb0b00-5133-11eb-8088-c986e5057c83.png) |
|:--:|
| Half adder logic diagram |
| Source: *https://en.wikipedia.org/wiki/Adder_(electronics)*  [07.01.2021] |

###### Full adder
Each full full adder consists of two half adders. A one-bit full-adder adds three one-bit numbers, often written as A, B, and Cin
The truth table:
| ![fullAdder](https://user-images.githubusercontent.com/43972902/103943523-86665480-5132-11eb-959d-8157e7783c7c.png) |
|:--:|
| Half adder |
| Source: *https://en.wikipedia.org/wiki/Adder_(electronics)*  [07.01.2021] |

| ![fullAdderDiagram](https://user-images.githubusercontent.com/43972902/103944001-57041780-5133-11eb-8c73-f792a7446a0d.png) |
|:--:|
| Full adder logic diagram |
| Source: *https://en.wikipedia.org/wiki/Adder_(electronics)*  [07.01.2021] |

[Here](https://github.com/mozerpol/Microprocessor-Design/tree/main/code/adder) you can find code in verilog for full and half adder.
### ALU
*ALU* - arithmetic logic unit is a combinational digital circuit that performs arithmetic and bitwise operations on integer binary numbers. The inputs to an ALU are the data to be operated on, called *operands*.
| ![alu](https://user-images.githubusercontent.com/43972902/103954812-4a88ba80-5145-11eb-9e76-ac0dcff442a6.png) |
|:--:|
| A symbolic representation of an ALU |
| Source: *https://en.wikipedia.org/wiki/Arithmetic_logic_unit*  [08.01.2021] |

**Signals:**
1. Data - A basic ALU has three parallel data buses consisting of two input operands (A and B) and a result output (Y). Each data bus is a group of signals that conveys one binary integer number. Typically, the A, B and Y bus widths (the number of signals comprising each bus) are identical and match the native word size of the external circuitry.
2. Opcode - The opcode input is a parallel bus that conveys to the ALU an operation selection code, which is an enumerated value that specifies the desired arithmetic or logic operation to be performed by the ALU. **The opcode size (its bus width) determines the maximum number of different operations the ALU can perform**; for example, a four-bit opcode can specify up to sixteen different ALU operations. **Generally, an ALU opcode is not the same as a machine language opcode**, though in some cases it may be directly encoded as a bit field within a machine language opcode.
3. Status - The status outputs are various individual signals that convey supplemental information about the result of the current ALU operation. General-purpose ALUs commonly have status signals such as: 
    - Carry-out - conveys the carry resulting from an addition operation, the borrow resulting from a subtraction operation, or the overflow bit resulting from a binary shift operation.
    - Zero - indicates all bits of Y are logic zero.
    - Negative - indicates the result of an arithmetic operation is negative.
    - Overflow - indicates the result of an arithmetic operation has exceeded the numeric range of Y.
    - Parity - indicates whether an even or odd number of bits in Y are logic one.

[Here](https://github.com/mozerpol/Microprocessor-Design/tree/main/code/alu) you can find code in verilog for simple ALU.
### Program counter
*Program counter* - is a register structure that contains the address pointer value of the current instruction. Each cycle, the value at the pointer is read into the instructionb decoder and the program counter is updated to point to the next instruction. 

**RISC computer have all the instructions are the same length.** <br/>
**In CISC computers each instruction can be a different length.**
##### Branching
Branching occurs at one of a set of special instructions known collectively as ”branch” or ”jump” instructions. During a branch, a new address for the PC is loaded, typically from the instruction or froma register. A **non-offset branch**, frequently referred to as a ”jump” is a branch where the previous PC value is discarded and a new PC value is loaded from an external source:
![branching](https://user-images.githubusercontent.com/43972902/104107763-3ec10380-52bf-11eb-93c6-7f6feb8a2031.png)

An **offset branch** is a branch where a value is added (or subtracted) to the current PC valueto produce the new value:
![branching2](https://user-images.githubusercontent.com/43972902/104107819-ceff4880-52bf-11eb-9346-53c02a36b111.png)

**Offset and Non-Offset Branching** - many systems have capabilities to use both offset and non-offset branching:
![branching3](https://user-images.githubusercontent.com/43972902/104107847-0a9a1280-52c0-11eb-910a-43b1af898596.png)

##### Microcode
*Microcode* - is a computer hardware technique that inser a layer of organisation between the CPU hardware and the programmer-visible instruction set architecture of the computer. Microcode typically resides in special high-speed memory and translates machine instructions. It separates the machine instructions from the underlying electronics so that instructions can be designed and altered more freely. The lowest layer in a computer's software stack is traditionally raw binary machine code instructions for the processor. Microcode sits one level below this. To avoid confusion, each microprogram-related element is differentiated by the micro prefix: microinstruction, microassembler, microprogrammer, microarchitecture, etc. A high-level programmer, or even an assembly programmer, does not normally see or change microcode. Some hardware vendors, especially IBM, use the term microcode as a synonym for firmware. Microprograms consist of series of microinstructions, which control the CPU at a very fundamental level of hardware circuitry. For example, a single typical horizontal microinstruction might specify the following operations: 
- Connect register 1 to the A side of the ALU
- Connect register 7 to the B side of the ALU
- Set the ALU to perform two's-complement addition
- Store the result value in register 8

Ok, once again, but using different words. The microcode usually implements the more complicated instructions - the rest is in silicon. For example: the instruction `XOR r32, r32` will be in silicon, but some inventions like PCMPISTRI will not. One of the goals of the microcode was to break down the CISC instructions into a series of pseudo-RISC instructions, which are easier to optimize (they can be changed among themselves in some cases, performed simultaneously, etc; CISC is also possible, but it is more difficult). 

##### Microarchitecture
*Microarchitecture* - also called computer organization and sometimes abbreviated as µarch or uarch, is the way a given instruction set architecture (ISA) is implemented in a particular processor. A given ISA may be implemented with different microarchitectures. **Computer architecture is the combination of microarchitecture and instruction set architecture.** Examples of Intel microarchitectures:
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

##### Machine state register
*Machine state register (MSR)* - is one of three process control registers present in the [PowerPC](https://en.wikipedia.org/wiki/PowerPC) processor architecture. 

##### Control store
*Control store* - part of a CPU's control unit that stores the CPU's microprogram. 

##### Instruction Decoder
*Instruction Decoder* - reads the next instruction from memory, and sends thecomponent pieces of that instruction to the necessary destinations. A CISC decoder is typically set up as a state machine. The RISC instruction decoder is typically a very simple device. Its purpose is to translate an instruction code into the address in the micro memory where the micro code for the instruction starts.

##### Register File
Registers are temporary storage locations inside the CPU that hold data and addresses. The register file is the component that contains all the general purpose registers of the microprocessor. A few CPUs also place special registers such as the PC and the status register in the register file. Other CPUs keep them separate. A simple register file is a set of registers and a decoder. The register file requires an address and a data input:
![registerFile](https://user-images.githubusercontent.com/43972902/104124091-08cb6000-534f-11eb-831c-a4bb5f77b26a.png)















