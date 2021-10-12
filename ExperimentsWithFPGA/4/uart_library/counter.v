module counter #(
  parameter N = 10,
  parameter W = 8;
)(
  input wire clk,
  input wire rst,
  input wire ce,
  output wire [W-1:0]q,
  output wire ov
);

  reg [W-1:0]q_reg;
  reg ov_reg;
  
  assign q = q_reg;
  assign ov = ov_reg;
  
  // Counter implementation
  always@(posedge clk or negedge rst)
    begin
      if(!rst) q_reg <= 0;
      else if(ce)
        if(ov_reg) q_reg <= 0;
      else
        q_reg <= q_reg + 1'b1;
    end

  // Detect overlofw
  always@(posedge clk or negedge rst)
    begin
      if(!rst) ov_reg <= 0;
      else if(ce)
        if(ov_reg) ov_reg <= 1'b0;
      else
        ov_reg <= (q_reg == N-2); // Check if is overflow
    end
endmodule
