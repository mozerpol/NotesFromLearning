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


