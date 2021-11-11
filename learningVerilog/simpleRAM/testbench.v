`timescale 100ns/100ns

module simpleRAM_tb;

   reg clk = 1'b1;
   reg we, re;
   wire data;

   initial begin
   end

   always #10 clk = ~clk;

endmodule
