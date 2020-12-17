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

| ![von1](https://user-images.githubusercontent.com/43972902/102547890-255eda00-40ba-11eb-92a2-02efd58b855e.png) |
| ![von2](https://user-images.githubusercontent.com/43972902/102547956-3dcef480-40ba-11eb-956e-d3d3e922b339.png) |
|:--:|
| Source: *https://www.computerscience.gcse.guru/theory/von-neumann-architecture*  [17.12.2020] |

### Harvard Architecture
Computer architecture with separate storage and signal pathways for instructions and data. Many DSPs are modified Harvard architectures.
| ![harvard](https://user-images.githubusercontent.com/43972902/102548963-b1253600-40bb-11eb-8fd0-b68952f707c7.png) |
|:--:|
| Source: *https://en.wikipedia.org/wiki/Harvard_architecture*  [17.12.2020] |





last page: 17 
