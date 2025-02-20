# Path to toolchain installation, leave empty if already in system PATH
TOOLCHAIN_ROOT =

# Project specific
TARGET = main.elf

# Directories
SRC_DIR = Src
OBJ_DIR = Build/Obj
BIN_DIR = Build/Bin

# Toolchain
CC      = $(TOOLCHAIN_ROOT)arm-none-eabi-gcc
OBJCOPY = $(TOOLCHAIN_ROOT)arm-none-eabi-objcopy
DB      = $(TOOLCHAIN_ROOT)arm-none-eabi-gdb

# Source files
SRCS      = $(wildcard $(SRC_DIR)/*.c)
OBJS      = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))
LD_SCRIPT = linker_script.ld

# Target executable names
TARGET_ELF = $(BIN_DIR)/$(TARGET)
TARGET_BIN = $(BIN_DIR)/$(TARGET:.elf=.bin)

# Compiler Flags
CFLAGS = -g -O0 -Wall -Wextra -Warray-bounds -Wno-unused-parameter
CFLAGS += -mcpu=cortex-m4 -mthumb

# Linker flags
LDFLAGS =  -Wl,--gc-sections -T $(LD_SCRIPT)

.PHONY: clean

# Default target
all: $(TARGET_ELF) $(TARGET_BIN)
	
# Compile each source file into an object file
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "1. Create object files: " $< $@
	@$(CC) $(CFLAGS) -c $< -o $@
	
# Link the object files to create the ELF executable
$(TARGET_ELF): $(OBJS)
	@echo "\n2. Create elf file: " $@
	@$(CC) -o $@ $^ $(LDFLAGS)

# Create a binary file from the ELF executable
$(TARGET_BIN): $(TARGET_ELF)
	@echo "\n3. Create bin file: " $@
	@arm-none-eabi-objcopy -O binary $< $@

# Use OpenOCD tool
flash:
	@echo "\nFlash firmware: $(TARGET_ELF), verify, reset and exit.\n"
	@openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c \
	"program $(TARGET_ELF) verify reset exit"

# Clean up the build
clean:
	rm -rf $(OBJ_DIR)/*.o $(BIN_DIR)/*
