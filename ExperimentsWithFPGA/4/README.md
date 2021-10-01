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
