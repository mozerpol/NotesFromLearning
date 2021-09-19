## Eksperymenty z FPGA (3)
*Elektronika Praktyczna* Nr 2 (325) • 02.2020

To understand this issue I must explain a few things. <br/>
The first is 8421 code. <br/>
Exactly we should say *BCD* (binary coded decimal) with a weight of 8421.
To avoid confusion, code 8421 is sometimes referred as NBCD (Natural BCD),
where each decimal digit is represented by its corresponding four-bit binary 
value, as shown below: <br/>
![image](https://user-images.githubusercontent.com/43972902/133499498-e328822e-ed11-44e2-b7a1-aed2f6b552a6.png)

The next thing is binary counter. It's a device that counts clock pulses. It has
a clock input and outputs where we have the counter state, i.e. the number of 
clock pulses counted, appears in binary code 8421.

| ![image](https://user-images.githubusercontent.com/43972902/133500359-10ac65c4-cf70-4761-bed0-2536e6c38344.png) |
|:--:|
| *BCD Counter Circuit using the 74LS90* |
| Source [15.09.21]: *https://www.electronics-tutorials.ws/wp-content/uploads/2018/05/counter-cou30.gif* |

The third thing is *T flip-flop* (toggle flip-flop). It's a flip-flop that 
changes the state of the outputs to the opposite when we have 1 on the input. 
Also flip-flop, is triggered by the edge of a clock signal (usually falling).

| ![image](https://user-images.githubusercontent.com/43972902/133502075-9da6374b-0731-47fa-8c1c-758f3e6fe6c8.png) |
|:--:|
| *Symbol T-type flip-flop* |
| ![image](https://user-images.githubusercontent.com/43972902/133502331-dce29000-1a04-4492-b8b7-02eb3db8da5d.png) |
| *Truthtable* |
|![image](https://user-images.githubusercontent.com/43972902/133503187-5f989c7c-cb22-4d39-a089-a53ab74754db.png)|
| *Different approach to the truth table*
| Source [15.09.21]: *https://pl.wikipedia.org/wiki/Przerzutnik_typu_T* | 

The *T* flip-flop can be used as an asynchronous binary counter. An asynchronous
counter is created when we connect several *T* flip-flops in series with each 
other so that the Q output of one flip-flop connects to the T input of the next.

| ![image](https://user-images.githubusercontent.com/43972902/133514492-afe32d52-471a-433a-b2d5-b029cad3047d.png) |
|:--:|
| *4 bit counter using 8421 coding with waveform* |
| Source [15.09.21]: *https://eduinf.waw.pl/inf/alg/002_struct/0035.php#przerzutnik_T* |

It is recommended that the logic implemented in the FPGA should be synchronized 
with the same clock - it means, it should be in one clock domain. Sometimes it
happens that some blocks have to work on a clock with a different frequency.
Between these blocks are required additional modules synchronizing signals.
This modules are called *CDC* (clock domain crossing). For distributing a clock
signal are also prepared separate paths connecting the system, in our MAX10 
called the Global Clock Network.

On the FPGA we can create almost every digital circuit. Thanks to HDL languages
we can transform our code to digital circuit which will be implemented on FPGA.
In Quartus we can see what electronic circuit describes our code. To do this
expand: <br/>
*Analysis & Synthesis* -> *Netlist Viewers* -> double click on *RTL Viewer* <br/>
![image](https://user-images.githubusercontent.com/43972902/133253582-1e240ca7-7b96-4de7-b70b-d4c677f32ae3.png)

RTL (Register Transfer Level) Viewer: <br/>
![image](https://user-images.githubusercontent.com/43972902/133890902-4972fdea-e562-46e0-9751-d4c09b6d1e67.png)

Thanks to the fact that we have divided the project into modules, we will first
see only the connections between them. To see internal structure click on "plus"
icon: <br/>
![image](https://user-images.githubusercontent.com/43972902/133891008-09da71e8-f6cc-43da-8a1a-c8b8fb415d48.png)

RTL Viewer is readable and easy to understand, however it doesn't include the
resources contained in a particular FPGA model. To find out how the project 
will be implemented, let's choose: <br/>
*Technology Map Viewer (Post-Mapping)*. Should appear: <br/>
![image](https://user-images.githubusercontent.com/43972902/133929691-ad8a0901-3eea-456c-9d68-cf8c986655ed.png)
