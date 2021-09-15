## Eksperymenty z FPGA (1)
*Elektronika Praktyczna* Nr 12 (323) • 12.2019

The beginning is about how to install software, where you can find it, etc. <br/>
The original code is here: http://bit.ly/2Y4d8I3, inside *01_gates* folder.

After running modelsim (how to run using docker 
[here](https://github.com/mozerpol/modelsim-docker)) run command (you must be
inside folder with code) `do gates_sim.do`. <br/> 
Before runing above command: 
![b](https://user-images.githubusercontent.com/43972902/132034210-54617b9c-9a11-401e-82c2-1f1637fdf0a8.png)

After this command will appear a few new windows: <br/>
![a](https://user-images.githubusercontent.com/43972902/132034216-fbdc47a7-0515-422d-a6da-cae71f2898e3.png)

Project after compilation took 3 registers and 3 logic element: <br/>
![image](https://user-images.githubusercontent.com/43972902/133252490-7a13b842-74ea-4493-b11f-c39ed6743e06.png)

On the FPGA we can create almost every digital circuit. Thanks to HDL languages
we can transform our code to digital circuit which will be implemented on FPGA.
In Quartus we can see what electronic circuit describes our code. To do this
expand: <br/>
*Analysis & Synthesis* -> *Netlist Viewers* -> double click on *RTL Viewer* <br/>
![image](https://user-images.githubusercontent.com/43972902/133253582-1e240ca7-7b96-4de7-b70b-d4c677f32ae3.png)

RTL (Register Transfer Level) Viewer: <br/>
![image](https://user-images.githubusercontent.com/43972902/133254070-13b11b5c-2718-4282-9cff-f3219e4eea4b.png)

RTL Viewer is readable and easy to understand, however it doesn't include the
resources contained in a particular FPGA model. To find out how the project 
will be implemented, let's choose: <br/>
*Technology Map Viewer (Post-Mapping)*. Should appear: <br/>
![image](https://user-images.githubusercontent.com/43972902/133256085-ee309282-5f24-4367-a700-68e1f57f6e44.png)

As we can see, we have input/output buffers. On the other hand, logic gates have
disappeared. They were replaced by LUT (lookup table) blocks - logical functions 
written with an array of values. If we right-click the LUT and select *Properties*, 
in the left panel we can see how the function is encoded in the table: <br/>
![image](https://user-images.githubusercontent.com/43972902/133266839-269388ea-50d8-4232-bb93-25e2cc5351bb.png)

We can also see exactly what the consumption of resources is in the logical element.
From datasheet of *MAX 10* circuit we can find out how LE looks: <br/>
![image](https://user-images.githubusercontent.com/43972902/133267428-e87efbc2-a823-4d86-8021-0bb402926a57.png)

To see the consumption of resources in LE just right click on LE -> *Locate 
Node* -> *Locate in Resource Properity Editor*: <br/>
![image](https://user-images.githubusercontent.com/43972902/133268044-247e6e8d-12f1-4a01-bbc9-be172f9de70e.png)

After this we'll see: <br/>
![image](https://user-images.githubusercontent.com/43972902/133268759-7228faf3-20c7-4951-857e-dfa68d16ca84.png)

As we can see, this picture is very similar to this from datasheet.

## Eksperymenty z FPGA (2)
*Elektronika Praktyczna* Nr 1 (324) • 01.2020

Next issue concerns to the same thing, so I decided dedicate this repo for the 
next issue as well.

The first step is about *Pin Planner* and assignment output pins to thier
corresponding variables in the code. <br/>
In my board (Terasic T-core) I have a four LEDs:<br/>
![image](https://user-images.githubusercontent.com/43972902/133431945-6e412f27-9aa8-457d-8590-ad66dc950979.png)

As you can see the output one of them is connected to GND, so if we want control
this LED we must use internal pull-up. To do this right click on the header of
the table with pins and choose *Customize Columns* option: <br/>
![image](https://user-images.githubusercontent.com/43972902/133432600-e96e63e5-603c-4795-80ce-1003b88676b4.png)

There select *Weak Pull-Up Resistor* and move to the right column. Afther this
click *OK*: <br/>
![image](https://user-images.githubusercontent.com/43972902/133433176-b5b1f2f0-8b33-4c92-b589-b6e711f09fd8.png)

Now will appear new column *Weak Pull-up Resistor*, where you cant turn on or
off internal resistor.

Fitter - this tool is using to assign appropirate resource to specific element
and configure connections between them. A fter running *fitter* (double click
on *Fitter Place & Route*) we'll see in the *Flow Summary* window we're using
one more ligic element than analysis indicated on it. <br/>
Expand *Fitter Place & Route* and select *Technology Map Viewer (Post-Fitting)*.
<br/>
![image](https://user-images.githubusercontent.com/43972902/133453004-659352b8-d6bd-4379-9b30-46034f79afae.png)

After fittering (I hope I can name that this activity) we can see that we have
a small changes if we want compare to *RTL Viewer* (*Technology Map Viewer 
(Post-Mapping)*), but still our device consists three LUT and flip flops: <br/>
![image](https://user-images.githubusercontent.com/43972902/133453776-08f04ee1-2db6-40c0-a0f7-a08d5c119c87.png)

However, among others, we have in addition the configuration of the JTAG 
interface and the ADC converter. Exactly these elements used the fourth logic
element.

We can run once again *Resource Properity Editor* and ascertain that LUT and 
flip-flop comes from one logic element: <br/>
![image](https://user-images.githubusercontent.com/43972902/133456393-9b150714-51bb-4a7b-beae-63b22de980d0.png)

