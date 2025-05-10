/*
 * When running this example, common-cathode 5611AH displays were used, so PORTB 
 * (the one that turns the displays on/off) must be set low state.
*/

#include <stdint.h>

// Base addresses for peripherals
#define RCC_BASE        0x40023800
#define GPIOB_BASE      0x40020400
#define GPIOC_BASE      0x40020800
// RCC register
#define RCC_AHB1ENR    (*(volatile uint32_t *)(RCC_BASE + 0x30))
// GPIOB registers
#define GPIOB_MODER    (*(volatile uint32_t *)(GPIOB_BASE + 0x00))
#define GPIOB_PUPDR    (*(volatile uint32_t *)(GPIOB_BASE + 0x0C))
#define GPIOB_BSRR     (*(volatile uint32_t *)(GPIOB_BASE + 0x18))
// GPIOC registers
#define GPIOC_MODER    (*(volatile uint32_t *)(GPIOC_BASE + 0x00))
#define GPIOC_ODR      (*(volatile uint32_t *)(GPIOC_BASE + 0x14))


void delayMs(int n);


int main(void)
{
   // Enable the clock for GPIOB and GPIOC
   RCC_AHB1ENR |= (1 << 1); // Enable GPIOB clock
   RCC_AHB1ENR |= (1 << 2); // Enable GPIOC clock
   // Configure PB0 and PB1 as a output
   GPIOB_MODER |= 0x5; // 0b0101
   // Connect PB0 and PB1 to pull-down resistor
   GPIOB_PUPDR |= 0xA; // 0b1010
   // Configure PC0-PC7 as a output
   GPIOC_MODER |= 0x5555; // 0101010101010101

   for(;;)
   {
      // Set high state on PC0, PC1 and PC2
      GPIOC_ODR = 0x0007; // 0b111
      GPIOB_BSRR = 0x00010000; // Set low state on PB0
      GPIOB_BSRR = 0x00000002; // Set high state on PB1
      delayMs(5);
      // Set high state on PC0, PC2, PC3, PC5 and PC6 
      GPIOC_ODR = 0x006D; // 0b1101101
      GPIOB_BSRR = 0x00020000; // Set low state on PB1
      GPIOB_BSRR = 0x00000001; // Set high state on PB0
      delayMs(5);
   }
}


// 16 MHz SYSCLK
void delayMs(int n)
{
   int i;
   for (; n > 0; n--)
   for (i = 0; i < 3195; i++);
}


// Define the entry point
void Reset_Handler(void) {
    main();
}


// Weak definition for the default handler
void Default_Handler(void) {
    while (1);
}


// Vector table
__attribute__((section(".isr_vector")))
void (*const vector_table[])(void) = {
    (void (*)(void))0x20020000, // Initial stack pointer
    Reset_Handler,              // Reset handler
    Default_Handler,            // NMI handler
    Default_Handler,            // Hard fault handler
    Default_Handler,            // MPU fault handler
    Default_Handler,            // Bus fault handler
    Default_Handler,            // Usage fault handler
    0, 0, 0, 0,                // Reserved
    Default_Handler,            // SVCall handler
    Default_Handler,            // Debug monitor handler
    0,                          // Reserved
    Default_Handler,            // PendSV handler
    Default_Handler             // SysTick handler
};
