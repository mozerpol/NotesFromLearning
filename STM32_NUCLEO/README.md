I used STM32 NUCLEO with STM32F446RET6 MCU.

____

## To install:
1. gcc-arm-none-eabi
Bare metal C and C++ compiler for embedded ARM chips using ARM Cortex-A/R/M 
processors.

2. gdb-multiarch
GNU Debugger (with support for multiple architectures).

3. binutils-arm-none-eabi
GNU assembler, linker and binary utilities for ARM Cortex-R/M processors

4. openocd
OpenOCD (Open On-Chip Debugger) is a tool that allows to program and debug STM32
microcontroller.

5. cmake

6. stlink-tools
OpenSource ST-Link tools replacement. Flashing tools for STMicroelectronics
STM32VL and STM32L

## Check if it works:
arm-none-eabi-gcc --version
arm-none-eabi-g++ --version
gdb-multiarch --version
openocd --version
cmake --version
st-info --version

Script to install all packages and verify is in repo /dotfiles/system_setup/stm32

## How to use

