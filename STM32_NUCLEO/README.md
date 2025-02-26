I used STM32 NUCLEO with STM32F446RET6 MCU.

____

## 1. First_approach vs. Second_approach
The first approach does not contain additional CMSIS libraries. Thanks to this,
writing code is more bare metal, because it does not depend on external
libraries, but it is necessary to define directives that refer to specific
registers, for example:
```cpp
#define RCC_BASE      (0x40023800UL) // RCC base address
#define RCC_AHB1ENR   (*(volatile uint32_t *)(RCC_BASE + 0x30))

int main(void)
{
    RCC_AHB1ENR |= (1 << 0); // Enable clock for GPIOA
}
```

Using the CMSIS libraries you can refer to registers directly in your code, for
example:
```cpp
#include "stm32f446xx.h"

int main(void)
{
    RCC->AHB1ENR |= 1; // Enable clock for GPIOA
}
```

## 1.2 What is CMSIS
CMSIS, which stands for Cortex Microcontroller Software Interface Standard, is a
vendor-independent hardware abstraction layer (HAL) developed by ARM for
Cortex-M microcontrollers. CMSIS consists of APIs, software components, tools,
and workflows that help to simplify software re-use, reduce the learning curve.
In this repository I use CMSIS which maps only registries.

## 2. To install:
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

#### 2.1 Check if it works:
arm-none-eabi-gcc --version <br/>
arm-none-eabi-g++ --version <br/>
gdb-multiarch --version <br/>
openocd --version <br/>
st-info --version

Script how to install all packages and verify them is in repo
/dotfiles/system_setup/stm32
[here](https://github.com/mozerpol/dotfiles/tree/master/system_setup/STM32).

## 3. Usage
`make` - Compile and link. <br/>
`make clean` - Remove files from Build/Obj and Build/Bin. <br/>
`make flash` - Load firmware to the mcu.
