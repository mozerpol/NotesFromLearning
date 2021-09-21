## Eksperymenty z FPGA (4)
*Elektronika Praktyczna* Nr 3 (326) • 03.2020

The first part is about button debouncing. To eliminate this the author suggest
device based on following scheme: <br/>
| ![image](https://user-images.githubusercontent.com/43972902/134013314-c30299a2-7033-443d-9983-093538907c47.png) |
|:--:|
| *How to eliminate debouncing* |
| Source: *Elektronika Praktyczna 03.2020, p. 125* |

To understand this the first step is explain how *D flip-flow* works. <br/>
In short it performs the function of rewriting information from input *D* to
output *Q* with a delay of one clock pulse, hence its name *D* (like delay) 
flip-flop or *D-latch*. <br>
*D* flip-flop has two inputs, a *clock* (CLK) a *data* (D) and two outputs. One
is main output represented by *Q* and the other is negation of *Q* represented 
by *Q’*. The symbol of a *D* flip-flop is shown below: <br/>
| ![image](https://user-images.githubusercontent.com/43972902/134033780-dd9b3ce6-1144-4382-8915-2dae246bd394.png) |
|:--:|
| *Symbol of dff* |
| Source[20.09.2021]: *https://commons.wikimedia.org/wiki/File:D-Type_Flip-flop.svg* |

A *D* flip-flop is constructed by modifying an SR flip-flop.

The implementation in Verilog for *dff* is inside dff.v file with its test
bench. The output waveform: <br/>
![image](https://user-images.githubusercontent.com/43972902/134030345-4e069495-1ce0-4683-84be-36b7674f2513.png)

Another waveform: <br/>
| ![image](https://user-images.githubusercontent.com/43972902/134032875-da8af41f-e7ad-40b5-b0f1-b3e0e532db16.png) |
|:--:|
| *Another waveform* |
| Source[20.09.2021]: *https://www.electronicshub.org/d-flip-flop/* |

As we can see the output (*Q*) can change only when we have a clock rising edge. 
Otherwise last result is latched. Now it's easy create truth table: <br/>
|*D*|*clk*|*Q*|
|:--:|:--:|:--:|
|0|0|last state|
|0|1|0|
|1|0|last state|
|1|1|1|

The most important application of *D* flip-flop is frequency Division circuit.
The *Q’* output is connected to the *D* input as a closed feedback loop.

| ![image](https://user-images.githubusercontent.com/43972902/134180330-a4c1a48c-0a80-4788-9536-9f72d0097fee.png) |
|:--:|
| *Frequency divider using dff* |
| Source[21.09.2021]: *https://www.electronics-tutorials.ws/counter/count_1.html* |

The next thing to understand main topic in this issue is *XOR* gate. As a 
reminder I put the truth table and symbol: <br/>

| ![image](https://user-images.githubusercontent.com/43972902/134187454-a88b3f17-89a9-4011-9dc3-f747d2676be1.png) |
|:--:|
| *XOR gate* |
| Source[21.09.2021]: *https://www.maximintegrated.com/content/dam/images/glossary/xor-gate-symbol.jpg* |

