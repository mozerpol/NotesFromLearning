// Blinking LED on LD2, 1 sec

#include <stdint.h>
#include "file1.h"

#define RCC_BASE        (0x40023800UL) // RCC base address
#define GPIOA_BASE      (0x40020000UL) // GPIOA base address
#define GPIO_MODER      (*(volatile uint32_t *)(GPIOA_BASE + 0x00)) // GPIO mode register
#define GPIO_ODR        (*(volatile uint32_t *)(GPIOA_BASE + 0x14)) // GPIO output data register
#define RCC_AHB1ENR    (*(volatile uint32_t *)(RCC_BASE + 0x30)) // AHB1 peripheral clock enable register

#define LD2_PIN        (5) // LD2 is connected to PA5

void delay(volatile uint32_t count) {
    while (count--) {
        __asm("nop"); // No operation (do nothing)
    }
}

int main() {
    // Enable clock for GPIOA
    RCC_AHB1ENR |= (1 << 0); // Set bit 0 to enable GPIOA clock

    // Set PA5 (LD2) as output
    GPIO_MODER &= ~(0x3 << (LD2_PIN * 2)); // Clear mode bits for PA5
    GPIO_MODER |= (0x1 << (LD2_PIN * 2));  // Set PA5 to output mode (01)

    while (1) {
        // 
        adding(1, 2);
        
        // Toggle LD2
        GPIO_ODR ^= (1 << LD2_PIN); // Toggle PA5

        // Delay
        delay(1000000); // Adjust the delay as needed
    }
    
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

