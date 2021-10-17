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

