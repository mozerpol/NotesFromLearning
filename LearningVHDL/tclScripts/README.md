The script_1 folder consists of three gates. Two gates are instantiated in the
third. The tcl script compiles all files, runs simulation, and displays signals
on waveforms.

The script_2 folder contains several testcases, during compilation they are 
combined into one test, in the tb.vhdl file. The tcl script detects the line 
*-- "! Insert Testcase Here !"* which is in header.vhdl and places the 
testcases below it, which are in separate files.
