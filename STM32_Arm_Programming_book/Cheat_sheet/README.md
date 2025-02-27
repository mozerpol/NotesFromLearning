### 1. Glossary
- GPIO - General Purpose Input/Output
- AHB1ENR - Advanced High-performance Bus 1 Enable Register
- RCC - Reset and Clock Control
- MODER - Mode Register
- ODR - Output Data Register

### 2. How to set the high state on PA5
1. Enable clock for port A.
- RCC_AHB1ENR - enable clock for GPIOA, base address: 0x40023800
- Offset addres for GPIOA: 0x30
2. Set PA5 as output.
- GPIOA_MODER sets the direction, base address: 0x40020000
- Offset for GPIOA: 0x00
3. Set pin PA5 to a high state.
- ODRA - controls mode on GPIOA, address: GPIOA_BASE + offset = 0x40020000 + 0x14
- Assign logic 1 to PA5: `GPIO_ODR = (1 << 5);`
