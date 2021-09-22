module edge_detector (
  input wire clk,
  input wire rst,
  input wire d,
  output wire q
);
  reg dr;
  reg q_reg;
  assign q = q_reg;

  always@(posedge clk or negedge rst)
    begin
      if (!rst) 
        begin
          dr <= 0;
          q_reg <= 0;
        end 
      else 
        begin
          dr <= d;
          q_reg <= d & ~dr;
        end
    end
endmodule
