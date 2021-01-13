module comb_complex_tb(); // it's good to add "_tb"
  
  reg b1_i_tb; // must be reg type, because in our model b1_i is wire type
  reg b2_i_tb;
  reg b3_i_tb;
  wire b4_o_tb; // must be wire, because it's output port
  
  comb_complex UUT1( // UUT is an instance of the gate module. UUT - unit under test
    .b1_i(b1_i_tb),
    .b2_i(b2_i_tb),
    .b3_i(b3_i_tb),
    .b4_o(b4_o_tb)
  );
  
  initial begin
   	$dumpfile("tb.vcd"); // $dumpfile - should be given at the beginning to
    // monitor the state of the variables from beginning.
    $dumpvars;
    $display("\t\t       b1_i | b2_i| b3_i| b4_o");
    $monitor($time, "  |  %d  |  %d  |  %d  |  %d", b1_i_tb, b2_i_tb, b3_i_tb, b4_o_tb);
    
	b1_i_tb = 0;
    b2_i_tb = 0;
    b3_i_tb = 0;
    #1
   	b1_i_tb = 1;
    b2_i_tb = 0;
    b3_i_tb = 0;
    #1
    b1_i_tb = 0;
    b2_i_tb = 1;
    b3_i_tb = 0;
    #1
    b1_i_tb = 0;
    b2_i_tb = 0;
    b3_i_tb = 1;
    #1
    b1_i_tb = 1;
    b2_i_tb = 0;
    b3_i_tb = 1;
    #1
    b1_i_tb = 1;
    b2_i_tb = 1;
    b3_i_tb = 1;
    // In this case we aren't add $finish command ($finish ends simulation,
    // dumpfile operation and variable monitoring), because we don't have
    // infinite loop. In this testbench the code will run sequentially.
  end
  
endmodule






