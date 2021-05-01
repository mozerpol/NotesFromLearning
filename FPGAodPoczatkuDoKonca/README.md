# FPGAodPoczatkuDoKonca 
In this repo I will post my private notes from reading a series of two articles from *elektronikab2b* website. They are written in my native language (Polish). 

## FPGA od początku do końca - część pierwsza
[Here](https://elektronikab2b.pl/technika/1315-fpga-od-poczatku-do-konca-czesc-pierwsza) is the link to the first article. Word "*pierwsza*" means *first*, "*od początku do końca*" means *from the beginning to the end*. So title in eng means *FPGA from the beginning to the end*. <br/>
An extension of the acronym *VHDL* is *Very High Speed Integrated Circuit Hardware Description Language*. <br/>
To understand article, you need to learn how cells are connected in FPGA. Below is picture of the [LUT](https://electronics.stackexchange.com/questions/169532/what-is-an-lut-in-fpga): <br/>
| ![obraz](https://user-images.githubusercontent.com/43972902/116738433-b80d6f00-a9f2-11eb-984f-3b2807ed8838.png) |
|:--:|
| *A typical logical element* |
| source: *https://pl.wikipedia.org/wiki/Bezpo%C5%9Brednio_programowalna_macierz_bramek#/media/Plik:Logic_block2.svg [30.04.2021]* |

And imagine that our FPGA mainly consists of this type of logic elements. Inside you have a lot of these elements and they're connected together. We have many different types of connections between logic elements, such as *fuse*, *antifuse* or based on transistors. Type *fuse* and *antifuse* cannot be changed after programming, but connections created with transistors can be reprogrammed.

#### FPGA can be divided according to the type of technology used to remember their configuration: 
##### Antifuse type 
This type of device allows us to only program them only once. It's an old technological type. <br/>
Device consists a lot of fuses inside which can only work after burnout (typically it's resistor 300 Ω). For this reason, the data in this type of FPGA can't be change. Due to their design, they are the safest systems. Almost all reverse engineering attempts to read the configuration of such a system are unsuccessful (it's virtually impossible). It should be noted, that by default the antifuse devices allow to read the saved configuration in order to test the correctness of the programming process, but after setting a special security bit, access to the internal configuration is blocked. Antifuse FPGAs are even more reliable than ASICs. <br/> 
The lack of internal transistors responsible for the configuration, makes these circuits much less susceptible (pol. *podatny*) to radiation damage. Thanks to it, this type of device is using in aeronautics or aviation where FPGAs based on SRAM or Flash memory will be too insecure. Also these types of devices are also still used by the military, due to high resistance to an EMP (electromagnetic pulse) from nuclear weapons. <br/>
Antifuse devices, due to the lack of configuration transistors, consume much less static power than the SRAM or Flash circuits manufactured in the same technology. This value is about 20% of the power consumed by the reprogrammable circuit. What's more, the lack of transistors also means no delays introduced by them, thanks to which the entire system is able to run much faster. <br/>
A very important advantage is that such devices are very durable (pol. *wytrzymałe*). The internal connectivity of antifuse components and networks is practically impossible to break without the destruction of the device, board or component. This makes devices highly reliable. <br/>
Big disadvantages of this system is high development costs and must (pol. *koniecznością*) to use a few steps less advanced technological process. Imagine situation when any errors are discovered... ;D <br/>
Thanks to this advantages of antifuse FPGA over other technologies are losing importance. 
 
##### SRAM type
This type of device is based on static memory technology, because of this lose their configuration after a power loss. Unlike *antifuse* devices, these can be programmed multiple times. These deviecs don't require any additional technological processes, so these systems are designed based on the most advanced technologies. <br/>
Unfortunately, SRAM chips are volatile, so it's necessary to load the configuration code inside the chip every time when the system boots up. Configuration code is oad from a special non-volatile memory chip such as EPROM or Flash. This additional requirement makes it necessary to reserve more space on the PCB surface. <br/>
In addition, the process of uploading the program takes some time, which delay the start of the device. These data can be easily read, which makes the project easy to decode and duplicate on other devices. 

##### Flash type
*Flash* device combine the advantages of *SRAM* and *antifuse* devices. <br/>
These devices remember the code, so there are no delays during startup. Their internal structure is less complicated than that *SRAM* devices, so they can be packed more densely (pol. *gęsto*). <br/>
Due to the production problems, these systems are usually several generations older than their counterparts (pol. *odpowiedniki*) produced at the same time, which only require the use of methods typical for *CMOS*. <br/>
Another disadvantage is the increased static power consumption, which is due to the pull-up resistors. 

## FPGA od początku do końca - część druga
[Here](https://elektronikab2b.pl/technika/1468-fpga-od-poczatku-do-konca-czesc-druga) is the link to the article.












