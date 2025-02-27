// Set pin PA5 (LD2) to high state

#include <stdint.h>

#define RCC_BASE    (0x40023800UL) // RCC base address
#define RCC_AHB1ENR (*(volatile uint32_t *)(RCC_BASE + 0x30)) // RCC base address + GPIOA offset
#define GPIOA_BASE  (0x40020000UL) // GPIOA base address
#define GPIO_MODER  (*(volatile uint32_t *)(GPIOA_BASE + 0x00)) // Offset for GPIOA
#define GPIO_ODR    (*(volatile uint32_t *)(GPIOA_BASE + 0x14)) // GPIO ODR for GPIOA


int main()
{
   RCC_AHB1ENR |= (1 << 0); // Enable clock for GPIOA
   GPIO_MODER  |= (1 << 10); // Set bit 1 to set direction as an output, bit 10 is assigned to PA5
   GPIO_ODR     = (1 << 5); // Set pin PA5 to high state
   
   return 0;
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
