# learningVerilog
Notes from learning Verilog language and ModelSim.
________________

## Table of contents <a name="tof"></a>
1. [How to run examples?](#1)
	1. [The first way - edaplayground.com](#11)
	2. [The second way - ModelSim](#12)
		1. [How to install](#121)
		2. [Possible problems](#122)
		3. [Using docker](#123)
		4. [How to use](#124)
2. [Skrypt do przedmiotu - Języki modelowania i symulacji](#2)
3. [asic-world](#3)
4. [Język Verilog w projektowaniu układów FPGA](#3)

## 1. How to run examples? <a name="1"></a>
In this repo I'll put some examples of simple digital circuits written in 
Verilog and test them in simulator. <br/>
To do this, you have two ways. First is using online simulator such as 
*edaplayground*, second is install on your computer *ModelSim*. *ModelSim* is a
verification and simulation tool for VHDL, Verilog, SystemVerilog.

### The first way <a name="11"></a>
I'm using https://edaplayground.com/ website, I think if you want run examples 
from this repo, you should register on this website, it's free (at least on the 
day: 06.01.2021). On the screenshot you can see the main view after logging in. 
![screen1](https://user-images.githubusercontent.com/43972902/103824141-a1be5a80-5073-11eb-853b-98fcbf5e5f57.png)

On the left side you can select simulator. I'm using Verilog, so if you want run 
this examples, you should select from drop-down list in part *Tools & Simulators*: 
*Icarus Verilog 0.9.7*. Additionaly, if you want see waveforms, you must check 
*Open **EPWave** after run if not*, which is on the bottom *Tools & Simulators* 
part. <br/>
![screen2](https://user-images.githubusercontent.com/43972902/103824785-e1397680-5074-11eb-9ba5-60d55ea5976b.png)

The left part of our window is for testbench, the right is for design. <br/>
In the bottom part you can add tile for project and description. After clicking 
*save*, you can see your project after clicking bookmark *Playgrounds* and 
*Your Playgrounds*: <br/>
![screen3](https://user-images.githubusercontent.com/43972902/103824927-265da880-5075-11eb-8aa5-e93a198d14f6.png)

Very important thing. If you want see waveforms you must add in testbench:
``` verilog
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
end
```
Of course in initial block you can add more code, but these lines are necessary 
to see vaweforms. Example waveform:
![screen4](https://user-images.githubusercontent.com/43972902/103826398-0cbd6080-5077-11eb-8546-57f35a001551.png)
If you have more signals, but you don't see them on the waveform click 
*Get Signals* and select some.

### The second way - ModelSim <a name="12"></a>
#### How to install <a name="121"></a>
You must install *ModelSim*. I'm linux user (Debian buster 4.19 x64), so everything
will be shown on linux. During installation *Quartus Prime Version 20.1.0 Build 
711 06/05/2020 SJ Lite Edition, Patches Installed: None* was installed 
*ModelSim*, exactly *ModelSim Revision 2020.02*. <br/>

#### Possible problems <a name="122"></a>
Ok, you're lucky if you can run ModelSim without any problems, but I was forced
to reinstall system and now I'm using Debian bullseye 5.10 x64. After this change
I needed install ModelSim once again and unforunatelly it didn't work ;/ <br/>
So to repair it I did (everything on sudo): <br/>
```Shell
dpkg --add-architecture i386
apt update
apt upgrade
apt install libc6:i386 libncurses5:i386 libstdc++6:i386 
apt install lib32z1
apt install lib32ncurses5-dev
apt install libbz2-1.0
```

After this I tried run ModelSim by command (in appropirate directory): <br/>
`./modelsim_ase/bin/vsim`

I receivd an error: <br/>
`modelsim_ase/bin/../linux/vish: error while loading shared libraries: 
libXext.so.6: cannot open shared object file: No such file or directory`

I did: <br/>
`apt install libxext6`

After trying run ModelSim I receivd next error: <br/>
`modelsim_ase/bin/../linux/vish: error while loading shared libraries: 
libXft.so.2: cannot open shared object file: No such file or directory`

I did: <br/>
`apt install libxft2`

And at this point I fortunatelly can run ModelSim on x64 bit Debian. <br/>
Nice source about how to run ModelSim on linux [date of access: 04.10.2021]:
https://profile.iiita.ac.in/bibhas.ghoshal/COA_2020/Lab/ModelSim%20Linux%20installation.html

#### Using docker <a name="123"></a>
Without installing 32-bit libraries you can try with docker, I also described it
here, it's my other repo: https://github.com/mozerpol/modelsim-docker

#### How to use <a name="124"></a>
Ok, so how to run *ModelSim*? After installation, you can find it in: <br/>
`/directory_to_quartus/quartus/modelsim_ase/bin#` <br/>
When you are in *bin* folder run `./vsim` command. Then you'll see the main window <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117305629-3cdb0b80-ae7f-11eb-8081-fe239caa535f.png)

The first steps, how to run and test the first project, are described very well 
in the tutorial created especially for this purpose. You can find 
[here](https://www.microsemi.com/document-portal/doc_view/131618-modelsim-tutorial) 
pdf file or just paste in google *ModelSim tutorial microsemi*. The tutorial is 
about 81 pages. <br/> 
But for my convenience I'll put a few screenshots how to show the waveform if we 
have code in Verilog (in other languages steps will be probably the same).
1. Run ModelSim
2. *File* -> *Change Directory...* -> set appropriate folder in which you want 
save results from simulation. This folder can be diffferent than with the code.
3. *File* -> *New* -> *Library...* -> set the foder name for results from 
simulation. This folder will be inside folder from previous step. Usually I name 
this folder the same as the project name. Additionally check *a new library and 
a logical mapping to it* option and set the same name for *Library Physical Name* 
as for *Library name*: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574053-8aec4b00-b0db-11eb-8567-efc3722b7328.png)
4. *Compile* -> *Compile...* -> set a name for library, the name must be the 
same as in the previous step -> in the same window go to folder with your code 
and select all code files. Click *Compile* and after compiling click *Done*: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574157-1665dc00-b0dc-11eb-8a4f-3313bc6b65de.png)
5. Expand the library and double click on file which you want open and see the 
waveform: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574257-912ef700-b0dc-11eb-8f34-3f69f0d2ea07.png)
6. Right click on main instance and select *Add Wave*: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574370-0bf81200-b0dd-11eb-85bf-01a0a494b699.png)
7. If you have in your testbench `$finish` instruction, I mean, if your 
testbench is not a infinite loop, then better will be click on *Run -All* icon. 
Otherwise, set the simulation time and click on *Run* icon: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574577-19fa6280-b0de-11eb-9a52-07b3c7ac15e7.png)
8. After this probably you will see short waveforms, to extend the waveform to 
the whole window, just click the *Zoom Full* icon: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574673-87a68e80-b0de-11eb-8277-115e99f9d69c.png)
9. After these steps you will see waveforms: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574719-b3297900-b0de-11eb-8d45-3469172f7b65.png)
10. If you want load new file to see the waveforms you must once again change 
the direcotry and repeat all steps, but before this you must write in the console 
(at bottom) `quit -sim`. 

### 2. Język Verilog w projektowaniu układów FPGA: <a name="2"></a>
The script about HDL starts on page 71. <br/>
Verilog allows to add your own procedures in the C language thanks to *Verilog
Procedural Interface*. More [here](https://www.asic-world.com/verilog/pli1.html).
<br/> In the Verilog we have a **four abstract layers**, thanks to this we can 
mix different abstract layers in one project: <br/>
1. Switch Level
2. Gate Level
3. Register-Transfer Level
4. Behavioral level

Every layer should have a different language elements, thanks to this is easier 
to remember the syntax of the language. <br/>
In Verilog, is a difference between uppercase and lowercase letters, so 
*VariaBle* is different than *variable*. <br/>
**Numbers** are written like this: `<size>'<base><number>` <br/>
Where *size* is a decimal number, which tell as how much bits has equivalent in
a binary representation, example: *2'b01* or *8'h9a*. If we not define the size,
then usually it'll be 32 bits. If we not define the base, then usually it'll be
decimal. If is present *x* sign it means undefine state, *z* means tri-state.
Example: *64'bz* - 64-bits number, each bit has hi-Z state. *12'haxc* - 12-bits
hexadecimal number, four numbers in the middle are undefine. Depending on the
base, *x* or *z* in hexadecimal representation means a four bits, in octal a
three bits and one bit in binary system. If we need a better clarity for huge
numbers we can add `_` sign between numbers, example: *8'b0000_1101* or 
*12'b001_101_001_111*. The question mark in the number is equivalent to the high
impedance state. <br/>
In Verilog we can assign to the **signals** different **values**, each value has
different meaning in a physical senese: <br/>

|Value | Meaning|
|:--:|:--:|
|0 | Logic zero, false|
|1 | Logic one, true|
|x | Undefined value|
|z | High impedance state|

Except these values we can assign to each value the **strength level**. If two 
signals controlling the same wire have equal strengths but different values, then
*x* signal will occur on the wire. However, if one of the signals is stronger, 
its value will be fixed on the common wire. <br/>
|Strength level | Type | Description|
|:--:|:--:|:--:|
| supply | Driving | The strongest |
| rtrong | Driving |  |
| pull | Driving |  |
| large | Storage |  |
| weak | Driving |  |
| medium | Storage |  |
| small | Storage |  |
| highz | High Impedance | The weakest |

Important information about *reg* type. <br/>
There is no any guarantee that *reg* type after compilation and synthesis, there
will be a flip-flop in the target circuit in the place of register. It may or
may not. <br/>
In verilog we have **arrays** and **vectors**, both can be *wire* or *reg* type.
Example of vectors: <br/>
```verilog
wire A;          // Scalar
wire [7:0] data; // 8-bit bus
reg [0:31] addr; // 32-bit bus reg type
```
The vector indexing method may be descending *[max:min]* or ascending 
*[min:max]*, but always the left number is the most significant bit. <br/>
Examples of arrays: <br/>
```verilog
integer counter[0:7];   // Array of eight counters
reg bits[3:0];          // Array of 32 one-bit registers
reg [4:0] port_id[0:7]; // Array has eight variables, each has five bits
```
We shouldn't mistake array with vector. Vector is a signle *n*-bit wide element,
array is a set of multiple elements, each is *n*-bit wide. <br/>
Below is nice picture, which I found in the internet, which presents how arrays 
and vectors can look: <br/>
||
|:--:|
| ![image](https://user-images.githubusercontent.com/43972902/129240935-f24d9937-de79-4396-a1fa-9cde75d9ed11.png) |
| Source: *http://www.pepedocs.com/img/fpga-0.png* |

In verilog we can declare a **integer** and **real** numbers**. This type of
numbers act as *reg* vars, we can save inside them any value. <br/>
We must remember about fact, that *real* type of variable are not synthesizable,
*integer* will be 32-bit wire.

```Verilog
integer counter; // Example of integer var
real variable;   // Example of real var
```

**String** type must be in one line, we can't use *enter* in string. Strings are
store in *reg* vars, so should be declared as a reg vector, where width is
number of variables. Example: <br/>
```Verilog
reg [8*4:1] asdf; // reg [8*number_of_characters:1];
// 8 - because strings are ascii characters, so each string needs 8 bits
```

If the declared *reg* value is too small, it will cut the string from the left,
if there are too many declared characters, it will add zeros from the left. In
string we can put special chars, such as *\n*, *\t*, etc. <br/>
**System tasks** are special commands for simulator, which begin with `$` sign.
Example of system tasks: 
1. $display("Hello World") - it print out string on the display. We can also use
it to display values of variables, it's like *printf* in C. Example: <br/>
`$display("Current time: %d and value %b: ", $time, counter)` <br/>
*$display* puts always a newline at the end. We have a several format characters
as in C: 

| Char: | Format: |
|:--:|:--:|
| %d | Decimal |
| %b | Binary |
| %s | String |
| %h | Hex |
| %c | ASCII |
| %f | Real |
| %v | Signal strength |
| %o | Octal |
| %t | Time |

2. $time - return current time of the simulation
3. $monitor - thanks to this we can monitor variables, after any change of var
value monitor will display this change. We can control also *monitor* taske by
using *$monitoron* - to turn on monitoring and *$monitoroff* - to turn off
monitoring.
4. $stop - stop simulation and switches simulator to interactive mode.
5. $finish - ends the simulation.
