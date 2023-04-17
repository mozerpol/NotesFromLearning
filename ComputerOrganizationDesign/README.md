# Computer Organization and Design The Hardware/Software Interface: RISC-V Edition 2018
_____________

## Table of contents <a name="tof"></a>
1. [Computer Abstractions and Technology](#1)
   1. [](#11)

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



