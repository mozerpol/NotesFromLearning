I used STM32 NUCLEO with STM32F446RET6 MCU.

____

## 1. To install:
1. gcc-arm-none-eabi <br/>
Bare metal C and C++ compiler for embedded ARM chips using ARM Cortex-A/R/M
processors.

2. gdb-multiarch <br/>
GNU Debugger (with support for multiple architectures).

3. binutils-arm-none-eabi <br/>
GNU assembler, linker and binary utilities for ARM Cortex-R/M processors.

4. openocd <br/>
OpenOCD (Open On-Chip Debugger) is a tool that allows to program and debug STM32
microcontroller.

5. stlink-tools <br/>
OpenSource ST-Link tools replacement. Flashing tools for STMicroelectronics
STM32VL and STM32L.

#### 1.1 Check if it works:
arm-none-eabi-gcc --version <br/>
arm-none-eabi-g++ --version <br/>
gdb-multiarch --version <br/>
openocd --version <br/>
st-info --version

Script how to install all packages and verify them is in repo
/dotfiles/system_setup/stm32
[here](https://github.com/mozerpol/dotfiles/tree/master/system_setup/STM32).

## 2. Directory tree
```
|___README.md (this file)
|___Makefile
|___linker_script.ld
|___Build/
|   |___Obj/
|   |___Bin/
|___Src/
|   |___C files
```

C files are in Src/ <br/>
Object files are in Build/Obj <br/>
Binary files and executable are in Build/Bin <br/>
Makefile is in main dir <br/>
Linker script (*.ld) is in main dir

## 3. Usage
`make` - Compile and link. <br/>
`make clean` - Remove files from Build/Obj and Build/Bin. <br/>
`make flash` - Load firmware to the mcu.


