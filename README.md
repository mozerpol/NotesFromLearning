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
There are a few thingsthat we need to consider:
- Is this processor RISC, CISC, or VLIW?
- How long is a machine word?
- How do you deal with immediate values? What kinds of instructions can accept immediate values?

finish later: CREATE ISA !!!!!!!!


