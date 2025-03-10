# Nios V getting started

## 1. Software used:
- Debian GNU/Linux 12 (bookworm) x86_64
- Tested on: Cyclone IV / MAX 10
- Quartus: Prime 23.1 standard
- Ashling RiscFree: v23.4.1, 3rd Nov 2023 
- Debuger: OpenOCD

Location of the necessary tools (I am providing them because I assume they are 
not in $PATH):
- OpenOCD: ~/Quartus/qprogrammer/linux64/openocd
- Ashling RiscFree: ~/Quartus/riscfree/RiscFree/RiscFree
- juart-terminal: ~/Quartus/qprogrammer/linux64/juart-terminal
- niosv-bsp: ~/Quartus/niosv/bin/niosv-bsp
- niosv-app: ~/Quartus/niosv/bin/niosv-app
- niosv-shell: ~/Quartus/niosv/bin/niosv-shell

## 2. Possible problems
1. To get the latest version of code executed by Nios V, you need to load the 
sof file into the FPGA every time, then compile the Nios V project in RiscFree 
and upload it to Nios V.
2. After loading a fresh sof into the FPGA, debugging only works on the first 
run. In the next runs, Ashling RiscFree returns the error: 
```
Operation failed: 
Command aborted.", and GDB: "Warning: Cannot insert breakpoint 1. Cannot access 
memory at address 0x2cc". 
```
This is probably because GDB has detected `Memory access -> System bus (Data 
width : 128 Address size : 25)` as the way to access memory. This does not 
happen on the first run, and additionally width + address are incorrect and 
their values ​​change between runs. The same happens when trying to run from the 
CLI.

The solution to these problems is to use OpenOCD.

## 3. Hello world
### 3.1. Quartus part
Create a new Nios V project in Quartus:
1. *File* → *New Project Wizard* → ...
Remember the project name, because you will need to enter it later in Platform 
Designer.
2. Open Platform Designer and create a sample Nios V project:
![Image](https://github.com/user-attachments/assets/5d2f6500-0db5-4d09-9f0b-1e9cd425bb21)

Nios V Settings:
![Image](https://github.com/user-attachments/assets/b742fbda-9891-47c5-b5d6-568c6063799e)

Memory settings (memory size must be greater than XXX, I don't remember how
much, large enough):
![Image](https://github.com/user-attachments/assets/29164ed4-f43b-4407-8ad6-d34eff0a6285)

Jtag settings: no changes

3. Assign addresses: *System* → *Assign Base Addresses*.
4. Save the Platform Designer project with the same name as the saved Quartus 
project.
5. Click *Generate HDL* (bottom right corner), it will generate with warnings, 
but that's OK.
6. Click *Finish*.
7. Add the Platform Designer generated file *name*.qip (should be in *name_from_platform_designer/synthesis/name.qpip*). Go to *Files* tab, right 
click *Add/Remove Files* in *Project*:
![Image](https://github.com/user-attachments/assets/a2a9b455-a930-4a5c-b3ce-cbbbeaa69a2d)

8. Start synthesis and assign clk to the appropriate pin in Pin Planner.
9. Compile everything.
10. Upload sof to FPGA.
11. Open the terminal and go to the project directory (where the file with the 
*sopcinfo* extension is, i.e. where the Quartus project is). Run Nios command 
shell:
- `~/Quartus/niosv/bin/niosv-shell`
12. Generate a bsp configuration file for the project. The location where the 
file will be created is important, i.e. *./software/bsp/*:
- `~/Quartus/niosv/bin/niosv-bsp -c -t=hal --sopcinfo=niosv.sopcinfo ./software/bsp/settings.bsp`
After executing this command, it should look something like this:
![Image](https://github.com/user-attachments/assets/11a6b8d0-5e01-4705-be68-d45d78069c7a)

13. Go to the *./software/* directory (where the bsp folder was automatically 
created in the previous step) and create an app directory, and inside it an 
empty file *hello.c*. It should look something like this:
![Image](https://github.com/user-attachments/assets/5aaa93df-2e6b-43c4-a7c3-9af28112030c)

14. Generate a configuration file for Cmake (in the terminal where nios-shell 
is):
- `~/Quartus/niosv/bin/niosv-app -a=./software/app -b=./software/bsp -s=./software/app/hello.c`
Every time something is changed in Platform Designer, you have to repeat steps 8
and 9.
15. Start Ashling RiscFree, in a new instance of the terminal (it can be a new 
tab, nios-shell is in a separate one):
- `~/Quartus/riscfree/RiscFree/RiscFree` <br/>
After the program opens, click *Create a project*.
3. Expand *C/C++* and select the *C Project* option. *Next*.

Project name: app, location for the project is folder: ./software/app/. Project 
type: expand Cmake driven and select options: Empty Project. It should look 
something like this:
![Image](https://github.com/user-attachments/assets/1c63b750-052e-4e88-bdcd-a0d68cf9506b)
