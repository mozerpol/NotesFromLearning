/* This code was created in order to pass the laboratory at my univeristy. We got datasheet ADS8588H device and
based on waveforms from this datasheet I wrote this code. ADS8588H is 16-bit ADC. */
`timescale 1ns/1ns 	// `timescale <unit of time>/<precision> 

`define tPH_CN 2000	// CONVSTA/B duration high time pulse [ns]
`define tPL_CN 2000	// CONVSTA/B duration low time pulse [ns]
`define tSU_BSYCS 10	// time delay on CS after low edge on BUSY [ns]
`define tCONV 1240	// conversion time: BUSY high time, when oversampling is disabled [ns]
`define tD_CNBSY 10	// time delay on BUSY after high edge on CONVSTA/B [ns]
`define tPH_RST 1700// rst high time, min 10 ns

module ADS8588H_tb();

  reg sys_clk = 0;  // main clock 10 MHz 
  reg refsel_tb;  	// var for reference voltage. 1 - internal ref, 0 - external
  reg stby_tb;  	// 1 - standby mode, 0 - shut down device
  reg convsta_tb;	// conversion start A between 1-4 channels, 1 - start sampling and conv process
  reg convstb_tb;	// conversion start B between 5-8 channels
  reg reset_tb;		// 1 - reset device. Start reset on falling edge after high pulse 
  reg range_tb;		// control measurement range. 1 - 10 V, 0 - 5 V  
  reg cs_tb;		// can use more devs on the same buses 
  reg rd_sclk_tb;	// clock
  reg par_ser_tb;	
  wire [15:0] db_tb;
  /*For serial work:
  	db is duplex bus in serial mode:
    db[15] 	- logic 1 means parallel byte mode, 0 - serial mode 
    db[14] 	- tied to low
    db[13:9] - tied to low
    db[8] 	- output data for 5-8 channels
    db[7] 	- output data for 1-4 channels
    db[6:0] - tied to low
  */
  reg [2:0] os_tb;		// used for oversampling. 000 - oversamplig is disabled  
  reg db_bus_ctrl = 0;	// auxiliary var to control 15 register in db bus
  integer i;			// to control for loop

  and(db_tb[15], db_bus_ctrl, 1); // allow set device in serial mode (db_tb[15] = 1)

  ADS8588H UUT( // UUT is an instance of the gate module. UUT - unit under test
    .rd_sclk(sys_clk), // Binding vars from test with vars from model
    .refsel(refsel_tb),
    .stby(stby_tb),
    .par_ser(par_ser_tb),
    .db(db_tb),
    .range(range_tb),
    .reset(reset_tb),
    .os(os_tb),
    .convsta(convsta_tb),
    .convstb(convstb_tb)
  );

  initial begin // Behavioral level, there are two types of blocks at this level: initial and 
    // always. Inside these blocks, the instructions are executed sequentially.
    $dumpfile("tb.vcd"); // $dumpfile - should be given at the beginning to
    // monitor the state of the variables from beginning.
    $dumpvars;
    // set all vars to fulfill initial conditions, if is set 
    // configuration_Flag in our model should be = 1
    refsel_tb = 1;
    stby_tb = 1;
    par_ser_tb = 1;
    db_bus_ctrl <= 1;
    range_tb = 0;
    reset_tb = 0;
    os_tb[2:0] = 0'b000;
    #10  

    for(i = 0; i < 50; i = i+1)
      begin
        convsta_tb = 1;
        convstb_tb = 1;
        #(`tPH_CN)
        convsta_tb = 0;
        convstb_tb = 0;
        #(`tPL_CN);  
        if(i == 25 || i == 49)	// reset device
          begin
            reset_tb = 1;
            #(`tPH_RST)
            reset_tb = 0;
          end
      end

    #400000 $finish;
  end

  always #50 sys_clk <= ~sys_clk; // generate 20 MHz clock

endmodule
