// Below function is very nice, thanks to this we'll calculate the width of "q"
// on the fly. Example, if parameter "N" will be equal 10, then the width of "q"
// will be equal 4, but if "N" will be equal 3, then "q" will be equal 2.
function integer clog2;
  input integer value;
  begin
    value = value-1;
    for(clog2=0; value>0; clog2=clog2+1)
      value = value>>1;
  end
endfunction

module counter #(
  parameter N = 10,
  parameter W = clog2(N)
)(
  input wire clk,
  input wire rst,
  input wire ce,
  output wire [W-1:0]q,
  output wire ov // Overflow, 
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
        if(ov) q_reg <= 0;
      else
        q_reg <= q_reg + 1'b1;
    end

  // Detect overlofw
  always@(posedge clk or negedge rst)
    begin
      if(!rst) ov_reg <= 0;
      else if(ce)
        if(ov) ov_reg <= 1'b0;
      else
        ov_reg <= (q_reg == N-2); // Check if is overflow
    end
endmodule
