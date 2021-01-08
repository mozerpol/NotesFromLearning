module program_counter(
  input clk, // the clock
  input reset, // it resets the counter synchronously
  output reg [3:0] cnt // the output of the counter
);
  
  always @(posedge clk)
    if (!reset)
      cnt = cnt + 1;
  else
    cnt = 0;

endmodule

