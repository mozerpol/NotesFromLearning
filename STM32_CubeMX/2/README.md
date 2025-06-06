I'm using USART2 and TIMER2 with channel 1

Repeat some steps from README in folder 1, but remove connection to PA on LD2,
TIMER4 and connection to button on PC13.

Use timer 2, why this timer? Because PA5 (which is connected to LED LD2) is
connected to output from timer 2 channel 1. So select TIM2_CH1 on PA5:

![Image](https://github.com/user-attachments/assets/7f3740e5-95e5-4748-954c-51e8f02d7cb7)

Modify NVIC (turn off interrupts):

![Image](https://github.com/user-attachments/assets/90c8b991-46cc-4700-957e-08d2c06c358e)

Modify timer 2, set prescaler, counter period and pulse:

![Image](https://github.com/user-attachments/assets/eac43c90-b36d-441e-ae45-bb63a17d8ccc)

Turn off TIM2 global interrupt in NVIC settings (if it's set):

![Image](https://github.com/user-attachments/assets/f907add7-ee38-4897-bfd6-455112710be2)

Frequency in clock configuration for APB1 Timer clocks is: 90 000 000 HZ

90 000 000/45000 = 2000 HZ

2000/20 = 100 HZ

Pulse set from 0 to counter period set duty cycle for PWM.

Changing PWM duty cycle in C:

```C
__HAL_TIM_SET_COMPARE(&htim2, TIM_CHANNEL_1, pwm_value);
```
