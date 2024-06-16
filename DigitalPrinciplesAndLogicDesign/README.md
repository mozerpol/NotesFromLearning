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

1. How to convert dec to BCD?
If we want to create the number 12 in BCD code, it must be divided into two 
parts:
- Number 1: 00001
- Number 2: 00010

So number 12 in BCD looks: 00001 00010

2. BCD addition
We add like regular binary numbers, if the result is greater than 9, we add the 
number 6 to this result and we get a new result, which is valid in BCD. <br/>

An example: add 7 + 5 = 0111 + 0101 <br/>

0111 <br/>
0101 <br/>
----+ <br/>
1100 <br/>

1100 = 12, this number is greater than 9, so to the 12 we need add 6: <br/>

1100 <br/>
0110 <br/>
----+ <br/>
10010 <br/>

So our result is 10010, but BCD is represented on 4 bits, so the final result 
is: 0001 0010.

3. BCD substraction
It's not that obvious... We have to add the 9’s complement of the subtrahend to
the minuend.

## 2. Codes and their conversions <a name="2"></a> [UP↑](#tof)

In digital systems a variety of codes are used to serve different purposes, such 
as data entry, arithmetic operation, error detection and correction, etc. 
Selection of a particular code depends on the requirement.

Codes can be classified into five groups:
1. Weighted Binary Codes
a) 8421 - 8, 4, 2, and 1 are the weights of the four bits of the BCD code.
b) 84-2-1 - yes, it's minus 2 and minus 1. Thanks to this is possible to assign 
negative weights to decimal code. So number 0101 = 0\*8 + 1\*4 + 0\*(–2) + 
1\*(–1) = 3.
c) 2421 (different name Aiken code) - does not weight the fourth digit as 8 as 
with the standard BCD code but with 2.

|Decimal digit| Aiken 2421 code|
|:--:|:--:|
|0| |
|1 |0000 |
|2 |0001 |
|3 |0010 |
|4 |0011 |
|5 |0100 |
|6 |1100 |
|7 |1101 |
|8 |1110 |
|9 |1111 |

2. Nonweighted Codes - These codes are not positionally weighted. It basically 
means that each position of the binary number is not assigned a fixed value.
a) Excess-3 - decimal code that has been used in some old computers. <br/>
For every number we need to add number 3 and then change result to 4-bit binary
number, I'll explain using an example: Convert decimal 367 do excess-3: <br/>
- 367, for every number add 3: 3+3, 6+9, 7+3, we receive 6 9 10
- Convert 6 9 10 to 4-bit binary: 0110 1001 1010
- So 367 in excess-3 = 0110 1001 1010

b) Gray Code - belongs to a class of code known as minimum change code, in which 
a number changes by only one bit. This code is not useful for arithmetic 
operations. <br/>
Conversion from binary number to gray code and from gray code to binary is quite
nice described on the page 35.

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/09930037-7d7e-4896-8feb-53a1e695083a)

3. Error-detection Codes
a) Parity Bit Coding Technique - A parity bit is an extra bit included with a 
message to make the total number of 1s either odd or even, including parity bit. 
The detected error cannot be corrected, but its presence is indicated. This
method fails for double errors.

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/aa1a8f05-5470-4bad-a8f4-a2e3f212d789)|
|:--:|
| P is additional bit for message. |
| If number of 1s in the message is odd then parity bit is equal 0, for case when we want to emphasize odd number of 1s. |

b) Check Sums
Initially any word A 10010011 is transmitted; next another word B 01110110 is 
transmitted. The binary digits in the two words are added and the sum obtained 
is retained in the transmitter. Then any other word C is transmitted and added 
to the previous sum retained in the transmitter and the new sum is now retained.
After transmitting all the words, the final sum, which is called the Check Sum, 
is also transmitted.

4. Error-correcting codes <br/>
a) Hamming Code - it's not hard, just generate a simple pattern of xors and use 
it. <br/>
b) Reed Solomon. <br/>
It is too time consuming to explain how this two codes works, so I skipped it.

5. Alphanumeric Codes <br/>
a) ASCII - It is a 7-bit code, where a character is represented with seven bits,
but often the extra bit is used to extend the ASCII to represent an additional
128 characters. <br/>
b) EBCDIC - It is generally used in IBM equipment and in large computers. <br/>
c) Hollerith Code - this code is used in punched cards.

## 3. Boolean algebra and logic gates <a name="3"></a> [UP↑](#tof)
Two-valued Boolean algebra is defined on a set of only two elements, S = {0,1}.

### Axioms of Boolean Algebra
*+* denotes the Logical OR operation <br/>
*.* denotes the Logical AND operation <br/> 
*!* denotes the Logical NOT operation <br/>

1. 0.0 = 0
2. 0.1 = 0
3. 1.0 = 0
4. 1.1 = 1
5. 0+0 = 0
6. 0+1 = 1
7. 1+0 = 1
8. 1+1 = 1
9. !0 = 1
10. !1 = 0

### Laws of Boolean Algebra
1. Commutative Law:
A+B = B+A <br/>
A.B = B.A <br/> 
2. Associative Law:
(A+B)+C = A+(B+C) <br/> 
(A.B).C = A.(B.C) <br/> 
3.  Distributive Law:
A(B+C) = AB + AC <br/> 
A + BC = (A+B). (A+C) <br/> 
4. Idempotance Law:
A+A=A <br/> 
A.A = A <br/> 
5. Absorption Law:
A + A.B = A <br/> 
A.(A+B) = A <br/> 

### Basic properties and theorms of Boolean Algebra
1. Principle of Duality - This principle states that any algebraic equality 
derived from boolean axioms will still be valid whenever the OR and AND 
operators, and identity elements 0 and 1, have been interchange (pol. 
*zamiennie*).
2. DeMorgan's Theorem
a) (x + y)' = x' y' <br/>
b) (x y)' = x' + y' <br/>

### Other Important Theorems
1. A + A = A 
2. A . A = A
3. A + 1 = 1
4. A . 0 = 0
5. A + A.B = A
6. A.(A + B ) = A

### Venn diagrams
A Venn diagram may be used to illustrate the postulates of Boolean algebra or to
explain the validity of theorems.

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/00636462-2969-4d85-89c0-72051dfb80ff)|
|:--:|
|Source: https://www.jeffreythompson.org/blog/2010/04/18/logic-gates-as-venn-diagrams/|

### Canonical and standard forms
*Product Term* - an AND function is referred to as a sum term. <br/>
*Sum Term* - an OR function is referred to as a sum term. For example, A + B + 
C′ is a sum term.

Logic function can be expressed in the following forms:
- Sum of the Products (SOP) - logical sum of two or more logical product terms. 
It is basically an OR operation on AND operated variables. For example, Y = AB + 
BC + AC or Y = A′B + BC + AC′.
- Product of the Sums (POS) - logical product of two or more logical sum terms.
It is an AND operation on OR operated variables. For example, Y = (A + B + C)(
A + B′ + C)(A + B + C′) or Y = (A + B + C)(A′ + B′ + C′).
- Nonstandard form - is neither a sum of products form nor a product of sums 
form like F = (AB + CD)(A′B′ + C′D′), but can be converted to a standard form
like F = (AB + CD)(A′B′ + C′D′) = A′B′CD + ABC′D′.

### Logic gates
Minterm - is the product of N distinct (pol. *odrębny*) literals. Each minterm 
is obtained by an AND operation, for example literals are: A, B, C and the
minterm is A*B*C=1.

Maxterm - is the sum of N distinct (pol. *odrębny*) literals. Each maxterm is 
obtained by an OR operation. The output of the maxterm functions is 0, 
for example literals are: A, B, C and the maxterm is A+B+C=0.

| Digital logic gates |
|:--:|
| ![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/62c7f00b-e56d-4337-b763-28caf8788d68) |
| Source: *Page 68* |

NAND gates and NOR gates are called universal gates. The advantage of using the 
universal gates for implementation of logic functions is that it reduces the 
number of varieties of gates.

|Gates made from NOR and NAND|
|:--:|
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/850379db-a350-413a-9d14-0d8dfa3d0115)|
|Source: *https://www.quora.com/How-do-you-implement-Y-A-BC-using-only-the-NOR-gate*|

### Transforming circuits into only NAND gates
The easiest way to transform circuit which is to change each gate into the 
corresponding NAND gate. Firstly need to understand one thing: when two 
inverters are cascaded, the function remains the same, picture below shows what
I mean:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/57a07a6a-14d6-43b6-ba8c-7059cbac83d1)

So remeber that two cascaded inverters don't change anything, double inversion 
does not perform a logic function. Tranform all gates in the circuit to the 
corresponding NAND gates. Example:

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/e7fe6c5e-497c-4511-bc19-c4336f944e41)|
|:--:|
|Source: *page 73*|

The above circuit was transformed into the same, which is made of NAND gates:

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/44dc9a89-2be0-4a92-86b9-c6b39a604379)|
|:--:|
|Source: *page 73*|

As I wrote earlier, two inverters do not make any sense, because of that it's
necessary to remove them. I marked them below:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/8fa20070-318e-4bc9-9160-4f150f86b540)

The final circuit looks like:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/b4f39df5-62ec-497f-8a53-b6f97e9dbbc4)

Notice that input A was changed into A' (negation of A), so one NAND was 
removed.

Level of gates - the maximum number of gates cascaded in series between an input 
and output.

Wired logic - is a logic gate that use only passive components such as diodes 
and resistors. A wired logic connection can create an AND or an OR gate. 
Limitations include the inability to create a NOT gate.

Multilevel gate network - if a network is implemented using gates in more than
two levels. The multilevel network reduces the number of literals as well as the 
variety of gate types:

| ![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/a91a85cc-c106-4926-bdb1-1e0634e7aaac) |
|:--:|
| On the left side is an example of two-level AND-OR network, on the right side is the same function, but realized as a multilevel gate network. |
|Source: *page 77*|

Multilevel networks use less number of literals or inputs, thus reducing the 
number of wires for connection. The biggest disadvantage of the multilevel 
network is that it increases the propagation delay.

## 4. Simplification and minimization of boolean functions <a name="4"></a> [UP↑](#tof)
A K-Map or Karnaugh Map is a graphical method that used for simplifying the 
complex algebraic expressions in Boolean functions. The Karnaugh map can 
minimize logical functions in two cases (below is example for three variables):
- Sum of the Products (SOP): F = A′BC + A′BC′ + AB′C′ + AB′C. In this case k-map
is build from ones.
- Product of the Sums (POS): Y = (A + B + C)( A + B′ + C)(A + B + C′). In this 
case k-map is build from zeros.

### Two-variable karnaugh maps
Boolean function in two variables (A, B) can have four possible combinations:
1. SOP (each of these terms are called a minterm):
- A*B
- A*B'
- A'*B
- A'*B'
2. POS (each of these terms are called a maxterm):
- A+B
- A+B'
- A'+B
- A'+B'

Below is the template:

|![untitled(3)](https://github.com/mozerpol/NotesFromLearning/assets/43972902/38e1e2e3-64a0-45d4-be9f-e1a6c1234360)|
|:--:|
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/f9d596af-c18e-4db0-803b-7fcdba0a0aae)|
|A'=0; A=1; B'=0; B=1|

It will be easiest to explain with an example.

#### 1. Find the logic circuit for the truth table:
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/8f9fb28a-246d-4820-b463-f186958c6530)

1. When A = 0, B = 0, F = 0: <br/>
For A=0 and B=0 result F is 0. Filled K-map looks like:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/6e3da5ab-c1e9-40dc-89fa-0afa51a0a8f4)

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/f65cf527-28a6-4b3f-8829-b80f36c3ca90)

2. When A = 0, B = 1, F = 1 <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/65b80fc7-fc37-40dd-b8eb-ec26c2736c6f)

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/93c713fa-0678-473b-b031-d584e851e574)

3. When A = 1, B = 0, F = 1 <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/d1b5b65a-6a56-4f79-a5f2-5dcbe81ecd56)

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/5c85b1f2-6509-45b7-aa8d-d9d75b6c2019)






