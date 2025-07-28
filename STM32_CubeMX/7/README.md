# 1. Description
For testing I use a development board *KA‑Nucleo‑Multisensor* with several 
modules, link: 
https://kamami.pl/kamod-kamami/563404-ka-nucleo-multisensor-shield-dla-stm32-nucleo-z-wyswietlaczem-i-czujnikami-mems-5906623433278.html

Its schematic:
<img width="1908" height="1173" alt="Image" src="https://github.com/user-attachments/assets/fb599c83-e02a-401e-8770-8205f4184b01" />

Unfortunately pinout of the *KA-Nucleo-Multisensor* doesn't match to my STM32 
Nucleo version. For that reason I wired the board to the module board using 
wires. I'm using I2C1. Only STM32 Nucleo is connected to the PC.

| Pinout of the STM32 Nucleo (I2C1) | I2C pinout                    | Pinout of the KA-Nucleo-Multisensor                   | 
|--:                                |:--:                           |:--                                                    |
| PB6, pin 17 (CN10)                | <-----SCL-----> | Pin 63 (corresponds to PB10, pin 25 CN10 on the STM32 Nucleo board) |
| PB7, pin 21 (CN7)                 | <-----SDA-----> | Pin 56 (corresponds to NC, pin 18 CN10 on the STM32 Nucleo board)   |
| Pin 16 (CN7)                      | <-----+3V3----> | Pin 16 (corresponds to +3V3, pin 16 CN7 on the STM32 Nucleo board)  |
| Pin 19 (CN7)                      | <-----GND-----> | Pin 20 (corresponds to GND, pin 20 CN10 on the STM32 Nucleo board)  |

The connected system looks like this, where green wire is SCL, yellow is SDA,
blue is GND, red is +3V3:
<img width="1015" height="1354" alt="Image" src="https://github.com/user-attachments/assets/24c5ab35-9497-4aac-8a67-b6c903c684ec" />

# 2. Clock Configuration
<img width="1151" height="1006" alt="Image" src="https://github.com/user-attachments/assets/a34ab14c-ccc1-43f7-83f6-9986da77878b" />

# 3. System Core
<img width="807" height="801" alt="Image" src="https://github.com/user-attachments/assets/187a7350-713c-414d-8956-a724a7114374" />

## 3.1. GPIO
<img width="993" height="411" alt="Image" src="https://github.com/user-attachments/assets/3be3ddc2-3fa8-4b06-916a-05b5c0f83d82" />

## 3.2. NVIC
<img width="980" height="492" alt="Image" src="https://github.com/user-attachments/assets/2c9d1ad7-a092-47e0-bbd4-3e7164a809b1" />

## 3.3. RCC
<img width="980" height="431" alt="Image" src="https://github.com/user-attachments/assets/9720eb02-5c63-4e3d-8f66-de34efc4b34c" />

## 3.4. SYS
<img width="989" height="161" alt="Image" src="https://github.com/user-attachments/assets/64e0c917-ee73-4cae-96a1-f90647e9e24b" />

# 4. Connectivity
## 4.1. I2C1
<img width="985" height="545" alt="Image" src="https://github.com/user-attachments/assets/6b97ea74-7060-47b8-bba6-bde71b1caab5" />

## 4.2. USART2
<img width="990" height="526" alt="Image" src="https://github.com/user-attachments/assets/7be5ecdb-aba7-4135-bdcd-176402d809df" />
