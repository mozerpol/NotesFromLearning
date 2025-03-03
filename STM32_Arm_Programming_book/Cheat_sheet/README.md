### 1. Glossary
- GPIO - General Purpose Input/Output
- AHB1ENR - Advanced High-performance Bus 1 Enable Register
- RCC - Reset and Clock Control
- MODER - Mode Register
- ODR - Output Data Register
- PUPDR - Pull-up/Pull-down Register 
- IDR - Input Data Register

### 2. How to set the high state on PA5
1. Enable clock for port A.
- RCC_AHB1ENR - enable clock for GPIOA, RCC base address + RCC_AHB1ENR offset =
0x40023800 + 0x30. <br/>
`RCC_AHB1ENR |= (1 << 0); // Enable GPIOA clock`
2. Set PA5 as output.
- GPIOA_MODER sets the direction for GPIOA, base address: 0x40020000
- Offset for GPIOA: 0x00
3. Set pin PA5 to a high state.
- ODRA - controls mode on GPIOA, address: GPIOA_BASE + offset = 0x40020000 + 0x14
- Assign logic 1 to PA5: <br/>
`GPIO_ODR = (1 << 5);`

### 3. How to use button
1. Enable clock for port C.
- RCC_AHB1ENR - enable clock for GPIOC, RCC base address + RCC_AHB1ENR offset =
0x40023800 + 0x30. <br/>
`RCC_AHB1ENR |= (1 << 2); // Enable GPIOC clock`
2. Set PC13 as input. <br/>
- GPIOC_MODER sets the direction for GPIOC, base address: 0x40020800
- Offset for GPIOC: 0x00
3. Connect internally pull-down resistor to PC13.
- GPIOC_PUPDR connects the pull-down for GPIOC, base address: 0x40020800
- Offset for GPIOC: 0x0C
4. Check if PC13 is low (active low).
- GPIOC IDR, base address: 0x40020800
- Offset: 0x10 <br/>
`if ((GPIOC_IDR & 0b0010000000000000) == 0) // Check if PC13 is low (active low)`
