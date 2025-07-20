# Video number 5
____

## 1. Step Into (F5) vs. Step Over (F6)
First, click *Debug*. The program will stop at the first statement executed in 
the *main()*:
<img width="952" height="592" alt="Image" src="https://github.com/user-attachments/assets/fa6f987c-008a-488f-81c9-f823cc7065a5" />

Clicking *Step Into* ...
<img width="497" height="116" alt="Image" src="https://github.com/user-attachments/assets/09e07e95-e025-4020-927f-bac59e93fc65" />

... enters to the body of the function pointed to by the arrow:
<img width="1151" height="451" alt="Image" src="https://github.com/user-attachments/assets/0941eaf7-7dfa-4db5-b47e-067439891aaf" />

Clicking on *Step Over* moves execution arrow between lines inside of the 
currently running function: 
<img width="694" height="673" alt="Image" src="https://github.com/user-attachments/assets/a58e0942-7fbe-455a-b632-85f9232db39c" />

## 2. Resume (F8)
The *Resume* option resumes (pol. *wznawiać*) normal program execution from 
where it was paused, continuing until the next breakpoint or stop (for example 
the next breakpoint, program termination, or a manual pause):
<img width="638" height="305" alt="Image" src="https://github.com/user-attachments/assets/eee7a106-e19a-428c-820b-d05a925d1cce" />


# Video number 17
_____

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

And Enable Prescaler, enable Comparator 0 and add variable, also enable port 0:
<img width="1019" height="677" alt="Image" src="https://github.com/user-attachments/assets/1b3614a7-0cbb-4aa9-a8ab-2a64594af43d" />

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

## 6. Pinout & Configuration
<img width="602" height="580" alt="Image" src="https://github.com/user-attachments/assets/d23b0ddb-3b68-4f2a-b030-6430445d870f" />

### 6.1. GPIO
<img width="1138" height="364" alt="Image" src="https://github.com/user-attachments/assets/9394ffc7-aab9-4634-a62e-d395e7bf1380" />

### 6.2. NVIC
<img width="1147" height="437" alt="Image" src="https://github.com/user-attachments/assets/b6bbce0b-ef48-47e5-a3c1-9c0cb9629b6d" />

### 6.3. RCC
<img width="1139" height="224" alt="Image" src="https://github.com/user-attachments/assets/9821d91f-71dd-496f-8afd-555df1d6d919" />

### 6.4. Connectivity
<img width="1139" height="300" alt="Image" src="https://github.com/user-attachments/assets/4d3446b6-7beb-4f6d-b38e-446f09e85518" />
