`timescale 100ns/100ns

module simpleRAM_tb;

   reg clk = 1'b1;
   reg we, re;
   wire [7:0] data;
   reg [7:0] data_reg;
   assign data = data_reg;

   simpleRAM #(
      .wordSize(8),
      .addressSize(32)
   ) uut (
      clk, we, re, addr, data
   );

   initial begin
      we = 1'b1;
      #10 data_reg = 8'h1;
      #20 data_reg = 8'h2;

      #100 $stop;
   end

   always #10 clk <= ~clk;

endmodule
