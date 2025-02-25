Notes from book STM32 Arm Programming for Embedded Systems by Muhammad Ali 
Mazidi. This book uses STM32 NUCLEO with STM32F446RET6 MCU.

____

## 1. C for Embedded Systems
The C standards do not specify the size of data types. <br/>
- float, double - are standardized by the IEEE754,
- char, short - are often set at 1 byte and 2 bytes,
- int - often depending on the data size of the CPU but rarely go below
16 or above 32,
- long, long long are implemented the same way everywhere.

The description of how much memory a data type occupies is described in ARM 
EABI. The ARM EABI (Embedded Application Binary Interface) is a standard that 
defines a mapping between low-level concepts in high-level languages and the 
abilities of a specific hardware/OS platform's machine code. 

Arithmetic Types from ARM EABI documentation:
![Image](https://github.com/user-attachments/assets/fcb875bd-246e-471e-9027-5c3248b684ee)

Size of data types from ARM EABI documentation:
![Image](https://github.com/user-attachments/assets/78924c91-7e90-4cc3-b3b5-aa17ad8c7921)

The Arm architecture with 32-bit data bus reads the memory with a minimum of 32 
bits on the 4-byte boundary (address ending in 0, 4, 8, and C in hex). What 
does mean 4-byte boundary address? It means that an address is a multiple of 4:
```
0x00000000
0x00000004
0x00000008
0x0000000C
0x00000010
0x00000014
0x00000018
```
It is crucial for optimal performance and correct operation on ARM processors.
Accessing data that is not aligned to its natural boundary can lead to 
performance penalties or even hardware exceptions on some architectures. Load 
and store instructions for 32-bit data types expect the addresses to be aligned 
to 4-byte boundaries. If a short int variable is allocated straddling (pol. 
*rozkraczający się*) the 4-byte boundary, access to that variable is called an 
unaligned access. Unaligned access can be avoided by either padding the 
variables with unused bytes. 

By default variables are considered as *signed* unless the *unsigned* keyword
is used.

If you use a short int to hold the number of seconds of a day, 9 hours 6 minutes 
and 7 seconds into the day, the second count will overflow from 32,767 to 
-32,768. Even if your program handles negative second count, the time will jump 
back to the day before.

If you write a statement with different operand data types for a binary 
operation, the compiler will convert the smaller data type to the bigger data 
type. If it is an assignment operator (A = B), the right hand side operand is 
converted to the left hand side data type before the assignment. These implicit 
data type conversion is called *coercion*.

In ISO C99 standard, a set of data types were defined with number of bits and 
sign clearly defined in the data type names. These integer data types are 
defined in a header file called *stdint.h*:

ISO C99 integer data types and their ranges:
![Image](https://github.com/user-attachments/assets/5d4cd016-6482-4da6-8d0c-f3f71a1895a3)

Comparison between AVR GCC and ARM GCC in context of data types:
![Image](https://github.com/user-attachments/assets/89334877-3bc0-4fcb-9a2f-0ed5c350801b)

In conclusion:
1. In an 8-bit system we use (char, unsigned char) for the number of months in a 
year.
2. For a system with 16-bit address, bus we use (int, unsigned int) for address 
definition.
3. For an Arm system the address is 32 bit wide and we use unsigned int data
type for it.

OR can be used to set a bit or bits, and AND can be used to clear a bit or bits.

## 2. STM Arm I/O Programming

STM32 Arm Cortex Portfolio:
![Image](https://github.com/user-attachments/assets/fa189f6b-81ec-4c41-81d6-15492ca08685)

The STM32F4xx is based on Cortex-M4 while STM32F0 uses Cortex-M0+.

STM32F446RE Arm Microcontroller Block Diagram. Can be taken from datasheet - 
STM32F446xC/E - Arm Cortex-M4:
![Image](https://github.com/user-attachments/assets/9aa5ea88-b8eb-40a0-a742-87f8b02f63f6)

STM32F446RE Nucleo board top layout taken from user manual:
![Image](https://github.com/user-attachments/assets/02a3b22a-872e-47fc-802d-76187688aad4)

Memory map for STM32F446RET6, taken from datasheet:
![Image](https://github.com/user-attachments/assets/193f1892-1dd6-4f90-8957-b39637d4b976)

As you can notice, the MCU has 4GB (Giga bytes) of memory address space. It 
also uses memory mapped I/O, meaning the I/O peripheral registers are mapped 
into the 4GB memory space. 

| Memory type | Memory size | Address range | 
|:--:|:--:|:--:|
| Flash | 512KB | 0x00000000-0x0007FFFF |
| SRAM | 128KB | 0x20000000-0x20001FFFF |
| I/O | | 0x40000000-0x4xxxxxxx |

1. Flash memory is used for program code.
2. SRAM is for variables, scratch pad, and stack. It starts at address
0x20000000.
3. The peripherals such as GPIO, Timers, ADCs are mapped to addresses
starting at 0x40000000.

[STM32‘s naming convention](https://www.digikey.com/en/maker/tutorials/2020/understanding-stm32-naming-conventions).

### 2.1. GPIO Registers Address

The Arm chips have two types of buses: APB (Advanced Peripheral Bus) and AHB 
(Advanced HighPerformance Bus). The AHB bus is much faster than APB. The AHB 
allows one clock cycle access to the memory and fast peripherals without any 
wait state. The APB is slower and its access time is a minimum of 2 clock 
cycles. 
1. AHB is a high performance bus designed to interface memory and fast I/Os 
directly to the CPU.
2. APB is designed for lower speed and low power consumption memory and 
peripherals.

Each APB bus connects to certain peripherals and each peripheral is allocated 
certain (pol. *pewny*) address space. In the STM32 Arm, the GPIO ports are
connected to AHB bus via AHB/APB1 and AHP/APB2 bridges. The AHB and memories are 
connected to CPU via what is called Bus Matrix. STM32F446xC/E and Multi-AHB 
matrix:
![Image](https://github.com/user-attachments/assets/7a8ff66b-d582-40da-ac1c-67fa6d34b3bd)

Each peripheral such as GPIO, Timer, and ADC are assigned a set of addresses. 
The first address is called the base address. Each peripheral has multiple 
special function registers. Each register has an address. The register address 
is an offset address from the base address:
- GPIO Port A: 0x4002 0000 - 0x4002 03FF
- GPIO Port B: 0x4002 0400 - 0x4002 07FF
- GPIO Port C: 0x4002 0800 - 0x4002 0BFF
- GPIO Port D: 0x4002 0C00 - 0x4002 0FFF
- GPIO Port E: 0x4002 1000 - 0x4002 13FF
- GPIO Port F: 0x4002 1400 - 0x4002 17FF
- GPIO Port G: 0x4002 1800 - 0x4002 1BFF
- GPIO Port H: 0x4002 1C00 - 0x4002 1FFF
- GPIO Port I: 0x4002 2000 - 0x4002 23FF

Generally, every microcontroller has a minimum of two registers associated with 
each of I/O port. They are *Direction Register* and *Data Register*. The
Direction register is used to make the pin either input or output. After the
Direction register is properly configured, then we use the Data register to
actually write to the pin or read data from the pin. It is the Direction 
register (when configured as an output) that allows the information written to 
the Data register to be driven to the pins of the device.
![Image](https://github.com/user-attachments/assets/bdd05c50-bf2f-4f52-89b5-0f8f180ed2a6)

In STM Arm the direction register is part of the GPIOx_MODER which stands for 
GPIO Mode Register. For each GPIO pin, there are two corresponding bits in the 
MODER register. These two bits need to be a 00 to configure the port pin as 
input and a 01 as output. This register is also used to set the alternative 
function mode for each pin, in addition to deciding if it is used for analog or 
digital I/O:
![Image](https://github.com/user-attachments/assets/9296afa3-47ba-4eee-9863-7f87ce60bd52)

The output register in STM Arm is called GPIO port output data register
(GPIOx_ODR) in which x can be A, B, C, ... They are located at the offset
address of 0x14 from the Base address of that port. In the Reference manual
(don't confuse with datasheet) RM0390 for STM32F446xx advanced Arm-based 32-bit 
MCUs can be found information about GPIO ODR. GPIO port output data register 
(GPIOx_ODR) (x = A..H)
![Image](https://github.com/user-attachments/assets/d71205e4-67b0-406b-a413-1c871c18373e)

Bits 15:0 ODRy: Port output data (y = 0..15). These bits can be read and written
by software.

### 2.2. The Clock Enable of the Peripheral Registers
By default, the GPIO modules of the STM32 Arm microcontrollers have the clock 
disabled coming out of power-on reset. So the programmers have to enable the 
clock to a given I/O port or peripheral before using it. This is done with a 
group of registers belonging to RCC (Reset and Clock Control) registers. For the 
STM32F446 chips, the GPIO clock enable is controlled by lower bits of 
RCC_AHB1ENR (AHB1 Enable Register). This is not standard across all STM Arm 
family:
![Image](https://github.com/user-attachments/assets/77bc3b74-f561-4f2c-b768-bf1c2cd84089)

![Image](https://github.com/user-attachments/assets/fc65506b-4dae-4ec6-b9f5-8f396e304459)

In STM32F446RE Nucleo board, there is a single user LED. It is designated as 
LD2. The user LED is connected to PA5 pin of Port A. To toggle the user LD2 
(green) of the Nucleo board, the following steps must be followed:
1. Set the Mode register bits for PA5 as output,
2. write HIGH to PA5 in data OUT register,
3. call a delay function,
4. write LOW to PA5 in data OUT register,
5. call a delay function,
6. repeat steps 2 to 5.
