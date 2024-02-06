# cocotb
A very simple use of cocotb + VDHL, so that later I will not have to look for
basic things in the documentation.
_____________

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
