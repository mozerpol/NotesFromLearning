Lecture notes **Design of Digital Circuits - ETH Zürich - Spring 2019** based on
youtube videos:
https://www.youtube.com/playlist?list=PL5Q2soXY2Zi8J58xLKBNFQFHRO3GrXxA9 <br/>
The author of the channel is Onur Mutlu, a lecturer at ETH. <br/>
Exams and solutions:
https://safari.ethz.ch/digitaltechnik/spring2019/doku.php?id=exams
______
## BOOKS:
![image](https://github.com/mozerpol/learningRISC-V/assets/43972902/26399c60-21e3-4472-8d0f-789f716973b2)
## Lecture 1: Introduction and Basics (ETH Zürich, Spring 2019)
## Lecture 2: Mysteries in Comp Arch (ETH Zürich, Spring 2019)
## Lecture 3: Introduction to the Labs and FPGAs (ETH Zürich, Spring 2019)
## Lecture 4: Combinational Logic I (ETH Zürich, Spring 2019)

### 1. MOSFET symbols
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/2b6c8479-31fd-4361-882f-85c3468b9826)|
|:--:|
| My comment: NMOS is open when gate = 0; PMOS is open when gate = 0 |
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/93df93a3-389a-4967-a2a2-51b364d73326)|
| Source: *https://en.wikichip.org/wiki/mosfet* |

### 2. How MOSFET works
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/0be95219-80d3-497c-9741-aeff31d31db5)|
|:--:|
| My comment: This is nicely illustrated in the picture below. *The wall switch* - means an electrical device mounted in the wall.|

### 3. CMOS
#### Inverter - NOT gate
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/e62ddeac-a6dd-467c-b3ef-f5578050ad2b)|
|:--:|
|My comment: CMOS inverter (a NOT logic gate)|
|Source: *https://www.geeksforgeeks.org/cmos-logic-gate/*|

![1](https://github.com/mozerpol/NotesFromLearning/assets/43972902/16d5da86-3ccf-4559-b4ce-a7875c22e7e5)

#### NAND gate
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/7bc19430-102f-45eb-aec5-41bcc19695fb)
![1(1)(1)](https://github.com/mozerpol/learningRISC-V/assets/43972902/1c4a02f5-4701-4c75-8c26-9a964cfff5fe)

#### AND gate
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/4584cfe5-0558-4aae-9460-3b70f5328fcf)

#### OR gate
![image](https://github.com/mozerpol/learningRISC-V/assets/43972902/b1415c4d-60dc-4796-81ff-dd6bcfc48167)
|:--:|
|Source: *https://www.allaboutelectronics.org/cmos-logic-gates-explained/*|

#### NOR gate
![image](https://github.com/mozerpol/learningRISC-V/assets/43972902/a337f271-1e1c-4056-b198-e968348a8f23)
|:--:|
|Source: *https://www.allaboutelectronics.org/cmos-logic-gates-explained/*|

#### XOR gate
|![image](https://github.com/mozerpol/learningRISC-V/assets/43972902/951f6e76-601e-44ff-85f8-874e21d6302d)|
|:--:|
|Source: *https://www.allaboutelectronics.org/cmos-logic-gates-explained/*|

### 4.
![image](https://github.com/mozerpol/learningRISC-V/assets/43972902/42d8af6a-0da6-402f-8047-5026231b34c9)
The point is that operations such as writing and reading from cache consume more
energy than, for example, an addition of two numbers. Below is a picture which
shows it. Adding of two numbers is equal 20 pico joules, when reading or writing
from cache is equal 16 nano joules. <br/>
![image](https://github.com/mozerpol/learningRISC-V/assets/43972902/d5d5c16e-da18-4414-ae1a-cddce336463e)

### 5.
**pMOS transistors better pass logic high signal (1) compared to nMOS
transistors.** This makes pMOS transistors better suited for implementing
pull-up networks in CMOS circuits.
![image](https://github.com/mozerpol/learningRISC-V/assets/43972902/145f0c92-0df3-432e-a945-e3c9fcc86987)
![image](https://github.com/mozerpol/learningRISC-V/assets/43972902/3730aed6-c79a-443f-8678-ebf156665b93)

### 6.
![image](https://github.com/mozerpol/learningRISC-V/assets/43972902/2ca0209a-469a-4107-b771-ee70c2dbe4fa)
