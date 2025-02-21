/* The working is so easy, we can change state only when rising clk edge, we
* have a few cases, when: 
* 1. j = 0; k = 0; - no change
* 2. j = 0; k = 1; - q = 0
* 3. j = 1; k = 0; - q = 1
* 4. j = 1; k = 1; - change state
*/
module jkff(
   input wire clk,
   input wire j,
   input wire k,
   output wire q
);

   reg q_reg;
   assign q = q_reg;

   always@(posedge clk) begin
      case({j,k})
         2'b00: q_reg <= q_reg;
         2'b01: q_reg <= 1'b0; 
         2'b10: q_reg <= 1'b1;
         2'b11: q_reg <= ~q_reg;
      endcase
   end

endmodule
