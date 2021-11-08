module dff(
   input wire clk,
   input wire d,
   output wire q
);

   reg q_reg;
   assign q = q_reg;

   always@(posedge clk)
   begin
      q_reg <= d;
   end

endmodule
