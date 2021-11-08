/* The act of D flip-flop is very simple. When we have rising edge on clk then
* it accepts data from d input and rewrite this input to the output.
*/
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
