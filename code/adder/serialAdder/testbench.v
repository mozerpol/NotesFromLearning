module serial_adder_tb();
  
  reg clk_tb;
  reg in_A_tb;
  reg in_B_tb;

  serial_adder UUT(
    .clk(clk_tb), 
    .in_A(in_A_tb), 
    .in_B(in_B_tb)
  );

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars;

    clk_tb = 1;
    in_A_tb = 0; in_B_tb = 0;
    #10 in_A_tb = 0; in_B_tb = 1;
    #10 in_A_tb = 1; in_B_tb = 0;
    #10 in_A_tb = 1; in_B_tb = 1;
	#10 in_A_tb = 0; in_B_tb = 0;
    #20 $finish;
  end

  always #5 clk_tb = ~clk_tb;

endmodule
