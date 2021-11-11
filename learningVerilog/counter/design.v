`define RESET 2'b00
`define COUNT 2'b01
`define WAIT  2'b10

module counter #(
   parameter N = 10
)(
   input wire clk,
   input wire rst,
   input wire ce,
   output wire ov
);
   reg [N-1:0] cnt_value = {N{1'b0}};
   reg [N-1:0] cnt_value_max = {N{1'b1}}; // Count up to this value
   reg ov_reg;
   assign ov = ov_reg;
   reg [1:0] state;

   assign state = rst ? `RESET : 
                  ce  ? `COUNT : `WAIT;

   always@(posedge clk) begin
      case(state)
         `RESET: cnt_value <= 0; 
         `COUNT: cnt_value <= cnt_value + 1'b1;
         `WAIT:  cnt_value <= cnt_value;
      endcase
   end

   always@(posedge clk) begin
      if(cnt_value == cnt_value_max) begin // When counted to max, then:
         ov_reg <= 1'b1; // Overflow output to high state for one clk
         cnt_value <= 0; // Reset counter
      end else ov_reg <= 1'b0;
   end

endmodule
