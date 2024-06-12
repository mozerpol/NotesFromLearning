# Digital Principles and Logic Design
### A. SAHA N. MANNA
__________

## Table of contents <a name="tof"></a>
1. [Data and number systems](#1)
    1. [Fractional Conversion](#1.1)
    2. [Ones' complement](#1.2)
    3. [Two's complement](#1.3)
    4. [BCD - Binary Coded Decimal](#1.4) 
2. [Codes and their conversions](#2)
3. [Boolean algebra and logic gates](#3)
    1. [Axioms of Boolean Algebra](#3.1)
    2. [Laws of Boolean Algebra](#3.2)
    3. [Basic properties and theorms of Boolean Algebra](#3.3)
    4. [Other Important Theorems](#3.4)
    5. [Venn diagrams](#3.5)
    6. [Canonical and standard forms](#3.6)
    7. [Logic gates](#3.7)
    8. [Transforming circuits into only NAND gates](#3.8)
4. [Simplification and minimization of boolean functions](#4)
    1. [Two-variable karnaugh maps](#4.1)
    2. [Three-variable karnaugh maps](#4.2)
    3. [Four-variable karnaugh maps](#4.3)
    4. [Five-variable karnaugh maps](#4.4)
    5. [Don’t-care combinations](#4.5)
    6. [The tabulation method](#4.6)
5. [Combinational logic circuits](#5)

## 1. Data and number systems <a name="1"></a> [UP↑](#tof)
In binary code, the number 101010 - on the left is MSB (1) and on the right is 
LSB (0). <br/>
In binary code, numbers are presented using the characters 0 and 1. <br/>
In the octal code, numbers are presented using characters from 0 to 7. <br/>
In the hexadecimal code, numbers are presented using the characters 0 to 9 and 
A to F. <br/>

### 1.1. Fractional Conversion <a name="1.1"></a> [UP↑](#tof)
Example: Convert 1010.011 to decimal number. <br/>
The binary number given is:
1 0 1 0. 0 1 1 <br/>
Positional weights
3 2 1 0 -1-2-3 <br/>
So... <br/>
1\*2^3 + 0\*2^2 + 1\*2^1 + 0\*2^0 + 0\*2^–1 + 1\*2^–2 + 1\*2^–3 = 8 + 0 + 2 + 0 + 0 + 
0.25 + 0.125 = 10.37510

### 1.2. Ones' complement <a name="1.2"></a> [UP↑](#tof)
**Ones' complement** - the value is obtained by inverting all the bits in the 
binary representation. <br/>
Example: binary number: 10101110 <br/>
In ones' complement it's 01010001. 1’s complement indicates if the number is 
positive or negative. MSB number tells us, whether the number is negative. For
example number 11111110 = -1.

1. How to convert dec to 1's complement?
- Convert the decimal number to its binary equivalent,
- invert all the bits in the binary number,
- The result binary number is the one's complement.

2. How to convert 1's complement to dec?
- Invert all the bits in the binary number.

3. Subtraction using complement
Subtraction is performed by **adding** two numbers, if a carry is generated, 
remove the carry, add it to the result. This carry is called the end-around 
carry. <br/>
For example: subtract 1001 from 1101:
- 1001**+**1101 = 0011 and **1** carry, which need be added
- 0011+0001 = 0100

### 1.3. Two's complement <a name="1.3"></a> [UP↑](#tof)
**Two's complement** - (abbreviated as U2, ZU2, 2's or 2C, pl. *kod uzupełnień 
do dwóch*). <br/>
It's a system of representation of integer numbers in a binary system. MSB 
number tells us, whether the number is negative. For example `0b1000` will be 
negative, because MSB (first number from left) is 1, otherwise `0b0111` will be 
positive.

1. How to convert U2 to dec?
Example: number in U2: *101* - it has three numbers.
- Take first from left (it is *1*) and raise to the power of 2. Why *2*? Because 
we have three numbers, but in computer science we count from zero. And very 
important thing, the first number must be multiple by *-1*, because first number 
says whether the number is positive or negative,
- raise to the power of 1 number *0* (because second number is 0) by 1. 
- raise to the power of 0 number *1*.
So finally, we have: -1*2^2 + 0*2^1 + 1*2^0 = -4 + 0 + 1 = -3 <br/>

2. How to convert dec to U2?
Example: dec number 72.
- For positive numbers just change to binary code, for 72 = 1001000,
- add a sign bit at the MSB position, for 72 = 0, so 72 in 2's is equal 01001000.

Another example: dec number -72.
- Change to binary code positive number, in that case is 72 = 01001000 (need to 
remember about sign bit at the MSB),
- negate the binary number by inverting the bits, so 01001000 = 10110111,
- add number 1, so 10110111 + 00000001 = 10111000. So -72 = 10111000.

3. Subtraction using U2 complement
2's numbers are subtracted as usual for binary numbers. Change decimal to 2's
numbers, then substract.

### 1.4. BCD - Binary Coded Decimal <a name="1.4"></a> [UP↑](#tof)
We can distingusih many BCD codes like 8421 or 4241. <br/>
Each decimal digit from 1 to 9 is coded in 4-bit binary numbers. <br/>
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/3f9c6d73-ad91-4275-b83b-70390a25d86d)|
|:--:|
|Only characters from 0 to 9 are allowed in the BCD code.|






