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

So the result for this part: <br/>
![image](https://user-images.githubusercontent.com/43972902/134188780-ff4bc2f5-b3a3-4239-b941-ff149e086b04.png)

is simple truth table from *XOR* gate (0110). So we can summarize this part, when 
the input for *D* will be stable, then output (*Q*) from *d-latch* will be the 
same as input. It means that on input *XOR* we have the same values. Thanks to
this we can obtain two the same states: *0* and *0*. <br/>
Changing the input state for *d-latch* will cause that on the output from *XOR* 
we have *1*. The state *1* reset our counter: <br/>
![image](https://user-images.githubusercontent.com/43972902/134194431-0222b806-297c-49c4-929d-b0cdadfc51aa.png)

Otherwise (in case when from *XOR* output we have *0*) the counter will count 
up. <br/>
The next part our circuit: <br/>
![image](https://user-images.githubusercontent.com/43972902/134318761-a899369e-977d-4844-91fe-91f110ac6a3c.png)

is responsible for counting when we have a stable state. I mean, if input to our
device is in the same state, then output from *XOR* is equal *0*. Then above 
marked part can count up. *SR* input it's a additional input to our counter, 
which can *reset*. <br/>
```SystemVerilog
always_ff @(posedge clk or negedge rst)
	if (!rst)
		stable_time <= '0;
	else if (sr)
		stable_time <= '0;
	else
		stable_time <= stable_time + 1;
```

As we can see that counter will count when:
- *rst* (it's our *SR* input) must be equal *0*, because `if(!rst)` then reset
	counter.
- *sr* - it's additional input in couter, which need logic *1* to reset counter
	`else if (sr)`

`stable_time` is a register which store current value. How it works? <br/>
`stable_time` is a register of some length. For example it can be 
`[3:0]stable_time`, so it's four bits register. At the beginning we have: <br/>
*stable_time* == 0000 <br/>
When we increment value (`stable_time <= stable_time + 1;`), then we have" <br/>
*stable_time* == 0001 <br/>
When we increment once again, then we have: <br/>
*stable_time* == 0010 <br/>
Once again... <br/>
*stable_time* = 0011 <br/>
As you can see every clock cycle we increment counter, due to four bits we have
2^4 different possibilities. <br/>
Assume one clock takes 1 second, so if we want up to the end of counter we need
2^4 seconds.  <br/>
Initialization (zero time):<br/>
0000 <br/>
The first clock cycle (1st sec): <br/>
0001 <br/>
The second clock cycle (2nd sec): <br/>
0010 <br/>
The third clock cycle (3rd sec): <br/>
0011 <br/>

As you can see it's also easy to create simple delay block, you must know only
timing of your clock.

The next part of our debouncing device is also *D-latch*: <br/>
![image](https://user-images.githubusercontent.com/43972902/134329124-06b38f28-b73c-4bcd-9d77-67837a355c51.png)

Operation of this module is very easy. *CE* means *clock enable* and it's the
last one bit in *stable_time* register: `stable_time[N-1]`. So when the counter
cout to the end, then will turn on the last *d* flip-flop and this flip-flop
set on output logic *1*. <br/>
In my opinion we can get rid the last one flip-flop, but maybe entire device
is more relaiable.
