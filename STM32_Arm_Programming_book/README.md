Notes from book STM32 Arm Programming for Embedded Systems by Muhammad Ali
Mazidi. This book uses STM32 NUCLEO with STM32F446RET6 MCU.

____

## Table of contents <a name="tof"></a>
1. [1. C for Embedded Systems](#1)
2. [STM Arm I/O Programming](#2)
   1. [2.1. GPIO Registers Address](#21)
   2. [2.2. The Clock Enable of the Peripheral Registers](#22)
      1. [2.2.1. How to set the high state on LD2](#221)
      2. [2.2.2. Reading a switch in STM Arm](#222)
      3. [2.2.3. Seven-segment LED interfacing](#223)

____

## 1. C for Embedded Systems <a name="1"></a>
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

## 2. STM Arm I/O Programming <a name="2"></a>

STM32 Arm Cortex Portfolio:
![Image](https://github.com/user-attachments/assets/fa189f6b-81ec-4c41-81d6-15492ca08685)

The STM32F4xx is based on Cortex-M4 while STM32F0 uses Cortex-M0+.

STM32F446RE Arm Microcontroller Block Diagram. Can be taken from datasheet -
STM32F446xC/E - Arm Cortex-M4:
![Image](https://github.com/user-attachments/assets/9aa5ea88-b8eb-40a0-a742-87f8b02f63f6)

STM32F446RE Nucleo board top layout taken from user manual:
![Image](https://github.com/user-attachments/assets/02a3b22a-872e-47fc-802d-76187688aad4)

Pinout:
![Image](https://github.com/user-attachments/assets/b39926d8-0e64-4455-b4a8-efbeab5ad3aa)

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

### 2.1. GPIO Registers Address <a name="21"></a>

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
the Data register to be driven to the pins of the device:

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

### 2.2. The Clock Enable of the Peripheral Registers <a name="22"></a>
By default, the GPIO modules of the STM32 Arm microcontrollers have the clock
disabled coming out of power-on reset. So the programmers have to enable the
clock to a given I/O port or peripheral before using it. This is done with a
group of registers belonging to RCC (Reset and Clock Control) registers. For the
STM32F446 chips, the GPIO clock enable is controlled by lower bits of
RCC_AHB1ENR (AHB1 Enable Register). This is not standard across all STM Arm
family:
![Image](https://github.com/user-attachments/assets/77bc3b74-f561-4f2c-b768-bf1c2cd84089)

![Image](https://github.com/user-attachments/assets/fc65506b-4dae-4ec6-b9f5-8f396e304459)

#### 2.2.1. How to set the high state on LD2 <a name="221"></a>
1. Check which pin the LD2 LED is connected to. According to datasheet for STM32
Nucleo board: "User LD2: the green LED is a user LED connected to [...] STM32
I/O PA5".
2. Enable clock for port A. <br/>
Register RCC_AHB1ENR can enable or disable clock for GPIOx. Base address of
RCC_AHB1ENR is RCC address + RCC_AHB1ENR offset = 0x40023800 + 0x30 = 0x40023830,
this can be found in reference manual in the table STM32F446xx register boundary
addresses.

| ![Image](https://github.com/user-attachments/assets/d5b48e72-8065-4951-a855-f52eab935dbf) |
|:--:|
| *STM32F446xx register boundary addresses.* |

| ![Image](https://github.com/user-attachments/assets/5e641a7c-166f-4a2f-ba1f-449c1fc75f1b) |
|:--:|
| *RCC register map and reset values.* |

C code that enables the clock for GPIOA:
```cpp
#define RCC_BASE    (0x40023800UL) // RCC base address
#define RCC_AHB1ENR (*(volatile uint32_t *)(RCC_BASE + 0x30)) // RCC base address + GPIOA offset
RCC_AHB1ENR |= (1 << 0); // Enable clock for GPIOA
```

3. Set PA5 (LD2) as output. <br/>
The GPIOx_MODER register sets the direction for GPIOx. Base address for
GPIOx_MODER for GPIOA is 0x40020000. Offset for GPIOA is 0x00. Pin PA5
corresponds for bits no. 10 and 11 in GPIOA_MODER.

| ![Image](https://github.com/user-attachments/assets/7270e44a-f635-4219-83e4-70ec775c3964) |
|:--:|
| *Boundary address for GPIOA is in Reference manual in table STM32F446xx register boundary addresses.* |

| ![Image](https://github.com/user-attachments/assets/db51e7a7-751d-4aab-93c0-5097860259d2) |
|:--:|
| *GPIOA_MODER sets the direction for GPIOA, can be found in Reference manual in GPIO register map and reset values.* |


C code that sets pin PA5 as an output:
```cpp
#define GPIOA_BASE  (0x40020000UL) // GPIOA base address
#define GPIO_MODER  (*(volatile uint32_t *)(GPIOA_BASE + 0x00)) // Offset for GPIOA
GPIO_MODER |= (1 << 10); // Set bit 1 to set direction as an output, bit 10 is assigned to PA5
```

4. Set pin PA5 to a high state. <br/>
This can be done by controlling the ODR register. <br/>
Each GPIO port has its own ODR register. The ODR register is a 16-bit register
for each GPIO port:
- Bit 0 corresponds to PA0,
- Bit 1 corresponds to PA1,
- Bit 2 corresponds to PA2,
- ...,
- Bit 15 corresponds to PA15.

Offset for GPIOA is 0x14. <br/>

Code that sets pin PA5 to a high state:
```cpp
#define RCC_BASE (0x40023800UL) // RCC base address
#define GPIO_ODR (*(volatile uint32_t *)(GPIOA_BASE + 0x14)) // GPIO ODR for GPIOA
GPIO_ODR = (1 << 5); // Set pin PA5 to high state
```

All the code that implements the above steps is in the Turn_on_LED folder and
the fast version is described in the Cheat_sheet folder.

#### 2.2.2. Reading a switch B1 and setting the high state on LD2 <a name="222"></a>
1. Check which pin the B1 button is connected to. According to datasheet for
STM32 Nucleo board: "the user button is connected to the I/O PC13 (pin 2) of the
STM32 microcontroller." <br/>
According to the electronic diagram for the board the onboard user push button
is connected to PC13 digital pin through a pull-up resistor. This means when the
push button is not pressed, we will get an active high signal at the PC13 pin.
Similarly, when it is pressed, we will get an active low signal on the PC13 pin:
![Image](https://github.com/user-attachments/assets/67add0a5-c10b-4cef-8cbf-2d44529a8cbc)

2. Enable clock for port A and port C. <br/>
LED LD2 is connected to port A, button B1 is connected to port C. <br/>
Register RCC_AHB1ENR can enable or disable clock for GPIOx. <br/>
For GPIOA is RCC address + RCC_AHB1ENR offset = 0x40023800 + 0x30 = 0x40023830.
<br/>
FOR GPIOC is RCC address + RCC_AHB1ENR offset = 0x40023800 + 0x30 = 0x40023830.
<br/>

3. Set PA5 (LD2) as output, PC13 (B1) as input. <br/>
The GPIOx_MODER register sets the direction for GPIOx. <br/>
Base address for GPIOA_MODER is 0x40020000. Offset for GPIOA is 0x00. <br/>
Base address for GPIOC_MODER is 0x40020800. Offset for GPIOC is 0x00. <br/>

4. Enable internal pull-down resistor for the pin PC13. <br/>
Setting the value in the PUPDR register sets the internal pull-up or pull-down
connection. <br/>
Address for PUPDR is: GPIOC base + offset = 0x40020800 + 0x0C = 0x4002080C <br/>

|![Image](https://github.com/user-attachments/assets/4ad6894a-8561-42eb-86ec-0e31d0836872)|
|:--:|
|*Depending on the physical connection of the button, should be set the pull-down resistor or pull-up resistor.*|

5. Read state on PC13 <br/>
This can be done reading value from IDR (Input Data Register) register. <br/>
Address for IDR is: GPIOC base + offset = 0x40020800 + 0x10. <br/>
If the high state is on PC13, set the high state to PA5. <br/>
```cpp
// Read the state of PC13
if ((GPIOC_IDR & 0b0010000000000000) == 0) // Check if PC13 is low (active low)
{
   GPIOA_ODR |= (1 << 5); // Set pin PA5 to high state
}
else
{
    GPIOA_ODR &= ~(1 << 5); // Set PA5 low
}
```

#### 2.2.3. Seven-segment LED interfacing <a name="223"></a>
This example uses two 7 segment displays. <br/>
Port B (PB0 and PB1) is connected to the cathodes that switch the displays. <br/>
Anodes are connected to port C (PC0 and PC7), which control the displayed digit.

At a low frequency of alternating digits, the display will appear to be
flickering. To eliminate the flickering display, each digit should be turned on
and off at least 60 times each second. For 16 MHz frequency delay shoud be 8
milicesonds.
1. Configure Port C as output port to drive the segments. <br/>
2. Configure Port B as output port to select the digits. <br/>
3. Write a numeric pattern to port C. <br/>
4. Turn on the select pin to HIGH to activate the tens digit. <br/>
This is done by BSRR register. The BSRR register is used to set the GPIO state
in one clock cycle. The BSRR register has two parts:
- Set bits: Writing a '1' to a specific bit in the lower half of the BSRR
register sets the corresponding GPIO pin to high (logic level 1).
- Reset bits: Writing a '1' to a specific bit in the upper half of the BSRR
register resets the corresponding GPIO pin to low (logic level 0).

|![Image](https://github.com/user-attachments/assets/8609c9d5-f048-4ae3-9562-16ffce517eca)|
|:--:|
|*Bits BS0-BS15 set the GPIO state for pins 0-15, and bits BR0-BR15 reset the GPIO pin state.*|

```cpp
#define GPIOB_BASE      0x40020400
#define GPIOB_BSRR     (*(volatile uint32_t *)(GPIOB_BASE + 0x18))
GPIOB_BSRR = 0x00010000; // Deselect ones digit, PB0
GPIOB_BSRR = 0x00000002; // Select tens digit, PB1
```
5. Delay for some time. <br/>
6. Write a numeric pattern to port C. <br/>
7. Turn on the select pin to HIGH to activate the ones digit. <br/>
8. Delay for some time. <br/>
9. Repeat steps 3-8. <br/>

## 3. LCD and Keyboard Interfacing <a name="3"></a>

### 3.1. Interfacing to an LCD <a name="31"></a>
The HD44780 controller has a 14 pin interface for the microprocessor: <br/>
1. GND
2. VCC +5V
3. VEE - Power supply to control contrast
4. RS (register select) -  There are two registers inside the LCD and the RS pin
is used for their selection. If RS = 0, the instruction command code register is
selected, allowing the user to send a command such as clear display, cursor at
home, etc. If RS = 1, the data register is selected, allowing the user to send
data to be displayed on the LCD.
5. R/W - R/W = 1 when reading and R/W = 0 when writing.
6. E - Enable. Latch information presented to its data pins. When data is
supplied to data pins, a pulse (Low-to-High-to-Low) must be applied to this pin
in order for the LCD to latch in the data present at the data pins. This pulse
must be a minimum of 230 ns wide.
7. DB0 - I/O The 8-bit data bus. The 8-bit data pins are used to send
information to the LCD or read the contents of the LCD's internal registers. The
LCD controller is capable of operating with 4-bit data and only D4-D7 are used.
To display letters and numbers, we send ASCII codes for the letters A–Z, a–z,
numbers 0–9.
8. DB1 - I/O The 8-bit data bus
9. DB2 - I/O The 8-bit data bus
10. DB3 - I/O The 8-bit data bus
11. DB4 - I/O The 4/8-bit data bus
12. DB5 - I/O The 4/8-bit data bus
13. DB6 - I/O The 4/8-bit data bus
14. DB7 - I/O The 4/8-bit data bus

Some commonly command codes:
| Byte | Instruction |
|:--:|:--:|
| 0x01 | Clear display |
| 0x02 | Return cursor home |
| 0x06 | Increment cursor (shift cursor to right) |
| 0x14 | Shift cursor right |
| 0x10 | Shift cursor left |
| 0x0F | Display on, cursor blinking |
| 0x0E | Display on, cursor on, steady cursor |
| 0x80 | Force cursor to beginning of 1st line |
| 0xC0 | Force cursor to beginning of 2nd line |

To send any of the commands to the LCD, make pins RS = 0, R/W = 0, and send a
pulse on the E pin to enable the internal latch of the LCD. Connection of an
LCD to the microcontroller:
![Image](https://github.com/user-attachments/assets/2b85ff7b-012f-4714-a069-1c5751ca63c0)

Connection to the MCU:
- The LCD's data pins are connected to PORTD,
- RS pin is connected to Pin 5 of PORTB,
- R/W pin is connected to Pin 6 of PORTB,
- E pin is connected to Pin 7 of PORTB.

Sending data to the LCD:
1. Set pins RS = 1, R/W = 0 and send a pulse (L-to-H-to-L) to the E pin to
enable the internal latch of the LCD.
2. Send data.
