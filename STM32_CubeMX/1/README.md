# Pinout & Configuration tab

# 1. System Core
## 1.2. Set LD2, it's connected to PA5

![Image](https://github.com/user-attachments/assets/72c46a01-cfe9-4ded-b5c9-ad71786c103f)

### 1.2.1. Edit GPIO tab and also edit NVIC tab:

![Image](https://github.com/user-attachments/assets/5d9f2fd5-f7b2-42d3-b861-e3eab0de5bb1)

## 1.2. Set B1 USER button, it's connected to PC13

![Image](https://github.com/user-attachments/assets/1667ca12-90fb-4efb-9fb0-2021e464cf14)

## 1.3. Edit NVIC tab

![Image](https://github.com/user-attachments/assets/1697d1d0-37ae-4745-8660-ec1ada2f5d43)

## 1.3. Edit RCC tab
Modify HSE option, but I'm not thinks so it's important, coz I'm not using HSE
in this project.

![Image](https://github.com/user-attachments/assets/06ade53b-e249-4f52-814a-4395b6a30e45)

# 1.4. Edit SYS tab
Modify Debug option.

![Image](https://github.com/user-attachments/assets/f905a0c9-334c-4695-aad9-2043cf4c740f)

# 2. Timers
## 2.1. Set timers
How to calculate prescaler and counter period? <br/>
Timer4 is connected to APB1 bus (screen taken from datasheet for STM32F446xC/E -
Arm Cortex-M4):

![Image](https://github.com/user-attachments/assets/069cd9c7-e27b-4506-a4fb-f9e827eee95f)

So, look on the Clock Configuration tab:

![Image](https://github.com/user-attachments/assets/f4a4a557-7cda-4121-a9fb-52483d2fdc8f)

Clock source is HSI (it's internal clokc), HSE cannot be selected coz it comes
from an external crystal which the dev board doesn't have. In Clock Config tab
APB1 Timer clocks is set to 90 MHz. So... <br/>
90 MHz = 90 000 000 Hz <br/>
I want receive 1 Hz period. 90 000 000 / 45000 = 2000 HZ <br/>
2000 / 2000 = 1 Hz <br/>
The first 45000 value is prescaler (but substract 1 from it), the second value
2000 is counter period (also sub 1 from this number).

If I need 0.1 HZ (it's 10 sec) then: <br/>
(APB1 bus clock / prescaler-1 ) / counter period-1 <br/>
(90 000 000 / 45000-1) / 20000-1 = 0.1

## 2.2. TIM4
Set tick Internal Clock, modify Prescaler and Coutner Period. Parameter
Settings:

![Image](https://github.com/user-attachments/assets/6162e7d4-6140-4fb3-a6ec-8f56628cf207)

NVIC Settings:

![Image](https://github.com/user-attachments/assets/5439fd72-c578-415b-afc0-fa476d436597)

# 3. Connectivity
## 3.1. USART2

![Image](https://github.com/user-attachments/assets/4b6c4850-a05a-4225-a727-7ed6f3038dad)

# Clock Configutation tab

![Image](https://github.com/user-attachments/assets/7e21c0c1-9db3-433a-a4fa-6f17b08ee4d8)
