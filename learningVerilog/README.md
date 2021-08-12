# learningVerilog
Notes from learning Verilog language and ModelSim.
________________
### How to run examples?
In this repo I'll put some examples of simple digital circuits written in Verilog and test them in simulator. <br/>
To do this, you have two ways. First is using online simulator such as *edaplayground*, second is install on your computer *ModelSim*. *ModelSim* is a verification and simulation tool for VHDL, Verilog, SystemVerilog.

#### First way
I'm using https://edaplayground.com/ website, I think if you want run examples from this repo, you should register on this website, it's free (at least on the day: 06.01.2021). On the screenshot you can see the main view after logging in. 
![screen1](https://user-images.githubusercontent.com/43972902/103824141-a1be5a80-5073-11eb-853b-98fcbf5e5f57.png)

On the left side you can select simulator. I'm using Verilog, so if you want run this examples, you should select from drop-down list in part *Tools & Simulators*: *Icarus Verilog 0.9.7*. Additionaly, if you want see waveforms, you must check *Open **EPWave** after run if not*, which is on the bottom *Tools & Simulators* part. <br/>
![screen2](https://user-images.githubusercontent.com/43972902/103824785-e1397680-5074-11eb-9ba5-60d55ea5976b.png)

The left part of our window is for testbench, the right is for design. <br/>
In the bottom part you can add tile for project and description. After clicking *save*, you can see your project after clicking bookmark *Playgrounds* and *Your Playgrounds*: <br/>
![screen3](https://user-images.githubusercontent.com/43972902/103824927-265da880-5075-11eb-8aa5-e93a198d14f6.png)

Very important thing. If you want see waveforms you must add in testbench:
``` verilog
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
end
```
Of course in initial block you can add more code, but these lines are necessary to see vaweforms. Example waveform:
![screen4](https://user-images.githubusercontent.com/43972902/103826398-0cbd6080-5077-11eb-8546-57f35a001551.png)
If you have more signals, but you don't see them on the waveform click *Get Signals* and select some.

#### Second way
You must install *ModelSim*. I'm linux user (Debian buster 4.19), so everything will be shown on linux. During installation *Quartus Prime Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition, Patches Installed: None* was installed *ModelSim*, exactly *ModelSim Revision 2020.02*. <br/>
Ok, so how to run *ModelSim*? After installation, you can find it in: <br/>
`/directory_to_quartus/quartus/modelsim_ase/bin#` <br/>
When you are in *bin* folder run `./vsim` command. Then you'll see the main window <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117305629-3cdb0b80-ae7f-11eb-8081-fe239caa535f.png)

The first steps, how to run and test the first project, are described very well in the tutorial created especially for this purpose. You can find [here](https://www.microsemi.com/document-portal/doc_view/131618-modelsim-tutorial) pdf file or just paste in google *ModelSim tutorial microsemi*. The tutorial is about 81 pages. <br/>
But for my convenience I'll put a few screenshots how to show the waveform if we have code in Verilog (in other languages steps will be probably the same).
1. Run ModelSim
2. *File* -> *Change Directory...* -> set appropriate folder in which you want save results from simulation. This folder can be diffferent than with the code.
3. *File* -> *New* -> *Library...* -> set the foder name for results from simulation. This folder will be inside folder from previous step. Usually I name this folder the same as the project name. Additionally check *a new library and a logical mapping to it* option and set the same name for *Library Physical Name* as for *Library name*: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574053-8aec4b00-b0db-11eb-8567-efc3722b7328.png)
4. *Compile* -> *Compile...* -> set a name for library, the name must be the same as in the previous step -> in the same window go to folder with your code and select all code files. Click *Compile* and after compiling click *Done*: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574157-1665dc00-b0dc-11eb-8a4f-3313bc6b65de.png)
5. Expand the library and double click on file which you want open and see the waveform: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574257-912ef700-b0dc-11eb-8f34-3f69f0d2ea07.png)
6. Right click on main instance and select *Add Wave*: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574370-0bf81200-b0dd-11eb-85bf-01a0a494b699.png)
7. If you have in your testbench `$finish` instruction, I mean, if your testbench is not a infinite loop, then better will be click on *Run -All* icon. Otherwise, set the simulation time and click on *Run* icon: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574577-19fa6280-b0de-11eb-9a52-07b3c7ac15e7.png)
8. After this probably you will see short waveforms, to extend the waveform to the whole window, just click the *Zoom Full* icon: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574673-87a68e80-b0de-11eb-8277-115e99f9d69c.png)
9. After these steps you will see waveforms: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/117574719-b3297900-b0de-11eb-8d45-3469172f7b65.png)
10. If you want load new file to see the waveforms you must once again change the direcotry and repeat all steps, but before this you must write in the console (at bottom) `quit -sim`. 

Nice picture about arrays in verilog: <br/>
||
|:--:|
| ![image](https://user-images.githubusercontent.com/43972902/129240935-f24d9937-de79-4396-a1fa-9cde75d9ed11.png) |
| Source: *http://www.pepedocs.com/img/fpga-0.png* |







