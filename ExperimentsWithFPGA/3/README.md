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
flip-flop. <br>
The implementation in Verilof for *dff* is inside dff.v file with its test
bench. The output waveform: <br/>
![image](https://user-images.githubusercontent.com/43972902/134030345-4e069495-1ce0-4683-84be-36b7674f2513.png)

Another waveform: <br/>
| ![image](https://user-images.githubusercontent.com/43972902/134032875-da8af41f-e7ad-40b5-b0f1-b3e0e532db16.png) |
|:--:|
| *Another waveform* |
| Source[20.09.2021]: *https://www.electronicshub.org/d-flip-flop/* |

As we can see
