## Eksperymenty z FPGA (6)
*Elektronika Praktyczna* Nr 5 (328) • 05.2020 <br/>
This issue is about *UART* - *Universal Asynchronous Receiver* and *PWM*. At the
beginning I focused on UART. PWM I'll describe later. I is transmitter in
previous repo,
[here](https://github.com/mozerpol/NotesFromLearning/tree/master/ExperimentsWithFPGA/4).

As before I divided this issue into two parts. The first is about library from
*EP*, next is my own library. <br/>
Ok, so how it works? During idle we have logic one, so our receiver wait for
logic zero, which means the start of transmission. At this point we should run
our internal clock for
measuring when we have data bits. It's very important. We would like to know
when we're sure when we have the new bit. So we must read data not during rising
edge of this bit, but in the middle. It sounds a little bit complicated, but I
hope that the drawing will brighten up the situation a bit. In the picture below
we can see arrows, they indicate moments when we must react.
|![image](https://user-images.githubusercontent.com/43972902/141997910-4e16bcab-04e6-4e65-b6a8-b786e614704d.png)|
|:--:|
|Source: *Elektronika Praktyczna 05.2020, p. 109*|

The code is a little bit similar to transmitter, there also is state machine,
where we have four states: WAIT, START, DATA and STOP. Below is state machine
transitions graph: <br/>
| ![image](https://user-images.githubusercontent.com/43972902/142005062-7a2bbc81-b1cb-4a9e-9a69-7d3002f82f59.png) |
|:--:|
| Transitions between states in the receiver |
|Source: *Elektronika Praktyczna 05.2020, p. 109*|

At the beginning we're in the WAIT state, where we're waiting for start bit (
it's logic zero on *rx* input). If we recognize low state, then we're going to
START state, where we're waitnig for *rx_clk*, which will occur in the middle of
start bit. Then we can go to the DATA state, in which we must receive eigth
bits in one data frame. Below is output from Modelsim, where we can notice that
*rx_clk* is in the middle of the *rtx*: <br/>
![image](https://user-images.githubusercontent.com/43972902/142006891-45e72d00-fc58-4501-9938-bda3819079ae.png)

How to implement this on FPGA board? <br/> As previous, create a new project for
SystemVerilog lang. After copying the files, compile the project: <br/>
![image](https://user-images.githubusercontent.com/43972902/142235454-bb7b3182-36c7-4d37-9232-f0c98a774a15.png)

and assign ports to the correct pins. I did it in this way: <br/>
![image](https://user-images.githubusercontent.com/43972902/142235161-0adc884c-5228-48d4-b97b-f13ecd83cf42.png)

Now connect fpga board to the computer: <br/>
![image](https://user-images.githubusercontent.com/43972902/142238904-a33e94f8-f421-444d-9ad0-93a4a0545f59.png)

After this configure serial terminal (in my case it's *Moserial* for linux): <br/>
![image](https://user-images.githubusercontent.com/43972902/142237055-5e3ea0aa-2d3a-4ea4-93a5-ae38f7d3372a.png)

Compile once again project (because after the first compilation I assigned ports)
and upload *uart_inc.sof* to the board. Open serial monitor/terminal and write
something, program inside fpga will add *+1* to the received data and send
changed data to the monitor by UART: <br/>
![image](https://user-images.githubusercontent.com/43972902/142238670-1131bf6f-7d82-4de7-8fe4-9de4c4173aa4.png)
