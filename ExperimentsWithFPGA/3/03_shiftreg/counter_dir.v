module counter_dir #(
  parameter N = 8
) (
  input wire clk,
  input wire rst,
  input wire ce,
  input wire dir,
  output wire [N-1:0]q
);
  
  reg [N-1:0]q_reg;
  assign q = q_reg;

  always@(posedge clk or negedge rst)
    if (!rst)
      q_reg <= {8{1'b0}};
  else if (ce)
    q_reg <= q + ((dir) ? 1'b1 : -1'b1);
endmodule
