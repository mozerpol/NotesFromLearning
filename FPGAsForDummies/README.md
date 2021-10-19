# FPGAs for dummies
Notes from reading book about FPGA, based on Intel (formerly Altera) devices.

### Table of contents <a name="tof"></a>
1. [Chapter 1](#1)
2. [Chapter 2](#2)
3. [Chapter 3](#3)
4. [Chapter 4](#4)

### Chapter 1 <a name="1"></a>
**ASSP** - Application-specific standard product - is an integrated circuit
that implements a specific function which can be used in many differend apps for
many people. As opposed to ASICs that combine **a collection of functions and
are designed by or for one customer**, so in case of ASIC or FPGA you can
exactly the hardware you need, instead of having to use the ASSP, all your
competitors are using.

In very simple words, what is FPGA purpose - it's a semiconductor device on
which the function can be defined after manufacturing.

ASIC vs. ASSP - An application-specific integrated circuit (ASIC) is an
integrated circuit composed of electrical components, such as transistors,
capacitors, and resistors then is customized for a particular use.
Application-specific standard products (ASSPs), on the other hand, are ICs that
are dedicated to a specific application market and sold to more than one user
in contrast to ASICs, which are designed for, and sold to, a single customer.

**Boolean algebra** - is the branch of algebra in which the values of the
variables are the truth values *true* and *false*. The main operations of
Boolean algebra are:
- conjunction (and) denoted as ∧
- disjunction (or) denoted as ∨
- the negation (not) denoted as ¬

Boolean algebra was introduced by George Boole in 1847.

**ASIC** - Application-specific integrated circuit - is an integrated circuit (IC)
chip customized for a particular use. For example, the CPU inside your phone is
an ASIC. It is meant to function as a CPU for its whole life. Its logic function
cannot be changed to anything else because its digital circuitry is made up of 
**permanently** connected gates and flip-flops in silicon. Application-specific 
standard product (ASSP) chips are intermediate between ASICs and industry 
standard integrated circuits like the 7400 series. Designers of digital ASICs 
often use a hardware description language, such as Verilog or VHDL, to describe 
the functionality of ASICs.

FPGA vs ASIC comparison summary: <br/>
|FPGA: |ASIC: |
|:--:|:--:|
|Reconfigurable circuit.|Permanent circuitry.|
|Design is specified using hardware description languages (HDL).|Same as for FPGA. |
|Easier entry-barrier. One can get started with FPGA development for as low as USD $30.|Very high entry-barrier in terms of cost, learning curve, liaising with semiconductor foundry etc. |
|Limited in operating frequency compared to ASIC of similar process node. |ASIC fabricated using the same process node can run at much higher frequency than FPGAs.|
|	Analog designs are not possible with FPGAs. Although FPGAs may contain specific analog hardware such as PLLs, ADC etc, they are not much flexible to create for example RF transceivers. |ASICs can have complete analog circuitry, for example WiFi transceiver, on the same die along with microprocessor cores. This is the advantage which FPGAs lack. |
|Preferred for prototyping and validating a design or concept. Many ASICs are prototyped using FPGAs themselves|It is not recommended to prototype a design using ASICs unless it has been absolutely validated.|

|![image](https://user-images.githubusercontent.com/43972902/137637407-2c2c7aea-36c7-483a-aabe-2b6b99770503.png)|
|:--:|
|FPGA vs ASIC Cost Analysis|
|Source: *https://numato.com/blog/differences-between-fpga-and-asics/*|

### Chapter 2 <a name="2"></a>
**FinFET** - fin (pol. *płetwa*) field-effect transistor, just different type of
MOSFET. These devices have been given the generic name "FinFETs" because the
source/drain region forms fins on the silicon surface. FinFET is a type of 
non-planar (pol. *niepłaskie*) transistor, or "3D" transistor. The FinFET 
devices have significantly faster switching times and higher current density 
than planar CMOS.

|![image](https://user-images.githubusercontent.com/43972902/137792590-76412dc9-6dfd-4472-a137-d6551f08cae1.png)|
|:--:|
| A double-gate FinFET device |
|Source: *https://en.wikipedia.org/wiki/FinFET* |

**Modern design flow of FPGAs** <br/>
1. Reference design - FPGA designs often start from this step. It represents a 
technical blueprint of a system that is intended for others to copy. Reference 
designs contain the essential elements of the system. 
2. Creating a functional block diagram, something like this below: <br/>

| ![image](https://user-images.githubusercontent.com/43972902/137794149-cb284567-5a76-4169-81f3-941d9e409c57.png) |
|:--:|
|Simplistic view of the system design flow|
| Source: *FPGAs for dummies p. 18* |

- First you define the requirements
- Create the archi-tecture of the system - determine the components you need to
implement
- Implement the system using the architecture you planned out
- Verify that the system meets all the requirements <br/> <br/>
*Middleware* - is a type of computer software that provides services to
software applications beyond those available from the operating system. It can 
be described as "software glue". In other words, middleware is a layer of 
software that doesn’t implement the core functionality of the product, but
instead, provides a layer that implements an industry standard or protocol. 

3. Replacing functional blocks with existing IP <br/>
FPGA manufacturers have been including such common functionality or intellectual 
property (IP) into their products. This IP can be in the form of hardware built
into the chip, software provided to the user, or — just for FPGAs — hardware
designs that the user can drop into the programmable logic.
4. Coding the missing blocks <br/>
*Soft IP* - is anything made from the generic logic fabric (LUTs, logic blocks,
etc.) in the FPGA. The capability for soft IP is what makes an FPGA an FPGA. <br/>
*Hard IP* - is anything that is circuitry that is hard-wired and etched (pol. 
*wytrawiony*) into silicon to do only one thing and do it well. Things like 
processors, DSP blocks, and high speed transceivers.
5. Verifying the system design
6. Mapping the system into FPGA hardware
7. Trying out the design in the system

### Chapter 3 <a name="3"></a>
During system design we can ask some questions, such as: <br/>
- What does the system have to do? - actually this is the fundamental question.
The answer to this question is often provided by the product manager.
- Can I use my existing design with changes?
- How much of the system can I leave in software? - The amount of the system 
that can be left in software determines what types of hard-ware can be used.
- How much hardware can I buy? -  Many times, a functional block of your system
design may already be implemented in a commercially available hardware device 
(known as *off-the-shelf*). If that’s the case, it may be more economical to
purchase this hardware, or license it as IP, rather than implement the design 
in software or design custom hardware.
- Does it work yet? - The next fundamental question, and must be answered “Yes” 
before the system can be deployed. 

The design process for FPGAs is an iterative one, you start with an idea of the
system and then refine the idea into definitions of transactions. A transaction 
would include input, processing, and output. <br/>
|![image](https://user-images.githubusercontent.com/43972902/137987470-d830f7f1-9771-4cc8-8b5d-072828160c20.png)|
|:--:|
| Defining system requirements |
|Source: *FPGAs for dummies p. 27*|

After you define the transactions, you implement them, and then verify that they 
work and meet the functions and con-straints you established at the start. 


