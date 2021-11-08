`timescale 100ns/100ns

module jkff_tb();

   reg clk = 1'b1;
   reg j, k;
   wire q;

   jkff uut(clk, j, k, q); 

   initial begin
      #10 j = 1'b0; k = 1'b0;
      #15 j = 1'b1; k = 1'b0;
      #20 j = 1'b0; k = 1'b1;
      #25 j = 1'b0; k = 1'b1;
      #20 j = 1'b1; k = 1'b0;
      #20 j = 1'b1; k = 1'b1;
      #20 j = 1'b0; k = 1'b0;
      #25 j = 1'b1; k = 1'b0;
      #10 j = 1'b0; k = 1'b1;
      #15 j = 1'b1; k = 1'b1;
      #20 j = 1'b0; k = 1'b0;
      #30 $stop;
   end


   always #10 clk <= ~clk;

endmodule
