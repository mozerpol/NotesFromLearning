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
