module serial_adder_tb(); // it's good to add "_tb"
  
  reg clk_tb; // must be reg type, if it'll be output we must use wire type
  reg in_A_tb; 
  reg in_B_tb; 

  serial_adder UUT( // UUT is an instance of the adder module
    .clk(clk_tb), 
    .in_A(in_A_tb), 
    .in_B(in_B_tb)
  );

  initial begin // begin, end - it's like brackets in C.
    $dumpfile("tb.vcd"); // $dumpfile - should be given at the beginning to
    // monitor the state of the variables from beginning.
    $dumpvars;

    clk_tb = 1;
    in_A_tb = 0; in_B_tb = 0;
    #10 in_A_tb = 0; in_B_tb = 1; // This is a 10 second delay from the previous instruction. 
    #10 in_A_tb = 1; in_B_tb = 0;
    #10 in_A_tb = 1; in_B_tb = 1;
	#10 in_A_tb = 0; in_B_tb = 0;
    #10 $finish; // system tasks begin with the character: $. $finish - ends simulation, dumpfile operation and variable monitoring
  end

  always #5 clk_tb = ~clk_tb;

endmodule
