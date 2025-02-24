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



![Image](https://github.com/user-attachments/assets/fcb875bd-246e-471e-9027-5c3248b684ee)
