/* Using HD47780 with 8-bit mode and delay.
The LCD controller is connected as follows:
PC0-PC7 for LCD D0-D7, respectively.
PB5 for LCD R/S
PB6 for LCD R/W
PB7 for LCD EN
*/
#include <stdint.h>

// Base addresses for peripherals
#define RCC_BASE        0x40023800
#define GPIOB_BASE      0x40020400
#define GPIOD_BASE      0x40020C00
// RCC register
#define RCC_AHB1ENR    (*(volatile uint32_t *)(RCC_BASE + 0x30))
// GPIOB registers
#define GPIOB_MODER    (*(volatile uint32_t *)(GPIOB_BASE + 0x00)) // output
#define GPIOB_ODR      (*(volatile uint32_t *)(GPIOB_BASE + 0x14))
#define GPIOB_BSRR     (*(volatile uint32_t *)(GPIOB_BASE + 0x18))
// GPIOD registers
#define GPIOD_MODER    (*(volatile uint32_t *)(GPIOD_BASE + 0x00)) // output
#define GPIOD_ODR      (*(volatile uint32_t *)(GPIOD_BASE + 0x14))
// Define masks
#define RS 0x20 // PB5 mask for reg select, 0x20 = 0b00100000
#define RW 0x40 // PB6 mask for read/write, 0x40 = 0b01000000
#define EN 0x80 // PB7 mask for enable, 0x80 = 0b10000000


void delayMs(int n);
void LCD_command(unsigned char command);
void LCD_data(char data);
void LCD_init(void);
void PORTS_init(void);


int main(void)
{
   LCD_init(); // Initialize LCD controller
   delayMs(1000);
   
   while(1)
   {
      // Write "hello" on LCD 
      LCD_data('h');
      LCD_data('e');
      LCD_data('l');
      LCD_data('l');
      LCD_data('o'); 
      LCD_command(1); // Clear LCD display 
      delayMs(500);
   }
}


// Initialize port pins then initialize LCD controller
void LCD_init(void)
{
   PORTS_init();
   delayMs(30); // Initialization sequence 
   LCD_command(0x30);
   delayMs(10);
   LCD_command(0x30);
   delayMs(1);
   LCD_command(0x30);
   LCD_command(0x38); // Set 8-bit data, 2-line, 5x7 font
   LCD_command(0x06); // Move cursor right after each char
   LCD_command(0x01); // Clear screen, move cursor to home
   LCD_command(0x0F); // Turn on display, cursor blinking
}


void PORTS_init(void)
{
   RCC_AHB1ENR |= (1 << 1); // Enable GPIOB clock
   RCC_AHB1ENR |= (1 << 3); // Enable GPIOD clock
   // Command ports
   //  PB5 for LCD R/S
   //  PB6 for LCD R/W
   //  PB7 for LCD EN
   GPIOB_MODER &= ~0x0000FC00; // Clear pin mode, 0xFC00 = 0b1111110000000000
   GPIOB_MODER |=  0x00005400; // Set pin output mode, 0x5400 = 0b0101010000000000
   GPIOB_BSRR  =   0x00C00000; // Turn off EN and R/W, 
   // 0x00C00000 = 0b00000000110000000000000000000000. Pin PB6, PB7 = 1, it 
   // means reset PB6 and PB7
   // Data ports
   //  PD0-PD7 for LCD D0-D7, respectively.
   GPIOD_MODER &= ~0x0000FFFF; // Clear pin mode 
   GPIOD_MODER |= 0x00005555; // Set pin output mode
}


void LCD_command(unsigned char command)
{
   GPIOB_BSRR = (RS | RW) << 16; //  RS = 0, R/W = 0 
   GPIOD_ODR = command; // Put command on data bus
   GPIOB_BSRR = EN; // Pulse E high 
   delayMs(0);
   GPIOB_BSRR = EN << 16; // Clear E
   
   if (command < 4)
   {
      delayMs(2); // Command 1 and 2 needs up to 1.64ms
   }
   else
   {
      delayMs(1); // All others 40 us
   }
}


void LCD_data(char data)
{
   GPIOD_ODR = data; // Put data on data bus 
   GPIOB_BSRR = EN; // Pulse E high 
   delayMs(0);
   GPIOB_BSRR = EN << 16; // Clear E
   GPIOB_BSRR = RS; // RS = 1 
   GPIOB_BSRR = RW << 16; // R/W = 0
   delayMs(1); 
}


//  Delay n milliseconds (16 MHz CPU clock)
void delayMs(int n)
{
   int i;
   for (; n > 0; n--)
   for (i = 0; i < 3195; i++) ;
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
