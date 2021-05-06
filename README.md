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

The first steps, how to run and test the first project, are described very well in the tutorial created especially for this purpose. You can find [here](https://www.microsemi.com/document-portal/doc_view/131618-modelsim-tutorial) pdf file or just paste in google *ModelSim tutorial microsemi*. The tutorial is about 81 pages.
