## 1. Turn on *debug* option
1. Go to `Run` -> `Debug Configurations...` -> `Debugger` tab. Set core clock
for the same which is in *Clock Configuration* tab:
<img width="1134" height="384" alt="Image" src="https://github.com/user-attachments/assets/03bb9159-afd2-4060-a78e-cd034f49173b" />

2. Tick option `Enable` in Serial Wire Viewer (SWV) and be sure the option 
`Enable live expressions` is checked in part Misc:
<img width="1399" height="1438" alt="Image" src="https://github.com/user-attachments/assets/9b38ed27-2aa6-46f1-90b6-c217957d3764" />

## 2. Turning on SWV ITM Data Console
Menu `Window` -> `Show View` -> `Other...`:
<img width="717" height="773" alt="Image" src="https://github.com/user-attachments/assets/01780dbe-64fc-40db-8d5d-48efeb99bb18" />

## 3. How to get rid of error *trace buffer overflow*
Menu `Window` -> `Preferences` tab *Serial Wire Viewer* -> change buffer size:
<img width="719" height="732" alt="Image" src="https://github.com/user-attachments/assets/c387c73f-4b19-4585-a643-41da00e4a8eb" />

## 4. Printing data in SWV ITM Data Console
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
## 5. Configure SWV Data Trace Timeline Graph
Firstly run Debug, then
1. Go to SWV Data Trace Timeline Graph and click *Configure trace*:
<img width="2097" height="588" alt="Image" src="https://github.com/user-attachments/assets/8277fe22-02f8-4df9-9cc6-cec689db6514" />

2. Click on *Start Trace*:
<img width="362" height="231" alt="Image" src="https://github.com/user-attachments/assets/39114fd1-8076-4660-9c90-5e830a693be0" />

3. Click on *Resume*:
<img width="282" height="185" alt="Image" src="https://github.com/user-attachments/assets/e5a38897-2c01-4164-b899-03fbe7c26f76" />

## 6. The result of running the code
1. SWV Data Trace Timeline Graph
<img width="1363" height="334" alt="Image" src="https://github.com/user-attachments/assets/e6a17559-f4b8-4804-961c-7e30acbc25bf" />

2. SWV ITM Data Console
<img width="974" height="331" alt="Image" src="https://github.com/user-attachments/assets/3595b141-9859-4f99-81ca-553ef0896861" />

3. UART monitor
<img width="229" height="528" alt="Image" src="https://github.com/user-attachments/assets/4cfac2ff-ea9d-4694-a152-7895411e4769" />
