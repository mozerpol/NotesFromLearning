### 1. Glossary
- AHB1ENR - Advanced High-performance Bus 1 Enable Register
- BSRR - Bit Set/Reset Register
- GPIO - General Purpose Input/Output
- IDR - Input Data Register
- MODER - Mode Register
- ODR - Output Data Register
- PUPDR - Pull-up/Pull-down Register
- RCC - Reset and Clock Control

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
- GPIOC IDR, base address: 0x40020800. IDR - IDR is used to read the current
state of the GPIO.
- Offset: 0x10 <br/>
`if ((GPIOC_IDR & 0b0010000000000000) == 0) // Check if PC13 is low (active low)`

### 4. 7-segment display
1. Enable clock for port B
- RCC base + offset: 0x40023800 + 0x30 = 0x40023830
- `RCC_AHB1ENR |= (1 << 1); // Enable GPIOB clock`
2. Enable clock for port C
- `RCC_AHB1ENR |= (1 << 2); // Enable GPIOC clock`
3. Configure Port B as output port to select the digits.
- GPIOB base + offset: 0x40020400 + 0x00
- `GPIOB_MODER |= 0x5; // PB0, PB1 as output`
4. Configure Port C as output port to drive the segments.
- GPIOC base + offset: 0x40020800 + 0x00
- `GPIOC_MODER |= 0x5555;`
5. Turn on the select pin to HIGH to activate the tens digit and deactivate the
ones.
- BSRR: GPIOB base + offset: 0x40020400 + 0x18 = 0x40020418. BSRR - it allows to
manipulate of individual GPIO pins without the need to read the current state of
the GPIO port.
- `GPIOB_BSRR = 0x00010000; // Deselect ones digit, PB0` <br/>
`GPIOB_BSRR = 0x00000002; // Select tens digit, PB1`
6. Write a numeric pattern to port C.
- ODR: GPIOB address + offset: 0x40020400 + 0x14 = 0x40020414
- `GPIOC_ODR = 0x0007; // Display tens digit`
