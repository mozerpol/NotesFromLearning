`timescale 100ns/100ns

module counter_tb;

   reg clk = 1'b1;
   reg rst, ce;
   wire ov;
   
   counter #(
      .N(3)
   ) uut(
      clk, rst, ce, ov
   );

   initial begin
      // rst = 0, ce = 0
      #10 rst = 1'b0; ce = 1'b0;
      // rst = 0, ce = 1
      #100 rst = 1'b0; ce = 1'b1; 
      // rst = 1, ce = 0
      #100 rst = 1'b1; ce = 1'b0; 
      // rst = 1, ce = 1
      #100 rst = 1'b1; ce = 1'b1; 
      // rst = 0, ce = 1
      #100 rst = 1'b0; ce = 1'b1; 
      #21 rst = 1'b1;
      #33 rst = 1'b0;

      #400 $stop; 
   end

   always #5 clk <= ~clk;

endmodule
