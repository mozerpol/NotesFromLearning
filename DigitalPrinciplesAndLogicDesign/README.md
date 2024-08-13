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

4. When A = 1, B = 1, F = 1 <br/>
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/a4dbe3c5-7db3-40e2-8e32-5d1f040fb90d)

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/9d52b66a-bcf1-41a5-8da8-b7496786d5ea)

We have filled K-map, now it's time to minimalize it. We need to mark entire
places where there are number of ones is a power of 2, i.e.: 1, 2, 4, 8, 16, ...
We can start to mark only ones which occurs horizontally. Like below (first
case):

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/077d6da5-872a-4161-b040-6f29c25cf57b)

Based on that we can say that for now funcion is F = A. <br/>
Why F = A? Because horizontally we have only two ones for A. For A' is 0 and 1.
Now we can mark two ones which occurs vertically:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/1e63821c-41c5-46f6-86ce-35437ddea6c7)

Based on that we see that function is F = B. For B' vertically data is 0 and 1.
Summarizing we have two functions F = A or F = B. If these functions occurred
only horizontally or vertically, we would have F = A and F = B, but since one
occurs horizontally and the other vertically, we have F = A and F = B.
Summarizing... F = A or B.

#### 2. Find the logic circuit for the truth table:
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/e46b0fc5-6ead-4f95-8219-3e6a156dcd3c)

Filled K-map for given truth table looks like below:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/0814a915-beea-43aa-abe4-6f5f0e6725d0)

Now, as previously we need to mark entire places where there are number of ones
is a power of 2, i.e.: 1, 2, 4, 8, 16, ... For our case we have a 2x2 matrix of
ones, so:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/b7a6fb11-bfa9-44fb-8810-b43c6e8c198f)

This circuit is simply F = 1, because for every input we have 1.

#### 3. Find the logic circuit for the truth table:
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/685d3511-0dbc-4504-9625-48c9bec38793)

K-map for given truth table:

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/3e90762a-bbf1-4393-a3e8-0a75f585ddcd)|
|:--:|
|As I wrote before, A', B' = 0; A, B = 1|

So now as previously we need to mark entire places where there are number of
ones is a power of 2, i.e.: 1, 2, 4, 8, 16, ... We have a two groups of ones:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/043c245f-193b-48f5-b209-010798cb85d3)

Looking horizontally, only B' is equal to one in both cases, so for now F = B'.
Looking vertically, only A' is equal to one in both cases, so for now F = A'.
Summarizing... F = B' or A'.

### Three-variable karnaugh maps
As for two-variable karnaugh map can minimize logical functions in two cases:
- Sum of the Products (SOP): F = A′BC + A′BC′ + AB′C′ + AB′C.
- Product of the Sums (POS): Y = (A + B + C)( A + B′ + C)(A + B + C′)

The logical functions for three variables can have total eight possible
combinations, for standard sum of product (SOP) are as follows: (A′B′C′),
(A′B′C), (A′BC′), (A′BC), (AB′C′), (AB′C), (ABC′), (ABC). For POS are as
follows: (A+B+C), (A+B+C′), (A+B′+C), (A+B′+C′), (A′+B+C), (A′+B+C′), (A′+B′+C),
(A′+B′+C′). Below is the template:

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/8f30d812-2d99-4097-adb1-a3852d981ddb)|
|:--:|
|The minterms and maxterms are arranged, not according to the binary sequence (in Gray code).|
|Source: https://www.tutorialspoint.com/3-variable-k-map-in-digital-electronics|

The three-variable Karnaugh Map can be constructed in other ways:

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/82c41fca-7117-4f1f-8c4b-fc7de5616e48)|
|:--:|
|Source: page 91|

#### 1. Find the logic circuit for the truth table:
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/acb9bf17-3041-4a23-8835-52fbad911286)

To fill the K-map, the same procedure is done for two variables, with the
difference that instead of B there is a combination of BC:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/9d376bb8-491a-4f9f-9f15-6e47737816d5)

So now as previously we need to mark entire places where there are number of
ones is a power of 2, i.e.: 1, 2, 4, 8, 16, ... We have a two groups of ones:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/64b9d82b-3ccb-40ce-824d-eb589dcd580e)

The next step is to check for which marked fields the inputs are the same:
1. For input A is always 1, so F = A.
2. For input BC = 1 and BC' = 1. In this case, the output does not depend on the
variable C or C', because for C and C' the output is equal to 1. This is not
possible, therefore for the input BC and BC' we can only write F = B.

Summarizing... F = A or B.

We can write the same K-map in a different way, where we have two overlapping
fields:
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/60f0083a-3ff9-4ba3-ac25-5c85c16710dc)

As previously we need to check for which marked fields the inputs are the same:
1. Vertically for the first square: A'B = 1 and AB = 1 . In this case,
the output does not depend on the variable A or A', so F = B.
2. Vertically for the second square: AB = 1 and AB' = 1. The output does not
depend on the variable B or B', so F = A.
3. Horizontally for C we have 0111 in K-map, so we do not take the C input into
account at all.

Summarizing... F = A or B.

#### 2. Find the logic circuit for the K-map:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/1af26844-dc77-4276-a732-fd6e7bc2fd2d)

F = AB, because for A and B = 1.

#### 3. Find the logic circuit for the K-map:
![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/28ccb249-7ba8-4799-9003-0e5c12751e0b)

In the above case, we can group ones that are adjacent (pol. *sąsiadujące*) to
each other. This can be done vertically or horizontally. As previously we need
to check for which marked fields the inputs are the same:
1. Horizontally for A = 1 and A' = 1. In this case, the output does not depend
on the variable A or A'
2. Vertically for B'C' = 1 and BC' = 1, so F = C, because for B = 1 and B' = 1,
This is not possible.

Summarizing... F = C'.

#### 4. Simplify the Boolean function:
Simplify the Boolean function F = A′BC + A′BC′ + AB′C′ + AB′C.

To build a K-map, the easiest way is to look at the template:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/7f7c306e-ba62-4c5a-950f-6fa6459edbd0)

For each expression separately, we can enter 1 in the table in the appropriate
place:

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/817a5544-3d96-46ec-87de-58c6cde8bf4b)|
|:--:|
|Source: Page 92|

So final K-map looks like:

![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/0a4708cf-a137-49d4-84d7-1e363133ac96)

Based on the previous informations F = A'B + AB'

### Four-variable karnaugh maps
|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/ed677dc0-3e33-43ee-b776-7a4bca56b5b8)|
|:--:|
|Source: https://ittimepass.wordpress.com/2017/02/09/6explain-k-map-and-its-significance-explain-2-variables-3-variables-and-4-variables-k-map |

### Don’t-care combinations
The "Don't care" condition says that we can use the blank cells of a K-map to
make a group of the variables. We mainly use the "don't care" cell to make a
large group of cells. The don’t care combinations are represented by *d* or *x*
or *Φ* in K-map. <br/>
For example, when dealing with BCD (Binary Coded Decimal) numbers encoded as
four bits, we may not care about any codes above the BCD range of (0, 1, 2,...,
9). The 4-bit binary codes for the hexadecimal numbers (Ah, Bh, Ch, Eh, Fh) are
not valid BCD codes. <br/>
Thus, we do not have to fill in those codes at the end of a truth table, or
K-map, if we do not care to. <br/>
We would not normally care to fill in those codes because those codes (1010,
1011, 1100, 1101, 1110, 1111) will never exist as long as we are dealing only
with BCD encoded numbers. These six invalid codes are don’t cares as far as we
are concerned. <br/>
That is, we do not care what output our logic circuit produces for these don’t
cares.

#### 1. Simplify the Boolean function:
Minimize f = m(1,5,6,12,13,14) + d(4) in SOP minimal form. K-map:

|![image](https://github.com/mozerpol/NotesFromLearning/assets/43972902/c5f37c8d-9d8b-46cf-83b0-b4546b2da47a)|
|:--:|
|Source: https://www.javatpoint.com/dont-care-condition-in-k-map-in-digital-electronics|

So, the minimized SOP form of the function is: <br/>
f = BC' + BD' + A'C'D

### The tabulation method
The tabular method, also known as the **Quine-McCluskey** method. It's used for
simplification of the Boolean functions for a large number of variables
(greater than 4).

## 5. Combinational logic circuits <a name="5"></a> [UP↑](#tof)
Combinational circuit can be designed by the following steps:
1. The problem is stated.
2. Identify the input variables and output functions.
3. The input and output variables are assigned letter symbols (input A, B, ...).
4. The truth table is prepared that completely defines the relationship between 
the input variables and output functions.
5. The simplified Boolean expression is obtained by any method of minimization
algebraic method.
6. A logic diagram is realized from the simplified expression using logic gates.

A practical design approach should also consider constraints. Most common 
constraints:
1. Maximum number of gates.
2. Maximum number of outputs.
3. Maximum propagation time of the signal through a circuit.
4. Maximum number of interconnections.
5. Limitations of the driving capabilities of each logic gate. 

### 5.1. Adders <a name="5.1"></a> [UP↑](#tof)
A combinational circuit that performs the addition of two bits without *carry* 
is called a **half-adder**. With *carry* output is **full-adder**. Remember
that the full-adder circuit can be formed with two half-adders and one OR gate.

#### Example of designing a full adder
1. The problem is stated: <br/>
Design a full adder.
2. Identify the input variables and output functions: <br/>
The input data variables as A and B, and previous carry as X. <br/>
Outputs sum as S and carry as C. 
3. The input and output variables are assigned letter symbols (input A, 
B, ...): <br/>

4. The truth table is prepared that completely defines the relationship between 
the input variables and output functions: <br/>

|![image](https://github.com/user-attachments/assets/ec8f866a-86ec-4e8f-8183-6ff47bc104ba)|
|:--:|
|Source: page 128|

5. The simplified Boolean expression is obtained by any method of minimization
algebraic method: <br/>
The Karnaugh map from the truth table:

|![image](https://github.com/user-attachments/assets/8d466547-ed0b-4819-b838-d6e9c628b69b)|
|:--:|
|Source: 128|

The simplified Boolean expressions of the outputs are: <br/>
S = X'A'B + X'AB' + XA'B' + XAB <br/> 
and <br/>
C = AB + BX + AX

6. A logic diagram is realized from the simplified expression using logic 
gates: <br/>

|![image](https://github.com/user-attachments/assets/71f371c6-5162-4e5b-8a14-8099dde60943)
|:--:|
|Source: page 129|

Other configurations can also be developed where number and type of gates are 
reduced.

### 5.2. Substractors <a name="5.2"></a> [UP↑](#tof)
1. The problem is stated: <br/>
Design a full-subtractor.
2. Identify the input variables and output functions: <br/>
The input variables be designated as X and Y and previous borrow as Z, output 
functions difference as D and borrow as B.
3. The input and output variables are assigned letter symbols (input A, 
B, ...): <br/>
4. The truth table is prepared that completely defines the relationship between 
the input variables and output functions: <br/>

|![image](https://github.com/user-attachments/assets/6e731466-4918-412f-8c45-9d70d95f72f8)|
|:--:|
|Source: page 131|

5. The simplified Boolean expression is obtained by any method of minimization
algebraic method: <br/>
The simplified Boolean expressions of the outputs are <br/>
S = X'Y'Z + X'YZ' + XY'Z' + XYZ <br/> 
and <br/>
C = X'Z + X'Y + YZ

|![image](https://github.com/user-attachments/assets/81dcc880-260c-4e05-af51-6639b655c98b)|
|:--:|
|Source: page 131|

6. A logic diagram is realized from the simplified expression using logic 
gates: <br/>

|![image](https://github.com/user-attachments/assets/6c3fa80a-ffeb-4bf1-8e3e-4e86b89da867)|
|:--:|
|Source: page 132|

### 5.3. Code conversion <a name="5.3"></a> [UP↑](#tof)
It is sometimes necessary to interface two digital blocks of different coding 
systems. A conversion circuit must be inserted between two such digital systems 
to use information of one digital system to other. 

#### 5.3.1. Binary to Gray <a name="5.3.1"></a> [UP↑](#tof)

1. The problem is stated: <br/>
Translate 4-bit binary code to gray code.
2. Identify the input variables and output functions: <br/>
he four bits of binary numbers are designated as A, B, C, and D, and gray code 
bits are designated as W, X, Y, and Z.
3. The input and output variables are assigned letter symbols (input A, 
B, ...): <br/>
4. The truth table is prepared that completely defines the relationship between 
the input variables and output functions: <br/>

|![image](https://github.com/user-attachments/assets/cf2ac72b-0f1d-479a-8cf2-c6d6046fbab3)|
|:--:|
|Source: page 133|

