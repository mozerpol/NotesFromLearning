# FPGAodPoczatkuDoKonca 
In this repo I will post my private notes from reading a series of two articles from *elektronikab2b* website. They are written in my native language (Polish). 

## FPGA od początku do końca - część pierwsza
[Here](https://elektronikab2b.pl/technika/1315-fpga-od-poczatku-do-konca-czesc-pierwsza) is the link to the first article. Word "*pierwsza*" means *first*, "*od początku do końca*" means *from the beginning to the end*. So title in eng means *FPGA from the beginning to the end*. <br/>
An extension of the acronym *VHDL* is *Very High Speed Integrated Circuit Hardware Description Language*. <br/>
#### Devices of *antifuse* type 
This type of device allows us to only program them only once. Device consists a lot of fuses inside which can only work after burnout. For this reason, the data in this type of FPGA can't be change. Due to their design, they are the safest systems. Almost all reverse engineering attempts to read the configuration of such a system are unsuccessful. It should be noted, that by default the antifuse devices allow to read the saved configuration in order to test the correctness of the programming process. Only after setting a special security bit, access to the internal configuration is blocked. The lack of internal transistors responsible for the configuration, makes these circuits much less susceptible (pol. *podatny*) to radiation damage. Thanks to it, this type of device is using in aeronautics or aviation where FPGAs based on SRAM or Flash memory will be too insecure.     

## FPGA od początku do końca - część druga
[Here](https://elektronikab2b.pl/technika/1468-fpga-od-poczatku-do-konca-czesc-druga) is the link to the article.
