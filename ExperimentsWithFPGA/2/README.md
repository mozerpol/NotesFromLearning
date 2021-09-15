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


