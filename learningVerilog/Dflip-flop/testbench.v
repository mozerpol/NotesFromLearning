`timescale 100ns/100ns

module dff_tb();

   reg clk = 1'b1;
   wire q;
   reg d;

   initial begin
      #10 d = 1'b1;
      #35 d = 1'b0;
      #40 d = 1'b1;
      #35 d = 1'b0;
      #30 d = 1'b1;
      #5  d = 1'b0;
      #5  d = 1'b1;
      #20 $stop;
   end

   dff uut(
      .clk(clk),
      .d(d),
      .q(q)
   );

   always #10 clk = ~clk;

endmodule
