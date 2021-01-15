/* This code was created in order to pass the laboratory at my univeristy. We got datasheet ADS8588H device and
based on waveforms from this datasheet I wrote this code. ADS8588H is 16-bit ADC. */
`timescale 1ns/1ns // `timescale <unit of time>/<precision> 

module ADS8588H(
  input wire refsel,
  output reg busy,
  output wire rstdata,
  input wire stby,
  input wire convsta,
  input wire convstb,
  input wire reset,
  input wire range,
  input wire cs,
  input wire rd_sclk,
  input wire par_ser,
  inout wire [15:0] db, // inout - is bidirectional port
  output wire douta,
  output wire doutb,
  input wire [2:0] os
);

  wire internal_clock;				// freq divider, using for sampling freq 100 kHz clock
  reg[99:0] counter = 100'd0;		// freq divider, counter variable, for 100 kHz clock
  parameter DIVISOR = 100'd100;		// freq divider, prescale factor, for 100 kHz clock
  reg configuration_Flag = 1'b0; 	// 0 - any setup condition are not fulfill
  wire convstAB;					// in serial mode convstA/B should be connected, auxiliary variable
  reg start_timer = 1'b0;			// using in timer for busy signal
  reg[19:0] counter_for_busy = 20'd0;	// using in timer for busy signal
  reg rst_flag = 1'b0;
  reg[19:0] counter_for_reset = 20'd0;	// using in timer for busy signal

  and(convstAB, convsta, convstb); // It's gate level, gate_name(output,input,input);

  /* frequency divider, 100 kHz */
  always @(posedge rd_sclk)
    begin
      counter <= counter + 1; 	// increment counter
      if(counter >= (DIVISOR-1)) // if counter is equal prescale factor, reset counter
        counter <= 0;
    end
  // If we see "assign" it means, that it's register level
  // (condition) ? conditionFulfilled : conditionNotFulfilled ;
  assign clock_for_sampl = (counter<DIVISOR/2) ? 1'b0 : 1'b1;	// setting duty cycle, DIVISOR/2 means 50/50

  /* check setup conditions */
  always @(posedge rd_sclk)
    begin	// if conditions are set, change configuration_Flag
      if(refsel & stby & par_ser & db[15] & ~range & ~rst_flag & ~os[2:0]) 
        configuration_Flag = 1'b1;
      else configuration_Flag = 1'b0;
    end

  /* set timer for busy out, when conversion starts */
  always @(posedge convstAB) start_timer = (configuration_Flag) ? 1 : 0;
  // (condition) ? conditionFulfilled : conditionNotFulfilled ;

  /* when timer is on, set busy in high up to 1200 ns */
  always @(posedge rd_sclk)
    begin
      if(start_timer) 
        begin
          busy = 1;
          counter_for_busy <= counter_for_busy + 1;		// increment cnt
          if(counter_for_busy == 12) start_timer = 0; 	// count to 12, one clk is eq 100 ns, so 12 is eq 1200 ns
        end
      else 
        begin
          counter_for_busy = 0;	// if start_timer is off, reset cnt
          busy = 0;				// if start_timer is off, reset busy
        end
    end

  /* after falling edge on reset, set rst_flag */
  always @(negedge reset) rst_flag = 1;

  /* when rst_flag is on, run timer, when timer is overflow, reset rst_flag */
  always @(posedge rd_sclk)
    begin
      if(rst_flag)
        begin
          counter_for_reset <= counter_for_reset + 1;
          if(counter_for_reset == 8) rst_flag = 0;          
        end
      else counter_for_reset = 0;
    end

endmodule
