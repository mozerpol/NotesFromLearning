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
next portion of data. <br/>
| ![image](https://user-images.githubusercontent.com/43972902/135600946-18cccbff-1589-4953-9df9-20e09c35f4f6.png) |
|:--:|
| *Sample waveforms on the data bus, handshake is marked on pink colour* |
| Source: *Elektronika Praktyczna 04.2020, p. 100* |

Above we have sample waveforms. At the beginning we can see that *ready* is in
high state. It means that slave is ready to receive data. Thanks to this in the
next clock cycle data will appear, when *valid* goes high. **The state when 
*valid* and *ready* are simultaneously in high state is called *handshake***. In
this moment takes place data transfer from master to slave. Because of *d0* was
send, then *valid* is going to the low state. Similar situation did our
transmitter (slave on the picture). It picks up the data and started processing
them. Because of this transmitter change *ready* on the low state. <br/>
When the next data *d1* is ready, then *valid* goes high, but in this casae
transmitter (our slave) is not ready, so then master must hold on sending the
data *d1* until the data can be handled. When will occur next handshake, then
*d1* will send to slave. <br/>
As we can see on the picture, there also be situation (during sending *d2* data)
when *ready* and *valid* go high in the sime time. Then data will be handled
immediately. <br/>
When *valid* is in the low state, then value on *data* doesn't affect on 
operation of the system. <br/>
On the picture, which present our wavefomrs we have also *rst* and *clk*. I 
think it's obvious. This pins are input to master and slave. <br/>

To make easier modelling data buses in *SystemVerilog* we have construct like
*interfaces*. The syntax of interfaces are very similar to *modules*. *Interfaces*
such as *modules* can have parameters. Example of interface from this issue: <br/>
```SystemVerilog
interface StreamBus #(
		parameter N = 8
	) (
		input wire clk,
		input wire rst
	);
	logic [N-1:0] data;
	logic valid;
	logic ready;

	modport Master (
		input clk,
		input rst,
		input ready,
		output data,
		output valid
	);

	modport Slave (
		input clk,
		input rst,
		input data,
		input valid,
		output ready
	);

endinterface
```

On the bottom we have *modport*. For our interface we have two: *master* and 
*slave*. Inside them we define direction of individual lines. <br/>
After this in module definition we'll select which version of interface we would
to use. We decide about this using `StreamBus.Slave` or `StreamBus.Master`. <br/>
Example of usage our interface is below: <br/>
```SystemVerilog
module uart_tx #( 
	parameter F = 8000000,
	parameter BAUD = 115200
) (
	StreamBus.Slave bus,
	output logic tx
);
```

The next part is about **state machine**. I'll remind, that transmitter has on
the output logic 1 (I mean *tx* pin), so it's our idle. If we want transmit, 
then we must initiate trasmission by *start* bit. Then we can send data and stop
transmission and go to the idle state. So we can highlight a four states: <br/>
1. *WAIT* - wait for data,
2. *START* - send start bit, 
3. *DATA* - send data,
4. *STOP* - send stop bit.

| ![image](https://user-images.githubusercontent.com/43972902/135840178-6f3e7608-3747-443f-aca5-03506a9252ff.png) |
|:--:|
| *Transmitter state machine* |
| Source: *Elektronika Praktyczna 04.2020, p. 101* |

Now I can describe how transmitter will change its states. At the beginning 
after reset we're in *WAIT* state. Decision about next state we must consider
during each rising *clk* edge. In *WAIT* state we make decision based on 
occuring handshake, so we can check only *valid* register. <br/>
If we have a new data to send, then we can change state to *START*, otherwise
we're still in *WAIT* state. We're in *START* state until to the end of start 
bit. We'll informed about it, when the *counter2* will overflow. <br/>
In the *DATA* state we'll be to the end of sending data, it means eight *DATA*
states in our state machine. <br/>
In the *STOP* state we'll be there by the time of one symbol, I mean stop symbol
in ASCII. 

There is also math formula: <br/>
`(F+BAUD/2)/BAUD`, where: <br/>
- *F* - freq our module (for T-Core it's 50 MHz)
- *BAUD* - expected transsmision speed

Finally I decided to divided project into two parts. The first is about current
issue, the second is the UART library. I did it, because above project is written
in SystemVerilog, so I think it doesn't make any sense rewrite to on Verilog
2001 lang. So, the first part is the SystemVerilog library with full description
inside this repo and the second part, where is only working library written in
Verilog without description. <br/>
Ok, back to the main topic... <br/>

I implemented this project and everything work correct, below are waveforms from
ModelSim, you must run *sending_sim.do* to see it: <br/>
![wav](https://user-images.githubusercontent.com/43972902/136406943-4f850643-0293-428d-9e40-c22eb765fed9.png)

To get correct communication you must change a few values in projetct. <br/>
The first is `parameter F = 50000000` in *data_source.sv*, where you should set
the appropirate frequency of your board in hertz. <br/>
The next thing to change are `parameter F = 50000000, parameter BAUD = 115200` 
in *uart_tx.sv*. *F* means frequecy, as above, *BAUD* means desired transmission
speed. <br/>
The third necessary changes are `parameter F = 50000000` and a little below line 
`.BAUD(115200)` in *sending.sv* file. <br/>
Before compilation you must assign varialbles to applicable pins, I did it in
this way: <br/>
![a](https://user-images.githubusercontent.com/43972902/136534318-106a4a25-3be8-4255-9aaf-5abf62fb8dfd.png)

When you do it, just compile the project and set the same values in serial
terminal emulator. It can be RealTerm or something different, I'm using moserial.
[Here](https://wiki.gnome.org/action/show/Apps/Moserial?action=show&redirect=moserial)
is page of moserial project. <br/>
Run moserial as sudo user, set the same settings as in project, set suitable 
uart port and click *connect*, then you should see received data: <br/>
![mos](https://user-images.githubusercontent.com/43972902/136533798-20cef9bb-5898-491f-a172-d36cc294a513.png)

Ok, above I wrote that we implemented a machine state where we have a few states:
*WAIT*, *START*, *DATA* and *STOP*. We can see this states in Quartus, just click
on *State Machine Viewer*, where is: *Tasks* -> *Analysis & Synthesis* -> *Netlist 
Viewers* -> *State Machine Viewer*, then we'll see: <br/>
![1](https://user-images.githubusercontent.com/43972902/136549656-cf191705-7af2-4abc-a393-d157bf84ed57.png)

We can notice transition graph. Above we have *Transitions* tab, where are
possible transitions with necessary conditions.
____
I decided write from scratch my own UART library, without any AXI or other 
Wishbone. It's avalible in *uart_library* folder. This library is very simple,
just only three pins: *clk*, *tx* and *rst*. In *uart_library* folder we have 
these files:
- counter.v - the same as everywhere
- sending_test.v - for test purposes. Thanks to this file we generate numbers
    from 1 to 10 and then pass to uart module
- sending_test_tb.v - testbench for above library
- uart_tx.v - main file which is responsible for uart module
- uart_tx_tb.v - testbench for uart module

To check library just copy files and run them in Modelsim. <br/>
When you'll run *uart_tx_tb.v* file in Modelsim add to waves: 
- clk
- data_tb
- full_frame
- state
- tx
- ov_clkBaud
- rst_after_ov
- q from clkTx module
- q from clkBaud module

Run simulation on 1200 us, then you should see: <br/>
![Screenshot at 2021-10-26 18-37-10](https://user-images.githubusercontent.com/43972902/138922874-45287f3a-0f60-4588-a0fe-cb4d0c19bba7.png)

Enlarge waveform in a small part: <br/>


Where: <br/>
1. 8-bit number which comes from test bench, responsible part:
`input wire [7:0] data`. In this case it's *11010011*
2. Prepared data frame for sending, after adding stop and start bit and after
conversion from binary to ascii data. In our case it's *1000000110*, where the
first bit is *1* and it's **STOP** bit. Yes, it's stop bit, because data in our
variable is reversed. It's sending in reverse order. The last bit is *0* and it
is **START** bit. Bits between start and stop bit are our data from input after
confersion to ascii.
3. 
