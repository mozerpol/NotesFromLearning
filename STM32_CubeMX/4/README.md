
For my Nucleo board I have to use USART2.

# 1. Difference in data transmission: DMA vs Interrupts vs Polling
In interrupt mode, every time when a byte of data is sent, an interrupt is
generated, indicating that the next byte of data can be sent. After sending the
next byte of data, another interrupt is generated, and so on... Between these
interrupts, the processor can perform various operations because sending data
from UART only involves loading a byte of data into a register, while the UART
module handles the actual transmission. <br/>
In polling mode, a special flag in the UART register is continuously checked to
see if a byte of data has been sent. If it has been sent, the next byte of data
is loaded into the UART register, and then the UART module sends it. The
processor must check the UART register flag, which consumes clock cycles. <br/>
DMA loads data to be sent into the UART register, allowing the processor to
avoid this task.

# 2. Pinout & Configuration
<img width="740" height="690" alt="Image" src="https://github.com/user-attachments/assets/4d62d84f-a5ba-43f3-8245-a793bb565275" />

## 2.1. System Core
### 2.1.1. DMA
<img width="715" height="155" alt="Image" src="https://github.com/user-attachments/assets/10816d6d-8791-4136-b336-0887c05fa414" />

### 2.1.2. GPIO
<img width="1132" height="373" alt="Image" src="https://github.com/user-attachments/assets/79b9b9ac-da62-4fe5-a054-d0d81cc0cc3e" />

### 2.1.3. NVIC
<img width="1132" height="496" alt="Image" src="https://github.com/user-attachments/assets/2ca7a264-5074-472e-8b36-6a637a44a7b4" />

## 3.1. Connectivity
### 3.1.1. USART2
<img width="1132" height="818" alt="Image" src="https://github.com/user-attachments/assets/d4cf7832-e810-4a1d-be9e-c5ac9ead3366" />

# 3. Clock Configuration
<img width="1138" height="1003" alt="Image" src="https://github.com/user-attachments/assets/2e41da58-dbe2-4bf2-9b60-b5899c1ac016" />

# 4. Transmit
Written based on the article:
https://controllerstech.com/stm32-uart-2-use-interrupt-dma-to-transmit-data/#info_box

There are three possibilities for transmission:
## 4.1. Polling mode.
I don't use this here; it is implemented through function:
```
HAL_UART_Transmit(huart, data_buffer, data_size, timeout_eg_1000);
```

## 4.2. Interrupts
Data is sent with function (non-blocking mode using interrupts):
```
HAL_UART_Transmit_IT(huart, data_buffer, data_size);
```
When UART sends all the data then an interrupt occurs, and the function
`HAL_UART_TxCpltCallback` is executed.
```
void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)
{
	// Some code... The data to be sent can be changed here, or for example
	// any flag may be activated that will trigger the sending of another
	// part of data.
}
```

## 4.3. DMA
Data is sent using function (non-blocking mode using DMA):
```
HAL_UART_Transmit_DMA(huart, data_buffer, data_size);
```
When UART sends all the data then an interrupt occurs, and the function
`HAL_UART_TxCpltCallback` is executed. Just like with the use of interrupts.
```
void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)
{
	// Some code... The data to be sent can be changed here, or for example
	// any flag may be activated that will trigger the sending of another
	// part of data.
}
```

# 5. Receive
Written based on the article:
https://controllerstech.com/stm32-uart-3-receive-data-in-blocking-interrupt-mode/

There are three possibilities for transmission:
## 5.1. Polling mode.
I don't use this here; it is implemented through function:
```
HAL_UART_Receive(huart, data_buffer, data_size, timeout_eg_1000);
```

## 5.2. Interrupts
```
HAL_UART_Receive_IT(huart, data_buffer, data_size);
```

## 5.3. DMA
```
HAL_UART_Receive_DMA(huart, data_buffer, data_size);
```
