`timescale 100ns/100ns

module dff_tb();

   reg clk = 1'b1;
   wire q;
   reg d;

   initial begin
      #100 $stop;
   end

   dff uut(
      .clk(clk),
      .d(d),
      .q(q)
   );

   always #10 clk = ~clk;

endmodule
