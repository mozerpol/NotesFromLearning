`timescale 100ns/100ns

module counter_tb;

   reg clk = 1'b1;
   reg rst, ce;
   wire ov;
   
   counter #(
      .N(10)
   ) uut(
      clk, rst, ce, ov
   );

endmodule
