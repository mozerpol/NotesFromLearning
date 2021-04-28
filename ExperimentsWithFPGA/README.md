## ExperimentsWithFPGA 
_______________

In this repo I'll post my private notes from reading the series of articles that appeared in the *Elektronika Praktyczna* magazine. <br/>
It was a series of eighteen [?] articles, the first article appeared in the issue 12.2019 <br/>
The articles were written in my mother language (Polish). You can buy all numbers directly from the producer: https://ulubionykiosk.pl/archiwum/elektronika-praktyczna [27.04.2021]. <br/>
On the internet you can find legally shared articles (perhaps not every article was shared). Just search in google "elektronika praktyczna eksperymenty z fpga", example of second article: https://ep.com.pl/kursy/13584-eksperymenty-z-fpga-2 <br/>

Below I will describe how to start the first project with Quartus and upload project to FPGA. This will be additional info, for my convenience, but maybe, it'll useful for someone in the future :) <br/>

### How run Quartus
I'm linux user (Debian buster 4.19), so everything will be shown on linux. I used **Quartus Prime Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition**, *Patches Installed: None*. Unfortunately I will not show (maybe later) how to install Quartus with all drivers, but I remember that I had very very big problem with it :D <br/>
So in first step from terminal in **superuser mode** we're going to destination where we installed Quartus: <br/>
`/home/mozerpol/Documents/nauka/quartus/quartus/bin` <br/>
In *bin* folder we should find a file called "quartus", only quartus, not quartus_asm or quartus_sh. When we find this file we can run it: <br/>
`root@mozerpol-pc:/home/mozerpol/Documents/nauka/quartus/quartus/bin# ./quartus` and press *enter* <br/>

### First project in Quartus
I learned Verilog, so I will show on this. After running the program, we should see main window: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/116382240-fd287a00-a815-11eb-8081-e37320aabde3.png)

In the upper right corner click *File* -> *New Project Wizard...*. After whis we will see: 
1. <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116383619-4927ee80-a817-11eb-992a-ba1c37493f1a.png)
2. In first form select directory for project in second form write name for project <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116384518-35c95300-a818-11eb-9d90-e7bb362fb77e.png)
3. In next step *Project Type* select option *Empty Project* and click *Next*.
4. In next step we have *Add Files* window. We (or I ;p) don't want add files to projesc, so just click *Next*.
5. Step *Family, Device & Board Settings*. In this stage we must select matchable device. <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116385280-ef282880-a818-11eb-80c1-1c304f8ac655.png)
We are setting everything in tab *Device*. In part *Avalible devices* find your device and select it. How to know, which exactly FPGA is in your board? Just look at board and find FPGA. Below we have example photo from internet. <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116386942-935e9f00-a81a-11eb-8a82-d5cf2c628b0d.png) <br/> Thanks to numbers which are on FPGA, we know that it is *MAX 10* family, device *10M50DAF484C6GES*. <br/>
Select it (not exactly that, but your device that you have on your own board, it's example ;p) <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116388009-b2a9fc00-a81b-11eb-8d85-4bb95fb2ef0c.png)
6.


