module tff(
   input wire clk,
   input wire t,
   output wire q
);
   
   reg q_reg = 1'b0;
   assign q = q_reg;
   
   always@(posedge clk) begin
      if(t) q_reg <= ~q_reg;
      else q_reg <= q_reg;
   end

endmodule
