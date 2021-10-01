## Eksperymenty z FPGA (5)
*Elektronika Praktyczna* Nr 4 (327) • 04.2020

This issue is about *UART* - Universal Asynchronous Receiver/Transmitter. We
three lines: *gnd*, *tx* and *rx*, which must be crossed. They can work
independently, so is possible to communicate in both directions (full-duplex). 
The single frame is presented below: <br/>
| ![image](https://user-images.githubusercontent.com/43972902/134699903-b9f9b657-81c6-4500-b85e-43e11f726c26.png) |
|:--:|
| *UART frame* |
| Source [24.09.21]: *https://developer.electricimp.com/resources/uart* |

As we can see we have 10 bits. 8 bits for data and 1 start bit and 1 stop bit.
Of course we have more variations of UART frame, but I think this is one of the
most popular. <br/>
The speed is given in *Baud*, it means the number of changes in one second. The
speed is differen, but the most popular is 9660 baud or 115200 Bd, so it means
respectively that one state takes 104 µs and 8.68 µs. And thanks to this we can
conclude that the max bandwith is 7.5 kib/s and 90 kib/s. <br/>

I don't understand a little bit this part, but from what I understood, on the 
FPGA we can have a lot of different modules, like *UART* or *SPI* and this
modules should have a possibility to communicate between each other. We have a
lot of different standarts which can help to communicate btween modules like 
*AXI*, *Avalon* or *Wishbone*. I'll try shortly describe each of them.
1. *AXI* <br/> AXI - Advanced eXtensible Interface. Is a parallel communication 
interface. We have a few stantards of *AXI* like *AXI4*, *AXI4-Lite* and 
*AXI4-Stream*. This specification is freely available from *ARM*. <br/> Nice
article about this on 
[wikipedia](https://en.wikipedia.org/wiki/Advanced_eXtensible_Interface) and
[AMBA® AXI™ and ACE™ ProtocolSpecification](http://www.gstitt.ece.ufl.edu/courses/fall15/eel4720_5721/labs/refs/AXI4_specification.pdf) 
in pdf.
2. *Avalon* <br/> The Avalon interface  allowing to easily connect components 
in Intel FPGA. The Avalon interface family defines seven interfaces:
- Avalon Streaming Interface (Avalon-ST) - an interface that supports the 
	unidirectional flow of data, including multiplexed streams, packets, and DSP 
	data.
- Avalon Memory Mapped Interface (Avalon-MM) - an address-based read/write 
	interface typical of Host-Agent connections.
- Avalon Conduit Interface - an interface type that accommodates individual 
	signals or groups of signals that do not fit into any of the other Avalon 
	types. You can connect conduit (pol. *rura, przejście*) interfaces inside a
	Platform Designer system. Alternatively, you can export them to connect to 
	other modules in the design or to FPGA pins.
- Avalon Tri-State Conduit Interface (Avalon-TC) - an interface to support 
	connections to off-chip peripherals. Multiple peripherals can share pins 
	through signal multiplexing, reducing the pin count of the FPGA and the 
	number of traces on the PCB.
- Avalon Interrupt Interface - an interface that allows components to signal 
	events to other components.
- Avalon Clock Interface - an interface that drives or receives clocks.
- Avalon Reset Interface - an interface that provides reset connectivity.

[Avalon® Interface Specifications](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/manual/mnl_avalon_spec.pdf) in pdf.

3. *Wishbone* <br/> The Wishbone Bus is an open source hardware computer bus
intended to let the parts of an integrated circuit communicate with each other. 
The aim is to allow the connection of differing cores to each other inside of a 
chip. Wishbone is open source. The 
[Simple Bus Architecture](https://en.wikipedia.org/wiki/Simple_Bus_Architecture)
is a simplified version of the Wishbone specification. Article on 
[wikipedia](https://en.wikipedia.org/wiki/Wishbone_(computer_bus)) and 
[Wishbone B4](https://cdn.opencores.org/downloads/wbspec_b4.pdf) specification 
from *opencores.org*.

In this project we'll use *AXI-Stream*. <br/>
| ![image](https://user-images.githubusercontent.com/43972902/135598763-b4b1d829-7232-41cd-ad3d-15f93a01bb2d.png) |
|:--:|
| *Connection of the transmitter to the source* |
| Source: *Elektronika Praktyczna 04.2020, p. 99* |

Above we have connection source date to our transmitter. <br/>
The first line is *data*, it's for just pass data. In our case it'll be 8-bit 
vector, which allow to transfer one fram in one clock cycle. <br/>
The second is *valid*. If is high state on this pin then we know that our
informations are correct and we should handle the data. <br/>
The third is *ready*. Thanks to this line, slave inform master that can accept
next portion of data.
