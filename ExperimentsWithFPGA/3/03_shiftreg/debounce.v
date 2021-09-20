module debounce #(
  parameter N=8
) (
  input wire clk,
  input wire rst,
  input wire d,
  output wire q
);
  reg [N-1:0]stable_time;
  wire sr;
  wire dr;

  reg q_reg;
  assign q = q_reg;
  reg dr_reg;
  assign dr = dr_reg;

  always@(posedge clk or negedge rst)
    if (!rst)
      dr_reg <= 1'b0;
  else
    dr_reg <= d;

  assign sr = (d != dr);

  always@(posedge clk or negedge rst)
    if (!rst)
      stable_time <= 0;
  else if (sr)
    stable_time <= 0;
  else
    stable_time <= stable_time + 1;

  always@(posedge clk or negedge rst)
    if (!rst)
      q_reg <= 0;
  else if (stable_time[N-1])
    q_reg <= dr;
endmodule
