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
2. In the first form select directory for project in the second form write name for project <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116384518-35c95300-a818-11eb-9d90-e7bb362fb77e.png)
3. In the next step *Project Type* select option *Empty Project* and click *Next*.
4. In the next step we have *Add Files* window. We (or I ;p) don't want add files to projesc, so just click *Next*.
5. Step *Family, Device & Board Settings*. In this stage we must select matchable device. <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116385280-ef282880-a818-11eb-80c1-1c304f8ac655.png)
We are setting everything in tab *Device*. In part *Avalible devices* find your device and select it. How to know, which exactly FPGA is in your board? Just look at board and find FPGA. Below we have example photo from internet. <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116386942-935e9f00-a81a-11eb-8a82-d5cf2c628b0d.png) <br/> Thanks to numbers which are on FPGA, we know that it is *MAX 10* family, device *10M50DAF484C6GES*. <br/>
Select it (not exactly that, but your device that you have on your own board, it's example ;p) <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116388009-b2a9fc00-a81b-11eb-8d85-4bb95fb2ef0c.png)
6. In the next step *EDA Tool Settings* select everywhere *<None>*.
7. Last window in our configuration is *Summary*.
8. Now our main window looks like: <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116389086-db7ec100-a81c-11eb-907b-888077490e4f.png)
9. Now it's time to add verilog file. To do this, click *File* -> *New...*, after this you'll see something like this: <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116430487-2d3c4100-a847-11eb-9c78-c518dabbb872.png) <br/>
Click on *Verilog HDL File*
10. Now, you should see empty page, where we can write some code. Just copy and paste below code: <br/>
```verilog
module quartusFirstTest(
    output a,
    output b,
    output c
);

assign a = 1'b0;
assign b = 1'b1;
assign c = 1'b1;

endmodule
```
11. Save project by *ctrl + s*. It's very important filename and name after word `module` in our code must be the same as project name. So, if our project is called *quartusFirstTest*, then verilog file must be called *quartusFirstTest.v* and module in our code. Of course not every file or module must be called in this way :D. Only one file and one module.
12. The next step: click on the icon *Start Compilation* or press *Ctrl + L*. Below is the picture, with icon which you should click: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/116433590-f0257e00-a849-11eb-9dde-347f181e585e.png) <br/>
This start compilation. On the left side you should see bars with progress and bottom with messages like warnings or errors.
![obraz](https://user-images.githubusercontent.com/43972902/116432967-58c02b00-a849-11eb-96d8-e426a4ea881b.png)
13. Now click on the *Pin Planner* or press *Ctrl + Shift + N*, Below is the picture, with icon which you should click: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/116435464-aa69b500-a84b-11eb-9b28-3e78ae14c10f.png)
14. 









