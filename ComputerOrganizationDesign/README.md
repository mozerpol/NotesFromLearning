# Computer Organization and Design The Hardware/Software Interface: RISC-V Edition 2018
_____________

## Table of contents <a name="tof"></a>
1. [1. Computer Abstractions and Technology](#1)
   1. [1.2 Eight Great Ideas in Computer Architecture](#12)
   2. [1.4 Under the Covers](#14)
   3. [1.5 Technologies for Building Processors and Memory](#15)
   4. [1.6 Performance](#16)
   5. [1.7 The Power Wall](#17)
   6. [1.8 The Sea Change: The Switch from Uniprocessors to Multiprocessors](#18)
   7. [1.9 Real Stuff: Benchmarking the Intel Core i7](#19)
   8. [1.10 Fallacies and Pitfalls](#110)
2. [2. Language of the Computer](#2)
   1. [2.2 Operations of the Computer](#21)
   2. [2.3 Operands of the Computer Hardware](#22)
   3. [2.4 Signed and Unsigned Numbers](#23)
   4. [2.5 Representing Instructions in the Computer](#24)
   5. [2.6 Logical Operations](#25)
   6. [2.7 Instructions for Making Decisions](#26)
   7. [2.8 Supporting Procedures in Computer Hardware](#27)
   8. [2.9 Communicating with People](#28)
   9. [2.10 RISC-V Addressing for Wide Immediates and Addresses](#29)
   10. [2.11 Parallelism and Instructions: Synchronization](#210)
   11. [2.12 Translating and Starting a Program](#211)
   12. [2.13 A C Sort Example to Put it All Together](#212)
   14. [2.14 Arrays versus Pointers](#213)
   15. [2.15 Advanced Material: Compiling C and Interpreting Java](#214)
   16. [2.16 Real Stuff: MIPS Instructions](#215)
   17. [2.17 Real Stuff: x86 Instructions](#216)
   18. [2.18 Real Stuff: The Rest of the RISC- V Instruction Set](#217)
   19. [2.19 Fallacies and Pitfalls](#218)
3. [3. Arithmetic for Computers](#3)
   1. [3.1 Introduction](#31)
   2. [3.2 Addition and Subtraction](#32)
   3. [3.3 Multiplication](#33)
   4. [3.4 Division](#34)
   5. [3.5 Floating Point](#35)
   6. [3.6 Parallelism and Computer Arithmetic: Subword Parallelism](#36)
   7. [3.7 Real Stuff: Streaming SIMD Extensions and Advanced Vector Extensions in x86](#37)
   8. [3.8 Going Faster: Subword Parallelism and Matrix Multiply](#38)
   9. [3.9 Fallacies and Pitfalls](#39)
4. [4. The Processor](#4)
   1. [4.1 Introduction](#41)
   2. [4.2 Logic Design Conventions](#42)
   3. [4.3 Building a Datapath](#43)
   4. [4.4 A Simple Implementation Scheme](#44)
   5. [4.5 An Overview of Pipelining](#45)
   6. [4.6 Pipelined Datapath and Control](#46)
   7. [4.7 Data Hazards: Forwarding versus Stalling](#47)
   8. [4.8 Control Hazards](#48)
   9. [4.9 Exceptions](#49)
   10. [4.10 Parallelism via Instructions](#410)
   11. [4.11 Real Stuff: The ARM Cortex-A53 and Intel Core i7 Pipelines](#411)
   12. [4.12 Going Faster: Instruction-Level Parallelism and Matrix Multiply](#412)
   13. [4.13 Advanced Topic](#413)
   14. [4.14 Fallacies and Pitfalls](#414)
5. [5. Large and Fast Exploiting Memory Hierarchy](#5)

## 1. Computer Abstractions and Technology <a name="1"></a>

### 1.2 Eight Great Ideas in Computer Architecture <a name="12"></a>

**systems software** - Software that provides services that are commonly useful,
including operating systems, compilers, loaders, and assemblers.

**operating system** - Supervising program that manages the resources of a
computer for the benefit of the programs that run on that computer.

**compiler** - A program that translates high-level language statements into
assembly language statements.

**binary digit** - Also called a bit. One of the two numbers in base 2 (0 or 1)
that are the components of information.

**instruction** - A command that computer hardware understands and obeys.

**assembler** - A program that translates a symbolic version of instructions into
the binary version.

**assembly language** A symbolic representation of machine instructions.

**machine language** - A binary representation of machine instructions.

**high-level programming language** - A portable language such as C, C++, Java,
or Visual Basic that is composed of words and algebraic notation that can be
translated by a compiler into assembly language.

### 1.4 Under the Covers <a name="14"></a>
**It is a super important:**
the hardware in any computer performs the same basic functions: inputting data,
outputting data, processing data, and storing data.

**input device** - A mechanism through which the computer is fed information,
such as a keyboard.

**output device** - A mechanism that conveys the result of a computation to a
user, such as a display, or to another computer.

The five classic components of a computer are input, output, memory, datapath,
and control, with the last two sometimes combined and called the processor.
The datapath performs the arithmetic operations, and control tells the datapath,
memory, and I/O devices what to do according to the wishes of the instructions
of the program.

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/bfd5442f-6113-4110-822a-e1a62e342b62)|
|:--:|
|*The organization of a computer, showing the five classic components*|

**central processor unit (CPU)** - Also called processor. The active part of the
computer, which contains the datapath and control and which adds numbers, tests
numbers, signals I/O devices to activate, and so on.

**datapath** - The component of the processor that performs arithmetic
operations.

**control** - The component of the processor that commands the datapath, memory,
and I/O devices according to the instructions of the program.

**memory** - The storage area in which programs are kept when they are running
and that contains the data needed by the running programs.

**cache memory** - A small, fast memory that acts as a buffer for a slower,
larger memory.

Cache is built using a different memory technology, static
random access memory (SRAM). SRAM is faster but less dense,
and hence more expensive, than DRAM SRAM and
DRAM are two layers of the **memory hierarchy**.

**instruction set architecture** - Also called architecture. The
instruction set architecture includes anything programmers need to
know to make a binary machine language program work correctly,
including instructions, I/O devices, and so on. Typically, the
operating system will encapsulate the details of doing I/O,
allocating memory, and other low-level system functions so that
application programmers do not need to worry about such details.

**application binary interface (ABI)** -
The user portion of the instruction set plus the operating system
interfaces used by application programmers. It defines a standard
for binary portability across computers.

In other words: <br/>
**API: Application Program Interface** - This is the set of public
types/variables/functions that you expose (pol. *ujawnic*) from your
application/library. In C/C++ this is what you expose in the header files
that you ship with the application.

**ABI: Application Binary Interface** - This is how the compiler builds an
application. It defines things (but is not limited to):
- How parameters are passed to functions (registers/stack).
- Who cleans parameters from the stack (caller/callee).
- Where the return value is placed for return.
- How exceptions propagate

**implementation** - Hardware that obeys (pol. *przestrzega, zgodny z...*) the
architecture abstraction.

Secondary memory forms the next lower layer of the memory hierarchy.

**main memory** - Also called primary memory. Memory used to hold programs
while they are running; typically consists of DRAM in today’s computers.

**secondary memory** - Nonvolatile memory used to store programs and data between
runs. Typically consists of flash memory in PMDs and magnetic disks in servers.

### 1.5 Technologies for Building Processors and Memory <a name="15"></a>

Figure below shows the growth in DRAM capacity since 1977.

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/ccb14549-1cf8-488b-a79c-9ef60f6dd92a)|
|:--:|
|Growth of capacity per DRAM chip over time|

### 1.6 Performance <a name="16"></a>
Firstly we should define what is performence. For everyone it can be something
different. For example datacenter managers often care about increasing
throughput or bandwidth - the total amount of work done in a given time.
From another hand as an
individual computer user, you are interested in reducing response time — the
time between the start and completion of a task—also referred to as execution
time.

Hence, in most cases, we will need different performance metrics as well as
different sets of applications to benchmark personal mobile devices,
which are more focused on response time, versus servers, which are
more focused on throughput.

**response time** -
Also called **execution time**. The total time required for the
computer to complete a task, including disk accesses, memory
accesses, I/O activities, operating system overhead, CPU execution
time, and so on.

**throughput** -
Also called **bandwidth**. Another measure of performance, it is the
number of tasks completed per unit time.

Decreasing response time almost always improves throughput. Thus, in many real
computer systems, changing either execution time or throughput often affects the
other. <br/>
To maximize performance, we want to minimize response time or
execution time for some task. Thus, we can relate performance and
execution time for a computer X: <br/>
| ![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/7e4788a1-2edc-46dd-a254-a0cf4e202706) |
|:--:|
|Performance|

Example: <br/>
If computer A runs a program in 10 seconds and computer B runs
the same program in 15 seconds, how much faster is A than B? <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/4ee9d10a-15c5-4855-9d45-3055c8e84bf1)

Thus the performance ratio is: <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/b09a4402-bf8a-4261-b7de-bcf3ff7fb470)

and A is therefore 1.5 times as fast as B. Time is the measure of computer
performance: the computer that performs the same amount of work in the least
time is the fastest. Program *execution time* is measured in seconds per program.

For consistency, we maintain a distinction between performance
based on *elapsed time* and that based on CPU *execution time*. We
will use the term system performance to refer to *elapsed time* on an
unloaded system and CPU performance to refer to user *CPU time*.

Difference between *elapsed time* and *cpu time*:
**CPU Time** is the quantity of processor time taken by the process. This does not
indicate duration. **Elapsed Time** represents the total duration of the task. If
a given task uses a parallelism of 8 (i.e. 8 threads), and each thread is used
at a rate of 100% over the entire duration of the task, CPU time could be
8000ms, while *elapsed time* would only be 1000ms.

Therefore, shorter **elapsed time** indicates faster response time. You may want
shorter CPU time and longer elapsed time if you are concerned about CPU
pressure, and don't care about user experience. You may accept longer **CPU time**
if that results in a drop in elapsed time, since that might indicate the
user is waiting less, at the expense of higher CPU utilization.

Elapsed real time is always greater than or equal to the CPU time for computer
programs which use only one CPU for processing. If no wait is involved for I/O
or other resources, elapsed real time and CPU time are very similar.

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/a198844a-2796-4a70-be28-37aa5506cd1a)|
|:--:|
|A simple formula relates the most basic metrics (clock cycles and clock cycle time) to CPU time|

This above formula makes it clear that the hardware designer can
improve performance by reducing the number of clock cycles
required for a program or the length of the clock cycle.

**Clock cycles per instruction** - (CPI) is the average number of clock cycles
each instruction takes to execute.
Since different instructions may take different amounts of time depending on
what they do, CPI is an average of all the instructions executed in the program.
CPI provides one way of comparing two different implementations of the identical
instruction set architecture, since the number of instructions executed for a
program will, of course, be the same.

**instruction count** - The number of instructions executed by the program:
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/2678a276-f077-47db-802d-5b078bbcecb1)

or

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/8ed73ae9-42f0-4afb-8e57-5357a3aa1692)

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/95dc7659-bbab-41aa-88ce-123207cb7279)|
|:--:|
|The basic components of performance and how each is measured|

**Remember, though, that individually the factors do not determine
performance: only the product, which equals execution time, is a
reliable measure of performance.** <br/>
**Always bear in mind that the only complete and reliable
measure of computer performance is time.**

Some designers invert CPI to talk about IPC, or instructions per clock cycle.
If a processor executes on average two *instructions per clock cycle*,
then it has an IPC of 2 and hence a CPI of 0.5.

### 1.7 The Power Wall <a name="17"></a>
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/ce4fd1b9-885b-4987-bcda-a0b3d9f7220e)|
|:--:|
|Clock rate and power for Intel x86 microprocessors over eight generations and 30 years|

The modern problem is that further lowering of the voltage
appears to make the transistors too leaky, like water faucet (pol. *kran*) that
cannot be completely shut off. Even today about 40% of the power
consumption in server chips is due to leakage.

### 1.8 The Sea Change: The Switch from Uniprocessors to Multiprocessors <a name="18"></a>
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/4aaa6ac5-3d25-4bca-b4dd-709e7d111700)|
|:--:|
|Growth in processor performance since the mid-1980s|


### 1.9 Real Stuff: Benchmarking the Intel Core i7 <a name="19"></a>
**SPEC** (System Performance Evaluation Cooperative) is an effort
funded and supported by a number of computer vendors to create
standard sets of benchmarks for modern computer systems. In 1989,
SPEC originally created a benchmark set focusing on processor
performance (now called SPEC89), which has evolved through five
generations.

Below are describes the SPEC integer benchmarks and their
execution time on the Intel Core i7 and shows the factors that
explain execution time: <br/>
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/b73a0ac6-759e-4e8d-a4e3-c9747ffe9ae6)|
|:--:|
|SPECINTC2006 benchmarks running on a 2.66 GHz Intel Core i7 920|

### 1.10 Fallacies and Pitfalls <a name="110"></a>

- fallacies - błędy
- pitfalls - płapki

**Amdahl’s Law** - the performance improvement that can be gained through
parallel processing is limited by the part of a system that's inherently
sequential -- that is, the set of operations that must be run in series.
Amdahl’s Law, together with the CPU performance equation, is a handy tool for
evaluating possible enhancements. Amdahl’s Law is also used to argue for
practical limits to the number of parallel processors.

**MIPS** - million instructions per second - A measurement of program execution
speed based on the number of millions of instructions. MIPS is computed as the
instruction count divided by the product of the execution time and 10^6.

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/f048b694-7c67-41fe-8152-305ea72ae561)

There are three problems with using MIPS as a measure for
comparing computers. First, MIPS specifies the instruction
execution rate but does not take into account the capabilities of the
instructions. **We cannot compare computers with different
instruction sets using MIPS**. <br/>
**Second, MIPS varies between programs on the
same computer; thus, a computer cannot have a single MIPS rating.**
Relationship between MIPS, clock rate, and CPI:<br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/58790ae2-d610-4d8f-86e2-e56508a14876)

## 2. Language of the Computer <a name="2"></a>
**ISA** - Instruction Set Architecture - Instruction Set - is part of the
abstract model of a computer that defines how the CPU is controlled by the
software. The ISA acts as an interface between the hardware and the software.
On this model consists of:
- instruction listings - the set of instructions that the processor can execute,
- data types - kind and range,
- addressing mode - way to transfer data from registers to memory and vice versa,
- set of registers available for the developer,
- rules for handling threads and interrupts.

The various types of instruction sets include the following:
- **Complex instruction set computer** - CISC processors have an additional
microcode or microprogramming layer where instructions act as small programs. A
single instruction can initiate multiple actions by the computer, such as a
single add command launching multiple memory access load and store instructions.
- **Reduced instruction set computer** - RISC
- **Enhancement instruction sets**. These instruction types are more familiar
because they are often used in marketing CPUs. Examples of this go back to the
166-megahertz Intel Pentium with MultiMedia Extensions (MMX) technologies. It
was introduced in 1996 and marketed with enhanced (pol. *wzmocniony*) Intel CPU
multimedia performance. MMX refers to the extended instruction set.

### 2.2 Operations of the Computer <a name="21"></a>
*word* - natural unit of data used by a particular processor design. Can be any
set value, common word size values included: 16, 18, 24, 32, 36, 40, 48, and 64.

Instruction **ld** - *load doubleword*

**alignment restriction** - a requirement that data be aligned in memory on
natural boundaries. RISC-V and Intel x86 do not have alignment restrictions, but
MIPS does.

**spilling registers** - many programs have more variables than computers have
registers. Consequently, the compiler tries to keep the most
frequently used variables in registers and places the rest in
memory, using loads and stores to move variables between
registers and memory. The process of putting less frequently used
variables (or those needed later) into memory. This process is called spilling
registers.

### 2.3 Operands of the Computer Hardware <a name="22"></a>


### 2.4 Signed and Unsigned Numbers <a name="23"></a>


### 2.5 Representing Instructions in the Computer <a name="24"></a>



### 2.6 Logical Operations <a name="25"></a>

### 2.7 Instructions for Making Decisions <a name="26"></a>


### 2.8 Supporting Procedures in Computer Hardware <a name="27"></a>







### 2.9 Communicating with People <a name="28"></a>
### 2.10 RISC-V Addressing for Wide Immediates and Addresses <a name="29"></a>
### 2.11 Parallelism and Instructions: Synchronization <a name="210"></a>
### 2.12 Translating and Starting a Program <a name="211"></a>
### 2.13 A C Sort Example to Put it All Together <a name="212"></a>
### 2.14 Arrays versus Pointers <a name="213"></a>
### 2.15 Advanced Material: Compiling C and Interpreting Java <a name="214"></a>
### 2.16 Real Stuff: MIPS Instructions <a name="215"></a>
### 2.17 Real Stuff: x86 Instructions <a name="216"></a>
### 2.18 Real Stuff: The Rest of the RISC- V Instruction Set <a name="217"></a>
### 2.19 Fallacies and Pitfalls <a name="218"></a>

## 3. Arithmetic for Computers <a name="3"></a>

### 3.1 Introduction <a name="31"></a>
### 3.2 Addition and Subtraction <a name="32"></a>
### 3.3 Multiplication <a name="33"></a>
### 3.4 Division <a name="34"></a>
### 3.5 Floating Point <a name="35"></a>
### 3.6 Parallelism and Computer Arithmetic: Subword Parallelism <a name="36"></a>
### 3.7 Real Stuff: Streaming SIMD Extensions and Advanced Vector Extensions in x86 <a name="37"></a>
### 3.8 Going Faster: Subword Parallelism and Matrix Multiply <a name="38"></a>
### 3.9 Fallacies and Pitfalls <a name="39"></a>

## 4. The Processor <a name="4"></a>

### 4.1 Introduction <a name="41"></a>
### 4.2 Logic Design Conventions <a name="42"></a>
### 4.3 Building a Datapath <a name="43"></a>
### 4.4 A Simple Implementation Scheme <a name="44"></a>
### 4.5 An Overview of Pipelining <a name="45"></a>
### 4.6 Pipelined Datapath and Control <a name="46"></a>
### 4.7 Data Hazards: Forwarding versus Stalling <a name="47"></a>
### 4.8 Control Hazards <a name="48"></a>
### 4.9 Exceptions <a name="49"></a>
### 4.10 Parallelism via Instructions <a name="410"></a>
### 4.11 Real Stuff: The ARM Cortex-A53 and Intel Core i7 Pipelines <a name="411"></a>
### 4.12 Going Faster: Instruction-Level Parallelism and Matrix Multiply <a name="412"></a>
### 4.13 Advanced Topic <a name="413"></a>
### 4.14 Fallacies and Pitfalls <a name="414"></a>

## 5. Large and Fast Exploiting Memory Hierarchy <a name="5"></a>
