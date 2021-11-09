module srff(
   input wire clk,
   input wire s,
   input wire r,
   output wire q
);

   reg q_reg;
   assign q = q_reg;

   always@(posedge clk) begin
      case({s,r})
         2'b00: q_reg <= q_reg; 
         2'b01: q_reg <= 1'b0;
         2'b10: q_reg <= 1'b1;
         2'b11: q_reg <= 1'bx;
      endcase
   end

endmodule
