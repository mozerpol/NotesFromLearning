# Nios V getting started
_____________

## Table of contents <a name="tof"></a>
1. [Software used](#1)
2. [Possible problems](#2)
3. [Hello world](#3)
   1. [Quartus part](#31)
   2. [niosv-shell part](#32)
   3. [Ashling RiscFree part](#32)
   4. [Using OpenOCD](#34)
   5. [Uploading the code and debugging](#35)
4. [GPIO (output version)](#4)
5. [GPIO (input version)](#5)
6. [Timer and interrupts](#6)
7. [Custom peripheral](#7)


## 1. Software used <a name="1"></a>
- Debian GNU/Linux 12 (bookworm) x86_64
- Tested on: Cyclone IV / MAX 10
- Quartus: Prime 23.1 standard
- Ashling RiscFree: v23.4.1, 3rd Nov 2023
- Debuger: OpenOCD

Location of the necessary tools (I am providing them because I assume they are
not in $PATH):
- OpenOCD: ~/Quartus/qprogrammer/linux64/openocd
- Ashling RiscFree: ~/Quartus/riscfree/RiscFree/RiscFree
- juart-terminal: ~/Quartus/qprogrammer/linux64/juart-terminal
- niosv-bsp: ~/Quartus/niosv/bin/niosv-bsp
- niosv-app: ~/Quartus/niosv/bin/niosv-app
- niosv-shell: ~/Quartus/niosv/bin/niosv-shell

## 2. Possible problems <a name="2"></a>
1. To get the latest version of code executed by Nios V, you need to load the
sof file into the FPGA, then compile the Nios V project in RiscFree and upload
it to Nios V.
2. After loading a fresh sof into the FPGA, debugging only works on the first
run. In the next runs, Ashling RiscFree returns the error:
```
Operation failed:
Command aborted.", and GDB: "Warning: Cannot insert breakpoint 1. Cannot access
memory at address 0x2cc".
```
This is probably because GDB has detected `Memory access -> System bus (Data
width : 128 Address size : 25)` as the way to access memory. This does not
happen on the first run, and additionally width + address are incorrect and
their values ​​change between runs. The same happens when trying to run from the
CLI.

The solution to these problems is to use OpenOCD.

## 3. Hello world <a name="3"></a>
### 3.1. Quartus part <a name="31"></a>
Create a new Nios V project in Quartus:
1. *File* → *New Project Wizard* → ... <br/>
Remember the project name, because you will need to enter it later in Platform
Designer.
2. Open Platform Designer and create a simple Nios V project:

![Image](https://github.com/user-attachments/assets/5d2f6500-0db5-4d09-9f0b-1e9cd425bb21)

Nios V Settings (all options in Vectors *Reset Agent* are avalible after
assignign base addreses. It's done later):

![Image](https://github.com/user-attachments/assets/b742fbda-9891-47c5-b5d6-568c6063799e)

Memory settings (memory size must be greater than XXX, I don't remember how
much, large enough):

![Image](https://github.com/user-attachments/assets/29164ed4-f43b-4407-8ad6-d34eff0a6285)

Jtag settings: no changes

3. Assign addresses: *System* → *Assign Base Addresses*. Now set Nios V settings
(change vectors section - *Reset Agent* part).
4. Save the Platform Designer project with the same name as the saved Quartus
project.
5. Click *Generate HDL* (bottom right corner), it will generate with warnings,
but that's OK.
6. Click *Finish*.
7. Add the Platform Designer generated file: *name*.qip (should be in
*name_from_platform_designer/synthesis/name.qpip*). Go to *Files* tab, right
click *Add/Remove Files* in *Project*:

![Image](https://github.com/user-attachments/assets/a2a9b455-a930-4a5c-b3ce-cbbbeaa69a2d)

8. Start synthesis and assign clk to the appropriate pin in Pin Planner.
9. Compile everything.
10. Upload sof to FPGA.

### 3.2. niosv-shell part <a name="32"></a>
1. Open the terminal and go to the project directory (where the file with the
*sopcinfo* extension is, i.e. where the Quartus project is). Run Nios command
shell:
- `~/Quartus/niosv/bin/niosv-shell`
2. Generate a bsp configuration file for the project. The location where the
file will be created is important, for me is: *quartus_project/software/bsp/*:
- `~/Quartus/niosv/bin/niosv-bsp -c -t=hal --sopcinfo=niosv.sopcinfo ./software/bsp/settings.bsp`
After executing this command, everything should look something like this:

![Image](https://github.com/user-attachments/assets/11a6b8d0-5e01-4705-be68-d45d78069c7a)

3. Go to the *./software/* directory (where the bsp catalog was automatically
created in the previous step) and create an *app* catalog, and inside it an
empty file *hello.c*. It should look something like this:

![Image](https://github.com/user-attachments/assets/5aaa93df-2e6b-43c4-a7c3-9af28112030c)

4. Generate a configuration file for Cmake (in the terminal where nios-shell
is):
- `~/Quartus/niosv/bin/niosv-app -a=./software/app -b=./software/bsp -s=./software/app/hello.c` <br/>
Every time something is changed in Platform Designer, you have to repeat steps 8
and 9.

### 3.3. Ashling RiscFree part <a name="33"></a>
1. Start Ashling RiscFree, in a new instance of the terminal (it can be a new
tab, nios-shell is in a separate one):
- `~/Quartus/riscfree/RiscFree/RiscFree` <br/>
2. After the program opens, click *Create a project*.
3. Expand *C/C++* and select the *C Project* option. *Next*.
4. Project name: app, location for the project is catalog: *./software/app/*. <br/>
Project type: expand Cmake driven and select option: Empty Project. <br/> It
should look something like this:

![Image](https://github.com/user-attachments/assets/1c63b750-052e-4e88-bdcd-a0d68cf9506b)

Click *Next* and select all options:

![Image](https://github.com/user-attachments/assets/cd2efd72-9aa7-4f09-a37b-642439c3eace)

5. *Finish*.
6. Open the previously created *hello.c* file (expand the *app* catalog and open
*hello.c*), add sample code:
```cpp
#include <stdio.h>
int main()
{
   printf("Hello\n");
   return 0;
}
```
7. Save.
8. Run juart-terminal (in the terminal where nios-shell is). The result of
running a simple *hello.c* program will later appear in it. It is important that
the FPGA is connected. Run:
- `~/Quartus/qprogrammer/linux64/juart-terminal`
9. In RiscFree right click on the project: *app* → *Build Project*. <br/>
During the first building, a window will open with settings. Go to the second
tab *Debugger* and set the *Target Configuration* by clicking the *Auto-detect
Scan Chain* option:

![Image](https://github.com/user-attachments/assets/f221d30a-515a-4103-9cbe-e9dd9cf52221)

10. Click *Apply* then *Run*.
11. The sample code should be executed by Nios-V and its output in the terminal:

![Image](https://github.com/user-attachments/assets/32cb47d7-3c62-4c43-83d4-a1d5e81d3ec2)

### 3.4. Using OpenOCD <a name="34"></a>
1. Generate a configuration file from the terminal (where nios-shell is
running). If juart-terminal is running, close it (ctrl+c). Configuration file
should be placed in the */software/app/* catalog (where the *hello.c* file is).
Run:
- `~/Quartus/qprogrammer/linux64/openocd-cfg-gen debugger.cfg`
2. In RiscFree, configure how the code will be upload to Nios V:
- Right click on the project: *Run As* → *Run Configuartions...*
3. Double click on *GDB OpenOCD Debugging*, a new configuration will open,
complete the first three tabs (*Main*, *Debugger* and *Startup*) similarly to
the following:

- *Main* tab, enter the path to OpenOCD:

![Image](https://github.com/user-attachments/assets/36ebc99a-b828-4a1c-8cbd-7b8eed2cc674)

4. *Debbuger* tab, add the generated cfg configuration file with the *-f* flag
and add commands for GDB: *set arch riscv:rv32* and *set can-use-hw-watchpoints:

![Image](https://github.com/user-attachments/assets/e890f11d-4815-4b67-9ad1-5bb07593bf28)

5. *Startup* tab, uncheck *Enable Arm semihosting* option:

![Image](https://github.com/user-attachments/assets/88fa213a-8e8a-4a6e-bb28-fadb4e90736d)

6. Click *Apply*, then *Run*.
7. Do the same with the debugger. Right click on the project: *Debug As* →
*Debug Configuartions...*

### 3.5. Uploading the code and debugging <a name="35"></a>
1. Uploading the code without using OpenOCD (default settings): right click on
the project → *Run As...* → Click on *3 Ashling RISC-V Hardware Debugging*
option:

![Image](https://github.com/user-attachments/assets/f1d8da18-7222-40fc-ac8c-0c3265fa08b5)

2. Uploading the code with OpenOCD: right click on the project → *Run As...* →
Click on *Run Configurations...* → Select option *GDB OpenOCD Debugging* and
OpenOCD configuraion, which was made in previous steps → Click *Run*:

![Image](https://github.com/user-attachments/assets/e52caae3-8cfa-442c-a824-de57648a8565)

3. Debugging works in the same way, the difference is that instead of *Run
As...* you must select the *Debug As...*.

## 4. GPIO (output version) <a name="4"></a>
Creating a project is the same as in the previous step (number 3).
1. You need to add a new element in Platform Designer:

![Image](https://github.com/user-attachments/assets/06fbc19a-9a9e-4215-9a9f-fe11abd7f3ec)

Remember about adding a name in *Export* column (in this case is *leds*) and
configuring parameters. In this case, an 8-bits GPIO output will be created:

![Image](https://github.com/user-attachments/assets/d3bf35fc-b391-4f32-9271-4c5871f7406a)

Remember alos about assigning base addresses.

2. Add code to *main.c*:
```cpp
#include <stdio.h>
#include "system.h"
#include "altera_avalon_pio_regs.h"

int main()
{
    IOWR_ALTERA_AVALON_PIO_DATA(PIO_BASE, 0xff);
    return 0;
}
```

File *system.h* is locate in *~/software/bsp/*. <br/>
File *altera_avalon_pio_regs.h* is locate in *~/software/bsp/drivers/inc/*. <br/>
Function *IOWR_ALTERA_AVALON_PIO_DATA* is in *altera_avalon_pio_regs.h*. <br/>
Constant *PIO_BASE* is in *system.h*.

3. Compiling, uploading the code, and debugging are performed as in the previous
steps.

## 5. GPIO (input and output version) <a name="5"></a>
1. 1. You need to add a new element in Platform Designer. In this case, an 1-bit
GPIO input will be created:

![Image](https://github.com/user-attachments/assets/17b85ed9-1f3e-4c3b-9730-bfe6f1a61bd8)

2. Modify code in *main.c*:
```cpp
#include <stdio.h>
#include "system.h"
#include "altera_avalon_pio_regs.h"

int main()
{
	uint8_t button;

	while(1)
	{
		button = IORD_ALTERA_AVALON_PIO_DATA(BUTTON_BASE);
		printf("\nButton value: 0x%x", button);
		for (int i = 0; i < 1000000; i++); // Delay loop
		if ((button == 0x1))
		{
			IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE, 0x00);
		}
		else
		{
			IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE, 0xff);
		}
	}

    return 0;
}
```

## 6. Timer and interrupts <a name="6"></a>
1. Add a new element in Platform Designer:

![Image](https://github.com/user-attachments/assets/5cb62bb8-f8a4-491b-bf82-1c61201a7a6f)

Parameters for timer:

![Image](https://github.com/user-attachments/assets/912d0db5-c8a1-40ea-8c1a-328f72d73ad6)

Additionally, change the interrupt vector in the *IRQ* column. The timer should
be assigned number 1, JTAG 0. This is the interrupt priority. <br/>
Remember alos about assigning base addresses.

2. Modify code in *main.c*:
```cpp
#include <stdio.h>
#include "system.h"
#include "altera_avalon_timer_regs.h"
#include "sys/alt_irq.h"

void init_timer_interrupt( void );
static void timer_isr( void * context, alt_u32 id);

int main()
{
    printf("Hello!\n");
    init_timer_interrupt();

	while(1){ }

    return 0;
}


void init_timer_interrupt( void )
{
    // Register the ISR with HAL
    alt_ic_isr_register(TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID,
                        TIMER_0_IRQ, (void *)timer_isr,
                        NULL,
                        0x0);

    // Start the timer
    IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,
                                    ALTERA_AVALON_TIMER_CONTROL_CONT_MSK |
                                    ALTERA_AVALON_TIMER_CONTROL_START_MSK |
                                    ALTERA_AVALON_TIMER_CONTROL_ITO_MSK);
}
static void timer_isr( void * context, alt_u32 id)
{
    static int count = 0;

    // Clear the interrupt
    IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0);

    // Do something
    printf("\nTimer Expired: %d", count++);
}
```

File *system.h* is locate in *~/software/bsp/*. <br/>
File *altera_avalon_timer_regs.h* is locate in *~/software/bsp/drivers/inc/*. <br/>
File *sys/alt_irq.h* is locate in *~/software/bsp/HAL/inc/sys/*. <br/>
Function *alt_ic_isr_register* is in *alt_irq.h*. <br/>
Constant *IOWR_ALTERA_AVALON_TIMER_CONTROL* is in *altera_avalon_timer_regs.h* <br/>
Constant *TIMER_0_BASE* is in *system.h*.

## 7. Custom peripheral <a name="7"></a>
1. Create simple module: <br/>
```v
library IEEE;
  use IEEE.std_logic_1164.all;
  
entity and_gate is port (
    // Signals clk, rst_n, chip_select, write, read, writedata and readdata are
    // required by Avalon.
	i_clk           : in std_logic;
	i_rst_n         : in std_logic;
	i_chip_select 	: in std_logic;
	i_write	        : in std_logic;
	i_read          : in std_logic;
	i_writedata 	: in std_logic_vector(31 downto 0);
	o_readdata      : out std_logic_vector(31 downto 0);
	// o_led is output from module which will be assigned to LED on the board
	o_led           : out std_logic
  );
end entity and_gate;

architecture rtl of and_gate is
	signal buff_led : std_logic;
begin

	o_led 	<= buff_led;

  process_and : process (i_clk) is
  begin

    if (i_clk'event and i_clk = '1') then
		if (i_rst_n = '0') then
			o_readdata 	<= (others => '0');
			buff_led 	<= '0';
		else
			if (i_chip_select = '1' and i_write = '1') then
				buff_led 		<= i_writedata(0);
			elsif (i_chip_select = '1' and i_read = '1') then
				o_readdata(0)	<= buff_led;
				o_readdata(31 downto 1)	<= (others => '0');
			else
				buff_led 		<= buff_led;
			end if;
		end if;
	end if;

  end process process_and;
end architecture rtl;
```

2. Save, run analysis and elaboration in Quartus.
3. Open Platform Designer, in IP Catalog click on *New Component...*
4. In *Files* tab click on *Add File...* and add recently created file.
5. Click on *Analyze Synthesis Files*:
![Image](https://github.com/user-attachments/assets/2311abda-706c-4bc3-939c-94672f6c9caa)
6. Open *Signals & Interfaces* tab. Change *Associated Clock* and *Associated 
Reset*, Add a new interfaces like: *Clock input*, *Reset input* and *Conduit*,
remove empty interfaces (probably *i* and *o*). Modify the existing component to 
look like this:
![Image](https://github.com/user-attachments/assets/b920d159-b6e8-4c0f-82f3-838f38df25e3)
7. Change *Signal Type* if it is necessary:
![Image](https://github.com/user-attachments/assets/23c6cb60-4cdc-4e29-bbaf-99e278ea42b0)
8. Change *Type* for interfaces if it's necessary:
![Image](https://github.com/user-attachments/assets/ea9ae3e9-2aaf-4973-acda-6af7de8bf5ad)
9. Click *Finish*.
10. In Platform Designer add a new component, by clicking on new ip in IP 
catalog. Connect signals, assign a base address:
![Image](https://github.com/user-attachments/assets/06f4cc1a-6583-44a9-994d-3dc9490156f3)
11. Click *Generate HDL...*. *Finish*.
12. Start compilation.
13. Open Ashling RiscFree and add a code to main.c: <br/>
```cpp
#include <stdio.h>
#include "system.h"
#include "io.h"

int main()
{
    IOWR(MY_IP_0_BASE, 0, 0x1);
    printf("\nValue: 0x%x", IORD(MY_IP_0_BASE, 0));
}
```
14. Build and upload to board.
