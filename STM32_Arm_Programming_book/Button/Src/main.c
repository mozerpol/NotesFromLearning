#include <stdint.h>

// Base addresses for peripherals
#define RCC_BASE        0x40023800
#define GPIOA_BASE      0x40020000
#define GPIOC_BASE      0x40020800
// RCC register
#define RCC_AHB1ENR    (*(volatile uint32_t *)(RCC_BASE + 0x30))
// GPIOA registers
#define GPIOA_MODER    (*(volatile uint32_t *)(GPIOA_BASE + 0x00)) // output
#define GPIOA_ODR      (*(volatile uint32_t *)(GPIOA_BASE + 0x14))
// GPIOC registers
#define GPIOC_MODER    (*(volatile uint32_t *)(GPIOC_BASE + 0x00)) // input
#define GPIOC_PUPDR    (*(volatile uint32_t *)(GPIOC_BASE + 0x0C))
#define GPIOC_IDR      (*(volatile uint32_t *)(GPIOC_BASE + 0x10))


int main(void) {
   // Enable the clock for GPIOA and GPIOC
   RCC_AHB1ENR |= (1 << 0); // Enable GPIOA clock
   RCC_AHB1ENR |= (1 << 2); // Enable GPIOC clock

   // Configure PA5 as output
   GPIOA_MODER |= (0 << 11)|(1 << 10); // Set direction as an output, bit 10 is assigned to PA5

   // Configure PC13 as input with pull-down resistor
   GPIOC_MODER |= (0 << 27)|(0 << 26); // Set direction as an input
   GPIOC_PUPDR |= (1 << 27)|(0 << 26); // Set pull-down for PC13

   while (1)
   {
      // Read the state of PC13
      if ((GPIOC_IDR & 0b0010000000000000) == 0) // Check if PC13 is low (active low)
      {
         GPIOA_ODR |= (1 << 5); // Set pin PA5 to high state
      }
      else
      {
         GPIOA_ODR &= ~(1 << 5); // Set PA5 low
      }
   }
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
