module tff_tb();

   reg clk = 1'b1;
   reg t;
   wire q;

   tff dut(clk, t, q);

   initial begin
      #20 $stop;
   end

   always #10 clk <= ~clk;

endmodule
