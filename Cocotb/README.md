# cocotb
A very simple use of cocotb + VDHL, so that later I will not have to look for
basic things in the documentation.
_____________

Cocotb provides a way to write testbenches in Python and integrate them with a
diffrent simulators. In my case I used QuestaSim (v.2019) and VHDL. The
communication between cocotb and QuestaSim uses two main components:
1. GPI (Generic Programming Interface) - it is the standardized interface that 
allows communication between the HDL design and the external world. For example, 
a GPI can be used to connect the HDL design with external memory, sensors, 
actuators, or even communication interfaces like Ethernet or USB. The GPI is 
typically implemented using a combination of HDL code and software drivers or 
libraries.
2. FLI (Foreign Language Interface) - it is a mechanism that allows programming 
languages to call functions written in other languages. With FLI, users can call
foreign language routines from the HDL testbench or control ModelSim from an 
external foreign language program.

For clarification: what is difference between GPI and FLI? <br/>
GPI focuses on providing a generic interface that can be used by any programming 
language, while FLI focuses on enabling interaction between specific programming 
languages by creating language bindings or wrappers.

| ![image](https://github.com/mozerpol/learningRISC-V/assets/43972902/592e5f62-0b1f-4c90-809a-1f3427dc4adc) |
|:--:|
| Source: *https://docs.cocotb.org/en/stable/index.html* |

### 1. first
Files:
1. Makefile <br/>
Contains information about project e.g. language, simulator, top entity name,
etc.

2. my_design_top.vhd <br/>
Simple entity with one input signal: `clk` and two internal signals, which are
not dependent on anything and store one bit: <br/>
![first_module](https://github.com/mozerpol/NotesFromLearning/assets/43972902/b043d435-be53-4a4a-9ad8-becf1132a098)

3. test_my_design.py
Two parallel test coroutines. The first one stimulates the "clk" input, it
ends with pass. The second one waits for some time and checks the internal
signals, it ends with failure.

Running a test: <br/>
Type the `make` command in the Makefile directory.

### 2. second
Files:
1. Makefile <br/>
Contains information about project e.g. language, simulator, top entity name,
etc. Added two files to compilation: top and package. Remember about the files
order.

2. my_design_pkg.vhd <br/>
Contains a constant which is used in the top entity.

3. my_design_top.vhd <br/>
Generic, multiplexer and constant from the package were used. Diagram: <br/>
![second](https://github.com/mozerpol/NotesFromLearning/assets/43972902/fc40a04f-01a9-4abc-937d-8022f4a1a944)

4. test_my_design.py <br/>
Two separate coroutines running simultaneously. Test ends with pass.

Running a test: <br/>
Type the `make` command in the Makefile directory.

### My thoughts on using cocotb + ModelSim + VHDL:
1. Debugging is problematic because output from ModelSim contains errors related
to VHDL and Python: <br/>
![output](https://github.com/mozerpol/learningRISC-V/assets/43972902/2931314e-b92c-4a37-9885-fc13dcea1753)

2. Not all features provided by cocotb are supported by ModelSim/QuestaSim, for
example:
```
# Print the instances and signals (which includes the ports) of the design's toplevel
print(dir(dut))
```

3. Changing single bits in a vector is impossible for ModelSim/QuestaSim.
