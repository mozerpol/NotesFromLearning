# learningVerilog
Notes from learning verilog language
________________
### How to run examples?
I'm using https://edaplayground.com/ website, I think if you want run examples from this repo, you should register on this website, it's free (at least on the day: 06.01.2021). On the screenshot you can see the main view after logging in. 
![screen1](https://user-images.githubusercontent.com/43972902/103824141-a1be5a80-5073-11eb-853b-98fcbf5e5f57.png)

On the left side you can select simulator. I'm using Verilog, so if you want run this examples, you should select from drop-down list in part *Tools & Simulators*: *Icarus Verilog 0.9.7*. Additionaly, if you want see waveforms, you must check *Open **EPWave** after run if not*, which is on the bottom *Tools & Simulators* part.
![screen2](https://user-images.githubusercontent.com/43972902/103824785-e1397680-5074-11eb-9ba5-60d55ea5976b.png)

The left part of our window is for testbench, the right is for design. <br/>
In the bottom part you can add tile for project and description. After clicking *save*, you can see your project after clicking bookmark *Playgrounds* and *Your Playgrounds*:
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
