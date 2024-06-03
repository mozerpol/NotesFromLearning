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
Let’s put the energy and performance of registers versus memory
into perspective. Assuming 64-bit data, registers are roughly 200
times faster (0.25 vs. 50 nanoseconds) and are 10,000 times more
energy efficient (0.1 vs. 1000 picoJoules) than DRAM in 2015. These
large differences led to caches, which reduce the performance and
energy penalties of going to memory

Constant operands occur frequently. Indeed, *addi* is the most
popular instruction in most RISC-V programs.

### 2.4 Signed and Unsigned Numbers <a name="23"></a>

**least significant bit** - The rightmost bit in an RISC-V doubleword

**most significant bit** - The leftmost bit in an RISC-V doubleword

The RISC-V doubleword is 64 bits long, so we can represent 2^64
different 64-bit patterns.

More about two's complement on my other [repo](https://github.com/mozerpol/learningRISC-V#terms)

**one’s complement** - is a system in which negative numbers are represented by
the inverse of the binary representations of their corresponding positive
numbers. Just created by simple inversion. An example: <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/3eb23524-55d6-4639-824c-537e209ffb05)

**biased notation** / **offset binary** - A notation that represents the most
negative value by 00...000 and the most positive value by 11...11. Zero is
typically as the value 10...00.
An example: <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/5b5ac645-2f41-4afd-81de-413b1336cfd2)

### 2.5 Representing Instructions in the Computer <a name="24"></a>
**instruction format** - A form of representation of an instruction composed of
fields of binary numbers.

**machine language** - Binary representation used for communication within a
computer system.

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/d20f76f9-63c1-4c11-b8c6-a4de6f97ff66)

**It's super important!!!!** <br/>
I know that I didn't follow these recommendations in creating my own
implementation, but because I wanted readable (maybe only for me :D)
implementation. So... <br/>
S-type format: <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/41688db7-735b-41eb-a061-169fc80fac86)
The 12-bit immediate in the S-type format is split into two fields,
which supply the lower 5 bits and upper 7 bits. The RISC-V
architects chose this design because it keeps the rs1 and rs2 fields in
the same place in all instruction formats. Keeping the instruction
formats as similar as possible reduces hardware complexity. <br/>
In other words, in risc-v at first glance (pol. *na pierwszy rzut oka*) some
instruction families can have fields in the different order, to be more clear.
For example S-type format can have immediate value on the one field, but
creators (of risc-v arch) split it becauses they wanted to have rs1 and rs2
fields in all instructions formats at the samae place, thanks to this risc-v use
less hardware (maybe in FPGA as well). <br/>
Similarly, the opcode and funct3 fields are the same size in all
locations, and they are always in the same place.

Although RISC-V has both *add* and *sub* instructions, it does not
have a *subi* counterpart to *addi*. This is because the immediate field
represents a two’s complement integer, so *addi* can be used to
subtract constants.

### 2.6 Logical Operations <a name="25"></a>
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/f635db07-caa2-438a-b302-597a72c00208)|
|:--:|
|C and Java logical operators and their corresponding RISC-V instructions|

### 2.7 Instructions for Making Decisions <a name="26"></a>
**conditional branch** -
An instruction that tests a value and that allows for a subsequent
transfer of control to a new address in the program based on the
outcome of the test.

**basic block** - A sequence of instructions without branches (except possibly
at the end). The test for equality or inequality is probably the most popular
test, but there are many other relationships between two numbers.

### 2.8 Supporting Procedures in Computer Hardware <a name="27"></a>
**procedure** - A stored subroutine that performs a specific task based on the
parameters with which it is provided.

**jump-and-link** - instruction
An instruction that branches to an address and simultaneously
saves the address of the following instruction in a register (usually
*x1* in RISC-V).

**return address** -
A link to the calling site that allows a procedure to return to the
proper address. in RISC-V it is stored in register *x1*.

**caller** - a procedure that calls one or more more subsequent procedure(s).

**callee** - a procedure that is called by another.

**program counter (PC)** - The register containing the address of the
instruction in the program being executed.

It's important (like everything ;p) <br/>
Suppose a compiler needs more registers (than 32) for a procedure. In this case
we're using **stack**. <br/>
**stack** -
A data structure for extension registers organized as a last-in-first-out
queue. A stack needs a pointer to the most recently
allocated address in the stack to show where the next procedure
should place the registers to be taken. In RISC-V, the **stack pointer** is
register *x2*, also known by the name *sp*. <br/>
**stack pointer** -
A value denoting (pol. *oznaczac*) the most recently allocated address in a
stack that shows where registers should be taken or where old register
values can be found. Stacks are so popular that
they have their own buzzwords for transferring data to and from
the stack: placing data onto the stack is called a **push**, and
removing data from the stack is called a **pop**. <br/>
By historical precedent, stacks “grow” from higher addresses to
lower addresses. This convention means that you push values onto
the stack by subtracting from the stack pointer. <br/>
Procedures that do not call others are called *leaf* procedures.

Some RISC-V compilers reserve a register *x3* for use as the global pointer,
or *gp*.
**global pointer** -
The register that is reserved to point to the static area.

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/c4952a37-8873-489e-a729-46756e402475)|
|:--:|
|What is and what is not preserved across a procedure call|

The final complexity is that the stack is also used to store variables
that are local to the procedure but do not fit in registers, such as
local arrays or structures.
The segment of the stack containing a
procedure’s saved registers and local variables is called a
**procedure frame** or **activation record**.

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/a76dafdb-69b4-4ed2-8e64-7b41e9cd6c69)|
|:--:|
|**Illustration of the stack allocation (a) before, (b) during, and (c) after the procedure call.**|

The frame pointer (*fp* or *x8*) points to the first
doubleword of the frame, often a saved argument
register, and the stack pointer (*sp*) points to the top of
the stack. The stack is adjusted to make room for all
the saved registers and any memory-resident local
variables. Since the stack pointer may change during
program execution, it’s easier for programmers to
reference variables via the stable frame pointer,
although it could be done just with the stack pointer
and a little address arithmetic. If there are no local
variables on the stack within a procedure, the compiler
will save time by not setting and restoring the frame
pointer. When a frame pointer is used, it is initialized
using the address in *sp* on a call, and *sp* is restored
using *fp*.

Some RISC-V compilers use a *frame pointer*, or register *x8* to
point to the first doubleword of the frame of a procedure.

Figure below shows the RISC-V convention for allocation of memory when running
the Linux operating system. The stack starts in the high end of the user
addresses space and grows down. <br/>
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/5efb3ae8-ac79-4679-8632-51509c6c4818)|
|:--:|
|The RISC-V memory allocation for program and data. These addresses are only a software convention, and not part of the RISC-V architecture. |

The first part of the low end of memory is reserved, followed by the home of the
RISC-V machine code, traditionally called the **text segment**. Above the code
is the **static data segment**, which is the place for constants and other static
variables. <br/>
Arrays tend to be a fixed length and thus are a
good match to the static data segment, data structures like linked
lists tend to grow and shrink during their lifetimes. The segment for
such data structures is traditionally called the **heap**, and it is placed
next in memory.

C allocates and frees space on the heap with explicit functions.
**malloc()** allocates space on the heap and returns a pointer to it, and
**free()** releases space on the heap to which the pointer points.

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/45595dff-7a6b-4ad8-8473-7cbeb60e7212)|
|:--:|
|RISC-V register conventions|

### 2.9 Communicating with People <a name="28"></a>
TODO: Communicating with People

### 2.10 RISC-V Addressing for Wide Immediates and Addresses <a name="29"></a>

**PC-relative addressing** - An addressing regime in which the address is the
sum of the *program counter (PC)* and a constant in the instruction. <br/>
The addressing modes of the RISC-V instructions are the following:
- *Immediate* addressing, where the operand is a constant within the
instruction itself.
- *Register* addressing, where the operand is a register.
- *Base* or *displacement* addressing, where the operand is at the
memory location whose address is the sum of a register and a
constant in the instruction.
- *PC-relative* addressing, where the branch address is the sum of the
PC and a constant in the instruction.

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/e8982bff-148b-4723-82a1-6b77e7bfa6f4)|
|:--:|
|Illustration of four RISC-V addressing modes|

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/73db6916-3ad1-4613-b7a0-a0abb20e39fd)|
|:--:|
|RISC-V instruction encoding|

### 2.11 Parallelism and Instructions: Synchronization <a name="210"></a>
**data race** - Two memory accesses form a data race if they are from different
threads to the same location, at least one is a write, and they occur
one after another.

**mutual exclusion (mutex)** - is a property of process synchronization,
prevents simultaneous access to a shared resource. **Lock**
and **unlock** can be used straightforwardly to create regions where
only a single processor can operate. <br/>
One typical operation for building synchronization operations is the **atomic
exchange** or **atomic swap**, which inter-changes a value in a register for
a value in memory.

To see how to use this to build a basic synchronization primitive,
assume that we want to build a simple lock where the value 0 is
used to indicate that the lock is free and 1 is used to indicate that
the lock is unavailable. A processor tries to set the lock by doing an
exchange (pol. *wymiana*) of 1, which is in a register, with the memory address
corresponding to the lock. The value returned from the exchange
instruction is 1 if some other processor had already claimed access,
and 0 otherwise. In the latter case, the value is also changed to 1,
preventing any competing exchange in another processor from also
retrieving a 0. <br/>
For example, consider two processors that each try to do the
exchange simultaneously: this race is prevented (pol. *zapobiec*), since exactly
one of the processors will perform the exchange first, returning 0, and
the second processor will return 1 when it does the exchange. The
key to using the exchange primitive to implement synchronization
is that the operation is atomic: the exchange is indivisible
(pol. *niepodzielny*), and two
simultaneous exchanges will be ordered by the hardware. It is
impossible for two processors trying to set the synchronization
variable in this manner (pol. *sposob*) to both think they have simultaneously
set the variable. <br/>
Implementing a single atomic memory operation introduces
some challenges in the design of the processor, since it requires
both a memory read and a write in a single, uninterruptible (pol. *nieprzerwany*)
instruction.

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
The computer designer must decide how to handle arithmetic
overflows. Although some languages like C and Java ignore
integer overflow, languages like Ada and Fortran require that the
program be notified. The programmer or the programming
environment must then decide what to do when an overflow
occurs. <br/>
The speed of addition depends on how quickly the carry into the
high-order bits is computed.

### 3.2 Addition and Subtraction <a name="32"></a>

### 3.3 Multiplication <a name="33"></a>
The first operand is called the **multiplicand** and the second the
**multiplier**. The final result is called the **product**.

TODO: write how to multiply binary numbers by hand

The 64-bit multiplicand starts in the right half of the
Multiplicand register and is shifted left 1 bit on each
step. The multiplier is shifted in the opposite direction
at each step. The algorithm starts with the product
initialized to 0. Control decides when to shift the
Multiplicand and Multiplier registers and when to write
new values into the Product register: <br/>
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/608c0dea-38ff-479b-a316-8994b1bb58a8)|
|:--:|
|Very simple design which imitate the algorithm we learned in grammar school|

Faster multiplications are possible by essentially
providing one 64-bit adder for each bit of the multiplier: one input
is the multiplicand ANDed with a multiplier bit, and the other is
the output of a prior adder. <br/>
A straightforward approach would be to connect the outputs of
adders on the right to the inputs of adders on the left, making a
stack of adders 64 high. An alternative way to organize these 64
additions is in a parallel tree: <br/>
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/e506001b-6375-4391-ae12-9bb488db7316)|
|:--:|
|Rather than use a single 64-bit adder 63 times, this hardware “unrolls the loop” to use 63 adders and then organizes them to minimize delay|

### 3.4 Division <a name="34"></a>
Divide’s two operands, called the dividend and divisor, and the
result, called the quotient, are accompanied by a second result,
called the remainder.

TODO: write how to divide binary numbers by hand

We start with the 64-bit Quotient register set to 0. Each
iteration of the algorithm needs to move the divisor to the right one
digit, so we start with the divisor placed in the left half of the 128-
bit Divisor register and shift it right 1 bit each step to align it with
the dividend. The Remainder register is initialized with the
dividend: <br/>
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/9ccabcdd-1534-479c-9686-6fad5855ac7e)|
|:--:|
|Very simple design which imitate the algorithm we learned in grammar school|

TODO: Describe SRT division
TODO: Nonrestoring division algorithm

RISC-V divide instructions ignore overflow, so software must
determine whether the quotient is too large. In addition to
overflow, division can also result in an improper calculation:
division by 0. Some computers distinguish these two anomalous
events. RISC-V software must check the divisor to discover
division by 0 as well as overflow.

### 3.5 Floating Point <a name="35"></a>
**scientific notation** - is a way of expressing numbers that are too large or
too small to be conveniently written in decimal form. <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/59a92a77-963a-4d9a-95b2-1c615b57add5)

Computer arithmetic that supports such numbers is called
**floating point** because it represents numbers in which the binary
point is not fixed, as it is for integers. <br/>
A designer of a floating-point representation must find a
compromise between the size of the fraction and the size of the
exponent, because a fixed word size means you must take a bit
from one to add a bit to the other. <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/a26a7d02-99d3-4ed6-bc9f-bf7d77f23752)

The representation of a RISC-V floating-point number is shown below: <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/2a09bd3a-eb95-451a-9fa4-79a9eeb90572)

**overflow (floating-point)** -
A situation in which a positive exponent becomes too large to fit in
the exponent field. <br/>
One way to reduce the chances of underflow or overflow is to
offer another format that has a larger exponent. In C, this number is
called *double*.

**double precision** -
A floating-point value represented in a 64-bit doubleword.

**single precision** -
A floating-point value represented in a 32-bit word.

What should happen on an overflow or underflow to let the user
know that a problem occurred? Some computers signal these events
by raising an **exception**, sometimes called an **interrupt**.
The address of the instruction that overflowed is saved in a register,
and the computer jumps to a predefined address to invoke the
appropriate routine for that exception. <br/>
**RISC-V computers do not raise an exception on
overflow or underflow; instead, software can read the floating-point
control and status register (fcsr) to check whether overflow or
underflow has occurred.**

**exception** -
Also called interrupt. An unscheduled event that disrupts program
execution; used to detect overflow.

**interrupt** -
An exception that comes from outside of the processor. (Some
architectures use the term interrupt for all exceptions.)

IEEE 754 has a symbol for the result of invalid operations,
such as 0/0 or subtracting infinity from infinity. This symbol is: <br/>
*NaN* - not a number

IEEE 754 uses a bias of 127 for single precision, so an exponent of
−1 is represented by the bit pattern of the value −1+127. Biased exponent
means that the value represented by a floating-point number is
really: <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/5225980f-0ebb-41c4-999c-30a194e757ea)

An example: <br/>
What decimal number does this single precision float represent by: <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/09472558-c89d-458e-8f42-b27832d1d6a9)

Answer: <br/>
The sign bit is 1, the exponent field contains 129, and the fraction
field contains 1*2^(−2) = 1/4, or 0.25. Using the basic equation: <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/11c71afe-d339-49eb-971f-a1832614d195)

TODO: floating point addition by hand, how to do  it

First, the exponent of one operand
is subtracted from the other using the small ALU to
determine which is larger and by how much. This
difference controls the three multiplexors; from left to
right, they select the larger exponent, the significand of
the smaller number, and the significand of the larger
number. The smaller significand is shifted right, and
then the significands are added together using the big
ALU. The normalization step then shifts the sum left or
right and increments or decrements the exponent.
Rounding then creates the final result, which may
require normalizing again to produce the actual final
result: <br/>
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/77fe7550-cf12-47b5-965f-8da9bc59aad6)|
|:--:|
|Block diagram of an arithmetic unit dedicated to floating-point addition|

TODO: Floating-Point Multiplication by hand, step by step how to do it




