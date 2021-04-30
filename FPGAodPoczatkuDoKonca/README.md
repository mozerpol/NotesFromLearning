# FPGAodPoczatkuDoKonca 
In this repo I will post my private notes from reading a series of two articles from *elektronikab2b* website. They are written in my native language (Polish). 

## FPGA od początku do końca - część pierwsza
[Here](https://elektronikab2b.pl/technika/1315-fpga-od-poczatku-do-konca-czesc-pierwsza) is the link to the first article. Word "*pierwsza*" means *first*, "*od początku do końca*" means *from the beginning to the end*. So title in eng means *FPGA from the beginning to the end*. <br/>
An extension of the acronym *VHDL* is *Very High Speed Integrated Circuit Hardware Description Language*. <br/>
#### FPGA can be divided according to the type of technology used to remember their configuration: 
##### Antifuse type 
This type of device allows us to only program them only once. It's an old technological type. <br/>
Device consists a lot of fuses inside which can only work after burnout (typically it's resistor 300 Ω). For this reason, the data in this type of FPGA can't be change. Due to their design, they are the safest systems. Almost all reverse engineering attempts to read the configuration of such a system are unsuccessful (it's virtually impossible). It should be noted, that by default the antifuse devices allow to read the saved configuration in order to test the correctness of the programming process, but after setting a special security bit, access to the internal configuration is blocked. Antifuse FPGAs are even more reliable than ASICs. <br/> 
The lack of internal transistors responsible for the configuration, makes these circuits much less susceptible (pol. *podatny*) to radiation damage. Thanks to it, this type of device is using in aeronautics or aviation where FPGAs based on SRAM or Flash memory will be too insecure. Also these types of devices are also still used by the military, due to high resistance to an EMP (electromagnetic pulse) from nuclear weapons. <br/>
Antifuse devices, due to the lack of configuration transistors, consume much less static power than the SRAM or Flash circuits manufactured in the same technology. This value is about 20% of the power consumed by the reprogrammable circuit. What's more, the lack of transistors also means no delays introduced by them, thanks to which the entire system is able to run much faster. <br/>
A very important advantage is that such devices are very durable (pol. *wytrzymałe*). The internal connectivity of antifuse components and networks is practically impossible to break without the destruction of the device, board or component. This makes devices highly reliable. <br/>
Big disadvantages of this system is high development costs and must (pol. *koniecznością*) to use a few steps less advanced technological process. Imagine situation when any errors are discovered... ;D
Thanks to this advantages of antifuse FPGA over other technologies are losing importance. 

dokonczyc https://www.tempoautomation.com/blog/the-advantages-of-antifuse-technology-for-aerospace-applications/
 
##### SRAM type

## FPGA od początku do końca - część druga
[Here](https://elektronikab2b.pl/technika/1468-fpga-od-poczatku-do-konca-czesc-druga) is the link to the article.












