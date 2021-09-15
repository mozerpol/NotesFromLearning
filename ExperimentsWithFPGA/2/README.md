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
| Source [15.09.21] *https://www.electronics-tutorials.ws/wp-content/uploads/2018/05/counter-cou30.gif* |
