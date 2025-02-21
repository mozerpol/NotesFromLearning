I used STM32 NUCLEO with STM32F446RET6 MCU.

____

## 1. To install:
1. gcc-arm-none-eabi <br/>
Bare metal C and C++ compiler for embedded ARM chips using ARM Cortex-A/R/M
processors.

2. gdb-multiarch <br/>
GNU Debugger (with support for multiple architectures).

3. binutils-arm-none-eabi <br/>
GNU assembler, linker and binary utilities for ARM Cortex-R/M processors.

4. openocd <br/>
OpenOCD (Open On-Chip Debugger) is a tool that allows to program and debug STM32
microcontroller.

5. stlink-tools <br/>
OpenSource ST-Link tools replacement. Flashing tools for STMicroelectronics
STM32VL and STM32L.

#### 1.1 Check if it works:
arm-none-eabi-gcc --version <br/>
arm-none-eabi-g++ --version <br/>
gdb-multiarch --version <br/>
openocd --version <br/>
st-info --version

Script how to install all packages and verify them is in repo
/dotfiles/system_setup/stm32
[here](https://github.com/mozerpol/dotfiles/tree/master/system_setup/STM32).

## 2. Directory tree
```
|___README.md (this file)
|___Makefile
|___linker_script.ld
|___Build/
|   |___Obj/
|   |___Bin/
|___Src/
|   |___C files
```

C files are in Src/ <br/>
Object files are in Build/Obj <br/>
Binary files and executable are in Build/Bin <br/>
Makefile is in main dir <br/>
Linker script (*.ld) is in main dir

## 3. Usage
`make` - Compile and link. <br/>
`make clean` - Remove files from Build/Obj and Build/Bin. <br/>
`make flash` - Load firmware to the mcu.

## 4. Makefile
1. Line: `SRCS      = $(wildcard $(SRC_DIR)/*.c)` <br/>
wildcard - returns a list of files matching a specified pattern. <br/>
$(wildcard *.c) - searches filesystem for matching filenames with c extension.
2. Line: `OBJS      = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))` <br/>
$(patsubst pattern,replacement,text) - performs pattern substitution.
$(text:pattern=replacement) is a shorthand for this. Pattern may contain a %
which acts as a wildcard, matching any number of any characters within a word.
If replacement also contains a %, the % is replaced by the text that matched the
% in pattern. It takes three arguments:
- a pattern to match (the first argument),
- a replacement pattern (the second argument),
- a list of words (the third argument) to apply the substitution to.
3. Line: `TARGET_BIN = $(BIN_DIR)/$(TARGET:.elf=.bin)` <br/>
`(TARGET:.elf=.bin)` is a form of pattern substitution, it's a shorthand for
above. It takes the value of the $(TARGET) variable and replaces the .elf
extension with .bin.
4. Line: `.PHONY: clean` <br/>
The primary purpose of .PHONY is to prevent conflicts between target names and
actual files. It ensures that the commands associated with those targets are
always executed when invoked, preventing potential issues with file name
conflicts.
5. Line: `all: $(TARGET_ELF) $(TARGET_BIN)` <br/>
When this line is executed, it establishes that the all target depends on both
$(TARGET_ELF) and $(TARGET_BIN). This means that when you run `make all` (or
just `make`), make will:
- Check if $(TARGET_ELF) is up to date. If it is not, it will execute the
commands associated with the $(TARGET_ELF) target to build it.
- Check if $(TARGET_BIN) is up to date. If it is not, it will execute the
commands associated with the $(TARGET_BIN) target to build it.
6. Line: `$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c` <br/>
It is a pattern rule that defines how to build object files (.o files) from
source files (.c files).
7. Line: `@$(CC) $(CFLAGS) -c $< -o $@` <br/>
- $<: - this is an automatic special variable that represents the first
prerequisite (targets: prerequisites) of the rule. It is replaced with the name
of the source file being compiled,
- $@ - this is an automatic special variable that represents the target of the
rule. It is replaced with the name of the object file being created.

#### 4.1. Compiling
Command: `arm-none-eabi-gcc -g -O0 -Wall -Wextra -Warray-bounds -Wno-unused-parameter -mcpu=cortex-m4 -mthumb -c Src/C_files.c -o Build/Obj/object_files.o`

| Flag | Description |
|:--:|:--|
| -mcpu=cortex-m4 | Code written for ARM Cortex-M4 microcontroller architecture. |
| -mthumb | Compiler should generate code for the Thumb instruction set. Thumb instructions are each 16 bits long and have a corresponding 32-bit ARM instruction that has the same on the processor model. which is a more compact 16-bit instruction set used in ARM, particularly beneficial for embedded systems where memory is limited. |
| -Wall | Enable all compiler's warning messages. |
| -O0 | - Set the optimization level to 0. |
| -g | Info for debugging. |
| -Wextra | Enables additional warning messages that are not included by default with -Wall.  |
| -Warray-bounds | Enables warnings about array bounds violations. It warns when the compiler detects that an array is being accessed out of its defined bounds.  |
| -Wno-unused-parameter | Disables warnings about unused function parameters. By default, the compiler may issue warnings if a function parameter is declared but not used  |

#### 4.2. Linking
Command: `arm-none-eabi-gcc -o Build/Bin/executable_file.elf Build/Obj/obejct_files.o -Wl,--gc-sections -T likner_script.ld`

| Flag | Description |
|:--:|:--|
| -Wl, | This flag is used to separate the compiler options from the linker options. Everything that follows this prefix is treated as a command for the linker. |
| --gc-sections | It instructs the linker to perform "garbage collection" of unused sections. When this option is enabled, the linker will remove any sections of code or data that are not referenced or used in the final executable. This is particularly useful in embedded systems where memory is limited. |
| -T | Indicate a linker script. |

#### 4.3. Flashing firmware
Command: `openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "program $(TARGET_ELF) verify reset exit`

| Flag | Description |
| :--: | :-- |
| -f | Specifies a configuration file for OpenOCD. |
| interface/stlink.cfg | Configuration file for the ST-Link interface. |
| target/stm32f4x.cfg | Configuration file for the STM32F4 MCU. |
| -c | Allows you to pass a command to OpenOCD. |
| program $(TARGET_ELF) | Instructs OpenOCD to program the target MCU with the specified ELF file. |
| verify | Verify that the code was correctly written to the target device by comparing the programmed data with the ELF file. |
| reset | Reset the target MCU after programming. This is done to start executing the newly programmed code immediately. |
| exit | Close OpenOCD. |


