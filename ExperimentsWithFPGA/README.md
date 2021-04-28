## ExperimentsWithFPGA 
_______________

In this repo I'll post my private notes from reading the series of articles that appeared in the *Elektronika Praktyczna* magazine. <br/>
It was a series of eighteen [?] articles, the first article appeared in the issue 12.2019 <br/>
The articles were written in my mother language (Polish). You can buy all numbers directly from the producer: https://ulubionykiosk.pl/archiwum/elektronika-praktyczna [27.04.2021]. <br/>
On the internet you can find legally shared articles (perhaps not every article was shared). Just search in google "elektronika praktyczna eksperymenty z fpga", example of second article: https://ep.com.pl/kursy/13584-eksperymenty-z-fpga-2 <br/>

Below I will describe how to start the first project with Quartus and upload project to FPGA. This will be additional info, for my convenience, but maybe, it'll useful for someone in the future :) <br/>

### How run Quartus
I'm linux user (Debian buster 4.19), so everything will be shown on linux. Unfortunately I will not show how to install Quartus with all drivers, but I remember that I had very very big problem with it :D <br/>
So first from terminal in **superuser mode** we're going to destination where we installed Quartus: <br/>
`/home/mozerpol/Documents/nauka/quartus/quartus/bin` <br/>
In *bin* folder we should find a file called "quartus", only quartus, not quartus_asm or quartus_sh. When we find this file we can run it: <br/>
`root@mozerpol-pc:/home/mozerpol/Documents/nauka/quartus/quartus/bin# ./quartus` and press *enter* <br/>

### First project in Quartus
I learned Verilog, so I will show on this. After running the program, we should see main window: <br/>
![obraz](https://user-images.githubusercontent.com/43972902/116382240-fd287a00-a815-11eb-8081-e37320aabde3.png)

In the upper right corner click *File* -> *New Project Wizard...*. After whis we will see: 
1. <br/> ![obraz](https://user-images.githubusercontent.com/43972902/116383619-4927ee80-a817-11eb-992a-ba1c37493f1a.png)

