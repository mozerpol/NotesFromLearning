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
[Control Hazard](https://web.cs.iastate.edu/~prabhu/Tutorial/PIPELINE/controlHaz.html)) - (pol. *konflikt sterowania*) - disturbance of the processing sequence at branching.
The reduction of this problem can be achived by using the prediction of branching (jumps). The prediction can be static (based on the command code analysis) or dynamic (based on processing history - branching chance analysis). 

#### Methods of increasing the efficiency of pipeline processing in case of conditional jump instruction:
1. Program fragment caching - consists in storing a program fragment in the processor's cache memory. This method is useful for handling loops. If the buffer is large enough to accommodate all loops, these commands only need to be fetched once. 
2. out-of-order execution
3. branch prediction

[Data Hazard](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#Data_hazards) - (pol. *konflikt danych*) - simultaneous use of the same data.
[Struktural Hazard](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#Structural_hazards) - (pol. *konflikt zasobow*) - simultaneously requesting access to memory or other unique resource in the computer.

Nice link about pipelining [18.12.2020]: https://cs.stanford.edu/people/eroberts/courses/soco/projects/2000-01/risc/pipelining/index.html

last page: 21




















