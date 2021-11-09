module srff_tb();

   reg clk = 1'b1;
   reg s, r;
   wire q;

   srff dut(clk, s, r, q);

   initial begin
      #40 $stop;
   end

endmodule
