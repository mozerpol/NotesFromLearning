`timescale 100ns/100ns

module jkff_tb();

   reg clk = 1'b1;
   reg j, k;
   wire q;

   jkff uut(); 

   initial begin
      #100 $stop;
   end


   always #10 clk <= ~clk;

endmodule
