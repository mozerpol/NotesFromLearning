`timescale 100ns/100ns

`define ADDRESSSIZE 32 

module simpleRAM_tb;

   reg clk = 1'b1;
   reg we, re;
   wire [7:0] data;
   reg [7:0] data_reg;
   assign data = data_reg;
   integer i = 0;
   reg [4:0] addr;

   simpleRAM #(
      .wordSize(8),
      .addressSize(`ADDRESSSIZE)
   ) uut (
      clk, we, re, addr, data
   );

   initial begin
      #10 we = 1'b1;

      for(i = 0; i < (`ADDRESSSIZE-1); i = i+1) begin
         #10 addr = i;
         data_reg = 8'h1;
      end

      #100 $stop;
   end

   always #5 clk <= ~clk;

endmodule
