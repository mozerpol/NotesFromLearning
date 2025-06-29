Written based on the article:
https://controllerstech.com/stm32-uart-2-use-interrupt-dma-to-transmit-data/#info_box
_______

For my Nucleo board I have to use USART2.

# Transmit
There are three possibilities for transmission:
1. Polling mode:
I don't use this here; it is implemented through function:
```
HAL_UART_Transmit(huart, data, data_size, timeout_eg_1000);
```

2. Interrupts
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

3. DMA
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

# Receive

