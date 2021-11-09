module tff_tb();

   reg clk = 1'b1;
   reg t;
   wire q;

   tff dut(clk, t, q);

   initial begin
      #10 t = 1'b0;
      #40 t = 1'b1;
      #40 t = 1'b0;
      #40 t = 1'b1;
      #5 t = 1'b0;
      #5 t = 1'b1;
      #40 $stop;
   end

   always #10 clk <= ~clk;

endmodule
