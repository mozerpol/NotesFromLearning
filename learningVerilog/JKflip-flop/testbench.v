`timescale 100ns/100ns

module jkff_tb();

   reg clk = 1'b1;
   reg j, k;
   wire q;

   jkff uut(clk, j, k, q); 

   initial begin
      #10 j = 1'b0; k = 1'b0;
      #20 j = 1'b1; k = 1'b0;
      #20 j = 1'b0; k = 1'b1;
      #8 j = 1'b0; k = 1'b0;
      #8 j = 1'b1; k = 1'b0;
      #4 j = 1'b1; k = 1'b1;
      #40 j = 1'b0; k = 1'b0;
      #40 $stop;
   end


   always #10 clk <= ~clk;

endmodule
