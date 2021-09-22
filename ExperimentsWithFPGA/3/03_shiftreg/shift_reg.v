module shift_reg #(
  parameter N = 8
) (
  input wire clk,
  input wire rst,
  input wire ce,
  input wire d,
  output wire [N-1:0]q
);
  
  reg [N-1:0]q_reg;
  assign q = q_reg;
  integer i;

  always@(posedge clk or negedge rst)
    if (!rst)
      q_reg <= 0;
  else if(ce)
    begin
      q_reg[0] <= d;
      for (i = 1; i < N; i=i+1)
        q_reg[i] <= q_reg[i-1];
    end
endmodule
