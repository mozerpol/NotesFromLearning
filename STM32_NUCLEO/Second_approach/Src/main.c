// Blinking LED on LD2, 1 sec

#include "stm32f446xx.h"

void delayMs(int n);

int main(void) 
{
    RCC->AHB1ENR |= 1; /* enable GPIOA clock */
    GPIOA->MODER &= ~0x00000C00; /* clear pin mode */ 
    GPIOA->MODER |= 0x00000400; /* set pin to output mode */
    
    while(1) 
    {
        GPIOA->ODR |= 0x00000020; /* turn on LED */ 
        delayMs(500);
        GPIOA->ODR &= ~0x00000020; /* turn off LED */ 
        delayMs(500);
    }
}

/* 16 MHz SYSCLK */
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
