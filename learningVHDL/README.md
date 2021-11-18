# learningVHDL
Notes from learning VHDL language.
________________

## Table of contents <a name="tof"></a>
1. [How to run examples](#1)
2. [Skrypt do przedmiotu - Języki modelowania i symulacji](#2)

## 1. How to run examples? <a name="1"></a>
In this repo I'll put some examples of simple digital circuits written in
VHDL and test them in simulator. <br/>
To do this, you have two ways. First is using online simulator such as
*edaplayground*, second is install on your computer *ModelSim*. *ModelSim* is a
verification and simulation tool for VHDL, Verilog, SystemVerilog. I described
[here](https://github.com/mozerpol/NotesFromLearning/tree/master/learningVerilog#1)
how to use *edaplayground* and *Modelsim*.

## 2. Język Verilog w projektowaniu układów FPGA: <a name="2"></a>
The script about VHDL starts on page 110. <br/>
VHDL - *Very High Speed Integrated Circuits Hardware Description Language*. In
the 1993 introduced standard *1164*, where defined data type. 
The data types have been grouped together in a package called *std_logic_1164*.
Except this we have a different extensions of VHDL language: <br/>
- 1076.1 - VHDL-AMS - added the ability to simulate and model analog circuits
- 1076.2 - includess data types which are needed for high-level modeling and 
    simulation like *math_real* or *math_complex*.
- 1076.3 - includes data types, which are needed for synthesis: *numeric_bit* or
    *numeric_std*
- 1076.4 - describes delays in digital circuits: *vital*.

VHDL allows to add your own procedures in the C language thanks to *VHPI* - *VHDL
Procedural Interface*. In the VHDL we have usually a three abstract layers,
thanks to this we can mix different abstract layers in one project:
- Behavioral level - here, we're focus mainly how output react on input signals.
    We not care how to realize circuit inside FPGA, we not care about clock
    frequency or word lenth.
- Register Transfer level - lower abstract level than *behavioral*. It
    corresponds to a detailed block description in a traditional design method,
    where are used functional blocks and their functions, input and output signals,
    and data buses. Clock and reset signals must be defined in the project, and 
    data buses and memory elements (flip-flops, counters, memories) must be 
    assigned specific numbers of bits. 
- Structural level - the structure of this layer is similar to the list of
    connections, which shows the project as a structure of elements connected by
    signal networks.

Unlike Verilog, variable names and keywords are not case-sensitive, e.g keyword
*ENTITY* is equal *entity* or *TRUE* is equal *TRUE*. Comments are after `--`
signs: <br/>
```vhdl
rst_i : in std_ulogic; -- Comment
-- Next part of comment
```
VHDL has a list of reserved words that are part of the language and cannot be 
used for block names, signals, or other identifiers. The reserved words are 
shown below:
|![image](https://user-images.githubusercontent.com/43972902/142483788-9feb2bf3-61a0-49cb-b2f6-3a71ef249afe.png)|
|:--:|
|VHDL reserved words|
|Source: *Języki  modelowania i symulacji, B. Pankiewicz, M. Wójcikowski p. 114*|

A way of writing integer numbers: <br/>

|What| How|
|:--:|:--:|
|Decimal base|170, 1_7_0, 10#170#|
|Binary base|2#1010_1010#|
|Octal base|8#252#|
|Hex base|16#AA#|

A way of writing real numbers: <br/>

|What| How|
|:--:|:--:|
|Decimal base|123.1|
|Binary base|2#101001.01#e1|
|Octal base|8#1234567.54#|
|Hex base|16#abC.d#|

A single alphanumeric character we write using single quotation mark: `'a'` or
`'B'`. <br/>
String constants are indicated by quotation marks: `"Ala ma kota"` or `"Abc"`.
<br/> We can write strings of bits as bit-string literals: `"1001_1001"`, 
`B"1001_1001"` or `O"167"X"abC"`, where sign *B*, *X* or *O* means base.

Enum type is a basic type in VHDL. It is defined by specifying all values that a
variable can have: <br/>
```VHDL
type <type_name> is ( <value_1>, <value_2>, ..., <value_n>);
```

Order of values is important. The value on the left is considered as the
smallest and the simulator initializes the signals with the value on the left
first. Example: <br/>
```VHDL
type t_COLOR is (RED, GREEN, BLUE);
type t_MYTYPE is ('0', '1', 'U', 'Z');
```
Examples of value assignments to variables of an enumerated type: <br/>
```VHDL
variable x_v : t_COLOR;
signal a: t_MYTYPE;
x_v := BLUE;
a <= 'Z';
```
