/* Using HD47780 with 4-bit mode and delay.
The LCD controller is connected as follows:
LCD D4-D7 --> PD0-PD3
LCD R/S   --> PB0
LCD R/W   --> GND
LCD EN    --> PB1
*/
#include <stdint.h>

// Base addresses for peripherals
#define RCC_BASE        0x40023800
#define GPIOA_BASE      0x40020000
#define GPIOB_BASE      0x40020400
#define GPIOD_BASE      0x40020C00
// RCC register
#define RCC_AHB1ENR    (*(volatile uint32_t *)(RCC_BASE + 0x30))
// GPIOA registers
#define GPIOA_MODER    (*(volatile uint32_t *)(GPIOA_BASE + 0x00))
#define GPIOA_ODR      (*(volatile uint32_t *)(GPIOA_BASE + 0x14))
// GPIOB registers
#define GPIOB_MODER    (*(volatile uint32_t *)(GPIOB_BASE + 0x00))
#define GPIOB_ODR      (*(volatile uint32_t *)(GPIOB_BASE + 0x14))
#define GPIOB_BSRR     (*(volatile uint32_t *)(GPIOB_BASE + 0x18))
// GPIOD registers
#define GPIOD_MODER    (*(volatile uint32_t *)(GPIOD_BASE + 0x00))
#define GPIOD_ODR      (*(volatile uint32_t *)(GPIOD_BASE + 0x14))
#define GPIOD_BSRR     (*(volatile uint32_t *)(GPIOB_BASE + 0x18))
// Define masks
#define RS 0x1 // PB0 mask for reg select
#define EN 0x2 // PB1 mask for enable


void delayMs(int n);
void PORTS_init(void);
void LCD_nibble_write(char data, unsigned char control);
void LCD_init(void);
void LCD_command(unsigned char command);
void LCD_data(char data);


int main(void)
{

    RCC_AHB1ENR |= (1 << 0); // Enable clock for GPIOA
    GPIOA_MODER |= (1 << 10); // Set bit 1 to set direction as an output, bit 10 is assigned to PA5

    
    while(1)
    {
            GPIOA_ODR = (1 << 5); // Set pin PA5 to high state
            delay_ms(1000); // 1 sec
            GPIOA_ODR = (0 << 5); // Set pin PA5 to low state
            delay_ms(1000); // 1 sec
    }
    

   /*
   LCD_init(); // Initialize LCD controller
   
   while(1)
   {
      // Write "hello" on LCD 
      LCD_data('h');
      LCD_data('e');
      LCD_data('l');
      LCD_data('l');
      LCD_data('o'); 
      delayMs(1000);
      LCD_command(1); // Clear LCD display 
      delayMs(1000);
   }
   */
}


// Initialize port pins then initialize LCD controller
void LCD_init(void)
{
    PORTS_init();
    delayMs(20);
    // LCD controller reset sequence
    LCD_nibble_write(0x30, 0);
    delayMs(5);
    LCD_nibble_write(0x30, 0);
    delayMs(1);
    LCD_nibble_write(0x30, 0);
    delayMs(1);
    LCD_nibble_write(0x20, 0); // use 4-bit data mode
    delayMs(1);
    LCD_command(0x28); // set 4-bit data, 2-line, 5x7 font
    LCD_command(0x06); // move cursor right
    LCD_command(0x01); // clear screen, move cursor to home
    LCD_command(0x0F); // turn on display, cursor blinking
}


void PORTS_init(void)
{
   RCC_AHB1ENR |= (1 << 1); // Enable GPIOB clock
   RCC_AHB1ENR |= (1 << 3); // Enable GPIOD clock
   // Command ports
   // LCD R/S --> PB0 
   // LCD EN  --> PB1
   GPIOB_MODER |= 0x5; // Set pin output mode, 0x5 = 0b0101
   GPIOB_BSRR  =  0x30000; // Turn off EN and R/W, 
   // 0x30000 = 0b11_00000000_00000000. Reset pins PB0, PB1 = 1
   // Data ports
   // LCD D4-D7 --> PD0-PD3
   GPIOD_MODER |= 0x00000055; // Set pin output mode
}


void LCD_nibble_write(char data, unsigned char control)
{
    GPIOD_BSRR = 0x000F0000;  // populate data bits
    GPIOD_BSRR = data & 0xF0; // clear data bits
    /* set data bits */
    /* set R/S bit */
    if (control & RS)
        GPIOB_BSRR = RS;
    else
        GPIOB_BSRR = RS << 16;
    GPIOB_BSRR = EN; // pulse E
    delayMs(0);
    GPIOB_BSRR = EN << 16;
}


void LCD_command(unsigned char command)
{
    LCD_nibble_write(command & 0xF0, 0); // upper nibble first
    LCD_nibble_write(command << 4, 0); // then lower nibble
    if (command < 4)
        delayMs(2); // command 1 and 2 needs up to 1.64ms
    else
        delayMs(1); // all others 40 us
}


void LCD_data(char data)
{
    LCD_nibble_write(data & 0xF0, RS); // upper nibble first
    LCD_nibble_write(data << 4, RS); // then lower nibble
    delayMs(1);
}


//  Delay n milliseconds (16 MHz CPU clock)
void delayMs(int n)
{
   int i;
   for (; n > 0; n--)
   for (i = 0; i < 3195; i++) ;
}

void delay_ms(int milliseconds) // 1000 = 1 sec
{
    // 180 MHz = 5.56 ns
    // 1 ms = 1_000_000 ns
    // 179856 clock cycles = 1 ms
    
    volatile int count;
    for (int i = 0; i < milliseconds; i++) 
        for (count = 0; count < 179856; count++)
        {
            // Empty loop
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
