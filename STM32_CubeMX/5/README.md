## 1. Turn on *debug* option
1. Go to `Run` -> `Debug Configurations...` -> `Debugger` tab. Set core clock
for the same which is in *Clock Configuration* tab:
<img width="1134" height="384" alt="Image" src="https://github.com/user-attachments/assets/03bb9159-afd2-4060-a78e-cd034f49173b" />

2. Tick option `Enable` in Serial Wire Viewer (SWV):
<img width="1399" height="1438" alt="Image" src="https://github.com/user-attachments/assets/0fa2ce56-02d5-47e1-ba41-6c135517c3d7" />

3. Be sure the option `Enable live expressions` is ckecked in part Misc:

## 2. Turning on SWV ITM Data Console
Menu `Window` -> `Show View` -> `Other...`:
<img width="717" height="773" alt="Image" src="https://github.com/user-attachments/assets/01780dbe-64fc-40db-8d5d-48efeb99bb18" />

## 2. How to get rid of error *trace buffer overflow*
Menu `Window` -> `Preferences` tab *Serial Wire Viewer* -> change buffer size:
<img width="719" height="732" alt="Image" src="https://github.com/user-attachments/assets/c387c73f-4b19-4585-a643-41da00e4a8eb" />

## 3. Printing data in SWV ITM Data Console
To print a message to the terminal while debugging, you can do it in two ways:
1. Add handling for `stderr` when calling the `fprintf` function, for example:

```
fprintf(stderr, "stderr: %lu\n", loop_cnt);
```

```
// Send printf to uart1
int _write(int fd, char* ptr, int len)
{
	if (fd == 1)
	{
		HAL_StatusTypeDef hstatus;
		hstatus = HAL_UART_Transmit(&huart2, (uint8_t *) ptr, len, HAL_MAX_DELAY);
		if (hstatus == HAL_OK)
			return len;
		else
			return -1;
	} else if (fd == 2)
	{
		for (int i = 0; i < len; i++)
			ITM_SendChar(ptr[i]);
		return len;
	} else
		return -1;

	return -1;
}
```

2. Directly use the `ITM_SendChar()` function, without calling `fprintf`:
```
ITM_SendChar('B');
ITM_SendChar('T');
ITM_SendChar('N');
ITM_SendChar('\n');
```
