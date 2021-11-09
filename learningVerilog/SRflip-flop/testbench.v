`timescale 100ns/100ns

module srff_tb();

   reg clk = 1'b1;
   reg s, r;
   wire q;

   srff dut(clk, s, r, q);

   initial begin
      #10 s = 1'b1; r = 1'b0;
      #20 s = 1'b0; r = 1'b1;
      #20 s = 1'b0; r = 1'b0;
      #20 s = 1'b1; r = 1'b1;
      #40 $stop;
   end

   always #10 clk <= ~clk;

endmodule
