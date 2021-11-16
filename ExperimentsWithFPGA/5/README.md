## Eksperymenty z FPGA (6)
*Elektronika Praktyczna* Nr 5 (328) • 05.2020
This issue is about *UART* - *Universal Asynchronous Receiver* and *PWM*. At the
beginning I focused on UART. PWM I'll describe later. I is transmitter in 
previous repo, 
[here](https://github.com/mozerpol/NotesFromLearning/tree/master/ExperimentsWithFPGA/4).

As before I divided this issue into two parts. The first is about library from
*EP*, next is my own library. <br/>
During idle we have logic one, so our receiver wait for logic zero, which means
the start of transmission. At this point we should run our internal clock for
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

