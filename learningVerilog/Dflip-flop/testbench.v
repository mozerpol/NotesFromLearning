`timescale 100ns/100ns

module dff_tb();

   reg clk = 1'b1;
   always #10 clk = ~clk;

   initial begin
      #100 $stop;
   end

   dff uut(
      .clk(clk),
      .d(),
      .q()
   );

endmodule
