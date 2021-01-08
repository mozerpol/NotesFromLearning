module program_counter_tb;

  reg clk_tb;
  reg reset_tb;
  wire [3:0] cnt_tb;

  program_counter UUT(
    .clk(clk_tb),
    .reset(reset_tb),
    .cnt(cnt_tb)
  );

  initial
    begin
      $dumpfile("tb.vcd"); 
      $dumpvars;

      clk_tb = 0;
      reset_tb = 1;
      #10 reset_tb = 0;
      #75 $finish;
    end
  always #1 clk_tb <= ~clk_tb;

endmodule
