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






