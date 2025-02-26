/* Linker script for STM32F446RET6 */

MEMORY
{
  FLASH (rx)      : ORIGIN = 0x08000000, LENGTH = 512K
  RAM (xrw)       : ORIGIN = 0x20000000, LENGTH = 128K
}

/* Define the entry point */
ENTRY(Reset_Handler)

SECTIONS
{
  /* The startup code goes here */
  .text :
  {
    KEEP(*(.isr_vector))  /* Interrupt vector table */
    *(.text*)              /* All .text sections from all files */
    *(.rodata*)           /* Read-only data */
    . = ALIGN(4);
  } > FLASH

  /* Initialized data section */
  .data : AT (ADDR(.text) + SIZEOF(.text))
  {
    . = ALIGN(4);
    *(.data*)
    . = ALIGN(4);
  } > RAM

  /* Uninitialized data section */
  .bss :
  {
    . = ALIGN(4);
    *(.bss*)
    . = ALIGN(4);
  } > RAM

  /* Stack and heap */
  ._stack (NOLOAD) :
  {
    . = ALIGN(4);
    _stack_top = .;  /* Top of stack */
    . = . + 0x400;   /* 1 KB stack size */
    _stack_bottom = .; /* Bottom of stack */
  } > RAM

  /* End of the sections */
  . = ALIGN(4);
  _end = .;  /* End of the program */
}
