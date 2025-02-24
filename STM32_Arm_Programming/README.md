Notes from book STM32 Arm Programming for Embedded Systems by Muhammad Ali Mazidi

____

### 1. C for Embedded Systems
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

### 2. STM Arm I/O Programming
