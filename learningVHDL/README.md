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
