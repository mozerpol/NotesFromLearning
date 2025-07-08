Written based on the article:
https://controllerstech.com/stm32-uart-2-use-interrupt-dma-to-transmit-data/#info_box
For my Nucleo board I have to use USART2.
_______

# Transmit
There are three possibilities for transmission:
## 1. Polling mode.
I don't use this here; it is implemented through function:
```
HAL_UART_Transmit(huart, data, data_size, timeout_eg_1000);
```

## 2. Interrupts
Data is sent with function (non-blocking mode using interrupts):
```
HAL_UART_Transmit_IT(huart, data, data_size);
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

## 3. DMA
Data is sent using function (non-blocking mode using DMA):
```
HAL_UART_Transmit_DMA(huart, data, data_size);
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

## Difference in data transmission: DMA vs Interrupts vs Polling
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

# Receive
https://controllerstech.com/stm32-uart-2-use-interrupt-dma-to-transmit-data/#info_box
