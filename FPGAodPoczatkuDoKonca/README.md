# FPGAodPoczatkuDoKonca
In this repo I will post my private notes from reading a series of two articles
from [elektronikab2b](https://elektronikab2b.pl/) website. They are written in
my native language (Polish).

## FPGA od początku do końca - część pierwsza
[Here](https://elektronikab2b.pl/technika/1315-fpga-od-poczatku-do-konca-czesc-pierwsza)
is the link to the first article. <br/>
An extension of the acronym *VHDL* is *Very High Speed Integrated Circuit
Hardware Description Language*. <br/>
Below is picture of the [LUT](https://electronics.stackexchange.com/questions/169532/what-is-an-lut-in-fpga):

| ![obraz](https://user-images.githubusercontent.com/43972902/116738433-b80d6f00-a9f2-11eb-984f-3b2807ed8838.png) |
|:--:|
| *A typical logical element* |
| source: *https://pl.wikipedia.org/wiki/Bezpo%C5%9Brednio_programowalna_macierz_bramek#/media/Plik:Logic_block2.svg [30.04.2021]* |

FPGA mainly consists many of this type of elements. Inside this elements are
connected together. There are many of different types of connections between
logic elements, such as *fuse*, *antifuse* or based on transistors. Type *fuse*
and *antifuse* cannot be changed after programming, but connections created with
transistors can be reprogrammed.

### FPGA can be divided according to the type of technology used to remember their configuration:
#### Antifuse type
This type of device allows to only program them only once. It's an old
technological type. <br/>
Device consists a lot of fuses inside which can only work after burnout
(typically it's resistor 300 Ω). For this reason, the data in this type of FPGA
can't be change. Due to their design, they are the safest systems. Almost all
reverse engineering attempts to read the configuration of such a system are
unsuccessful (it's virtually impossible). It should be noted, that by default
the antifuse devices allow to read the saved configuration in order to test the
correctness of the programming process, but after setting a special security
bit, access to the internal configuration is blocked. Antifuse FPGAs are even
more reliable than ASICs. <br/>
The lack of internal transistors responsible for the configuration, makes these
circuits much less susceptible (pol. *podatny*) to radiation damage. Thanks to
it, this type of device is using in aeronautics or aviation where FPGAs based on
*SRAM* or *Flash* memory will be too insecure. Also these types of devices are
also still used by the military, due to high resistance to an EMP
(electromagnetic pulse) from nuclear weapons. <br/>
*Antifuse* devices, due to the lack of configuration transistors, consume much
less static power than the *SRAM* or *Flash* circuits manufactured in the same
technology. This value is about 20% of the power consumed by the reprogrammable
circuit. What's more, the lack of transistors also means no delays introduced by
them, thanks to which the entire system is able to run much faster. <br/>
A very important advantage is that such devices are very durable (pol.
*wytrzymałe*). The internal connectivity of antifuse components and networks is
practically impossible to break without the destruction of the device, board or
component. This makes devices highly reliable. <br/>
Big disadvantages of this system is high development costs and must to use a
few steps less advanced technological process. Imagine situation when any
errors are discovered... ;D <br/>
Thanks to this advantages of *antifuse* FPGA over other technologies are losing
importance.

#### SRAM type
This type of device is based on static memory technology, because of this lose
their configuration after a power loss. Unlike (pol. *w odróżnieniu*) *antifuse*
devices, these can be programmed multiple times. These deviecs don't require any
additional technological processes, so these systems are designed based on the
most advanced technologies. <br/>
Unfortunately, *SRAM* chips are volatile, so it's necessary to load the
configuration code inside the chip every time when the system boots up.
Configuration code is load from a special non-volatile memory chip such as EPROM
or Flash. This additional requirement makes it necessary to reserve more space
on the PCB surface. <br/>
In addition, the process of uploading the program takes some time, which delay
the start of the device. These data can be easily read, which makes the project
easy to decode and duplicate on other devices.

#### Flash type
*Flash* device combine the advantages of *SRAM* and *antifuse* devices. <br/>
These devices remember the code, so there are no delays during startup. Their
internal structure is less complicated than that *SRAM* devices, so they can be
packed more densely (pol. *gęsto*). <br/>
Due to the production problems, these systems are usually several generations
older than their counterparts (pol. *odpowiedniki*) produced at the same time,
which only require the use of methods typical for CMOS. <br/>
Another disadvantage is the increased static power consumption, which is due to
the pull-up resistors.

### Logical structure
**Logic element** (for the manufacturer Altera) and **logic cell** (for the
manufacturer Xilinx). *Logic element* and *logic cell* is exactly the same, but
they have different names due to the manufacturers. <br/>
They're a fundamental building block of FPGA, the *LE* is duplicated hundreds
or thousands of time. <br/>
A *logic cell* is basically a small lookup table (*LUT*), a D flip-flop and a
2-to-1 mux (to bypass the flip-flop if desired). The *LUT* can implement any
logic function. *Logic blocks* typically contain a few *logic-cells*.
*LUT* has typically a few inputs, example below: <br/>

| ![obraz](https://user-images.githubusercontent.com/43972902/116868997-20856780-ac10-11eb-8720-86b9b0f7e967.png) |
|:--:|
| Logic-cell (LUT) example |
| source: *https://breadboardgremlins.files.wordpress.com/2013/01/logic-cell.png?w=640 [03.05.2021]* |

A typical cell consists of a 4-input *LUT*, a Full adder (FA) and a D-type
flip-flop. In recent years, manufacturers have started moving to 6-input *LUTs*.
Each *logic cell* can be connected to other *logic cells* through interconnect
resources (wires/muxes placed around the logic cells). Each cell can do little,
but with lots of them connected together, complex logic functions can be
created. <br/>
A typical *LUT* matrix can be converted to *16-bit RAM*, so it can be seen as
additional memory - as long as it has no other logical function. Due to the way
this memory is implemented, it is often referred as *distributed RAM*, to
distinguish (pol. *rozróżnić*) it from typical built in memory blocks inside
FPGAs.

#### LUT <a name="lut"></a>
*LUT* - lookup table - is basically a table that determines what the output is
for any given input(s). Below we have example of simple two-dimensional (2D)
lookup table: <br/>

| ![obraz](https://user-images.githubusercontent.com/43972902/116984759-df528d80-accb-11eb-994c-bff5c67559de.png) |
|:--:|
| source: *https://help.goldsim.com/Modules/5/ImagesExt/image19_91.png* [04.05.2021] |

It's just simple array. In this case input will be *Mass* and *Length* and
output will be one value from table. Why are we using this? Imagine that we have
very complicated mathematical formula and calculating the result can be very
time consuming. So we can use the table where we put the results we calculated
earlier this allow us to search the table for the appropriate input to find the
result without computing. So imagine that in our case we have "*Mass*: 200" and
"*Length*: 40", so the result is "8.6". Sometimes searching the table is much
faster than calculating the result. <br/>
Examples of faster use of look-up tables than the calculation of the result:
- error correction
- linearization
- [wave table](https://en.wikipedia.org/wiki/Wavetable_synthesis#Table-lookup_synthesis)

Simple exaple of *LUT* is the truth table in combinational logic. <br/>
The *LUT* in an FPGA holds a custom truth table, which is loaded during
configuration device. Think of the *LUT* as a small RAM. Instead of wiring up a
bunch of logic gates that create the desired truth table, we can create own
truth table. <br/>
*LUT-Mask* - the way the FPGA fills the table's output values. So the same
physical *LUT* can implement `Y=AB` and `Y=AB'`, but the *LUT-Mask* is
different, because the truth table is different. <br/>
In conclusion, we can build our own table for a complex mathematical function,
which would work much faster than actually calculating the value by following an
algorithm.

## FPGA od początku do końca - część druga
[Here](https://elektronikab2b.pl/technika/1468-fpga-od-poczatku-do-konca-czesc-druga) is a link to the second part of the article.

Sometimes can be found on the *FPGA* board additional hardware, to increase
performance. It can be RAM blocks, subsystems that perform the most frequently
performed operations (as
[MAC](https://en.wikipedia.org/wiki/Multiply%E2%80%93accumulate_operation)
blocks), hard cores or soft cores.

### Built-in hard cores
There are two options for placing hard cores on the FPGA board. <br/>
First is the location of the microcontroller outside the area where the logical
cells are located - as shown in the figure below:
| ![obraz](https://user-images.githubusercontent.com/43972902/116869973-fc2a8a80-ac11-11eb-9899-db0d3f656ef8.png) |
|:--:|
| *FPGA with the microcontroller core placed outside of the semiconductor structure or on a separate structure* |
| source: *https://elektronikab2b.pl/images/9/9/3/22993-41963technika_fpga2_8.jpg* [03.05.2021] |

This can be made not only as a single silicon chip, but also as two or more
integrated circuits connected to each other and closed in a single package.
The separation of the classic part of FPGA from additional functions integrated
in the same package makes it easier the use of programming tools. The designer's
task is to assign the appropriate output ports in such a way that the desired
signals are transferred between the microcontroller and the rest of the system.

Second option is placing the cores inside the main area of the FPGA, and for
their operation as input and output use adjacent (pol. *sąsiadujący*) blocks of
memory and logical cells. We can see idea of this in the picture below:
| ![obraz](https://user-images.githubusercontent.com/43972902/116870049-14020e80-ac12-11eb-884b-a1bbdc3719a2.png) |
|:--:|
| *FPGA with the microcontroller core placed inside of the semiconductor structure* |
| source: *https://elektronikab2b.pl/images/9/9/4/22994-41964technika_fpga2_9.jpg* [03.05.2021] |

### Built-in soft cores
Another type of core is the one created by software. The synthesizable core
modules are sold by many different companies, so a very frequent procedure is to
buy licenses for already existing projects. Programmable cores can be customized
according to the user's needs, which was not possible with hard cores. The
designer can practically freely change the width of the data bus or the size and
number of registers, and even implement any number of the same or different
cores inside one FPGA.

### Clock signal management
*Jitter* - instability of the edges of the clock signal, the deviation of a
clock edge from its ideal position in time. Simply speaking, it is the inability
of a clock source to produce a clock with clean edges. So the parameters of the
clock signal are very important for the efficiency/correctness of the entire
system. To avoid jitter inside FPGA clock lines are designed in a tree-like
manner (pol. *w sposób podobny do drzewa*), to minimize possible clock delays
that can occur. <br/>
Due to the possibility of implementing functionally separate logical units
inside one system, as well to enable the reduction of energy consumption,
producers created *clock domains* - areas clocked with the different clock. This
allows the clock signal to be turned off for a small group of cells in the
system, so the current consumed by all device is lower. In addition, every
*clock domain* can operate at different frequencies, thanks to this, one *clock
domain* can work with different clock than other in the same time. <br/>
The clock signal can be input through any of the pins of the circuit, but in
order to ensure its optimal work, you should use the designated ports for this.

#### PLL <a name="pll"></a>
*PLL* - *Phase Locked Loop* (pl. *pętla synchronizacji fazy*) - in electronics
is an electronic system based on a feedback loop for automatic frequency
control. The simplest *PLL* is an electronic circuit consisting of a variable
frequency oscillator (VCO) as clock source, a loop filter and a phase detector
in a feedback loop. The oscillator generates a periodic signal, and the phase
detector compares the phase of that signal with the phase of the input periodic
signal, adjusting the oscillator to keep the phases the same. In different
words, the VCO clock is divided by an integer divider and then compared to a
reference clock which is input to the *PLL*. The compare result as phase/
frequency difference is converted into a voltage which controls the VCO. This
converter normally is a simple low pass filter. It is called “loop filter”.<br/>
| ![obraz](https://user-images.githubusercontent.com/43972902/117001738-0072a880-ace3-11eb-91c2-cc9f48ffb58c.png) |
|:--:|
| *Simplest analog phase locked loop* |
| source: *https://en.wikipedia.org/wiki/Phase-locked_loop#/media/File:Phase_locked_loop.svg* [04.05.2021]|

In the feedback loop we can put also a frequency divider: <br/>
| ![obraz](https://user-images.githubusercontent.com/43972902/117005834-fef7af00-ace7-11eb-9862-f7a25f69967a.png) |
|:--:|
|*Simplest analog phase locked loop with a frequency devider*|
|source: *https://www.design-reuse.com/news_img/20070705_cologne1.gif* [04.05.2021] |


*PLLs* are used for 3 different tasks:
- generation of high speed on chip clocks by frequency multiplication. This type
are only used for generation of high speed stable clocks and are normally fed by
quartz controlled oscillators so that there is no need for a jitter suppression
(pol. *tłumienie drgań*, tych negatywnych).
- clock wave correction to reduce clock skew (pol. *krzywy*),
- jitter suppression (pol. *tłumienie drgań*, tych negatywnych).

A PLL is characterized by the frequency range, jitter, jitter attenuation and
lock time. The jitter of the VCO and so the jitter of the output frequency is
due to different mechanisms. The lock time of a PLL is defined as the time that
elapses (pol. *upływa*) from initial or reset condition till to the correct
output frequency. <br/>
Nowdays PLLs are mixed-mode circuitries, that must combine analog parts as loop
filter and VCO with digital parts as the frequency divider. So analog circuitry
must be adapted to every new CMOS process technology and it's very difficult,
because is hard to reduce the size of the loop filter, because a capacitor of
significant size is needed.

### Input/output systems
Another important parameter of programmable deices are the input/output ports.
FPGA input and output ports were divided into blocks. Each block can work with a
different voltage, so there is no need to use pull-up resistors on the PCB to
communicate with devices working in different standards. <br/>
Another part of the input/output devices are special serial interfaces designed
to transmit a differential signal (pol. *sygnał różnicowy*).

### Manufacturers' offer
In addition to the previously described program blocks (as built-in soft cores),
which are entire microcontrollers or microprocessors, it is possible to use
various types of smaller functional blocks. These blocks are available in two
forms:
1. As *soft IP* version - written in hardware description languages such as VHDL
or Verilog. These modules can be implemented in devices of any company.
2. As *firm IP* version - modules that have already been adapted to a specific
family of FPGAs. These blocks contain a description of the connections and cell
configurations of a given programmable device and their field of application is
limited.
