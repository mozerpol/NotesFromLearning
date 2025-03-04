#include <stdint.h>

// Base addresses for peripherals
#define RCC_BASE        0x40023800
#define GPIOB_BASE      0x40020400
#define GPIOC_BASE      0x40020800
// RCC register
#define RCC_AHB1ENR    (*(volatile uint32_t *)(RCC_BASE + 0x30))
// GPIOB registers
#define GPIOB_MODER    (*(volatile uint32_t *)(GPIOB_BASE + 0x00)) // output
#define GPIOB_BSRR     (*(volatile uint32_t *)(GPIOB_BASE + 0x18))
// GPIOC registers
#define GPIOC_MODER    (*(volatile uint32_t *)(GPIOC_BASE + 0x00)) // output
#define GPIOC_ODR      (*(volatile uint32_t *)(GPIOC_BASE + 0x14))


void delayMs(int n);


int main(void)
{
   // Enable the clock for GPIOA and GPIOC
   RCC_AHB1ENR |= (1 << 1); // Enable GPIOB clock
   RCC_AHB1ENR |= (1 << 2); // Enable GPIOC clock
   // Configure PB0 and PB1 as a output
   GPIOB_MODER |= 0x5; // 0101
   // Configure PC0-PC7 as a output
   GPIOC_MODER |= 0x5555; // 0101010101010101

   for(;;)
   {
      GPIOC_ODR = 0x0007; // Display tens digit
      GPIOB_BSRR = 0x00010000; // Deselect ones digit, PB0
      GPIOB_BSRR = 0x00000002; // Select tens digit, PB1
      delayMs(8);
      GPIOC_ODR = 0x006D; // Display ones digit
      GPIOB_BSRR = 0x00020000; // Deselect tens digit, PB0
      GPIOB_BSRR = 0x00000001; // Select ones digit, PB1
      delayMs(8);
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
