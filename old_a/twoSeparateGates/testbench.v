module gates_area_tb(); // It's good to add "_tb"

  reg in1_tb; // Must be reg type, because in our model b1_i is wire type
  reg in2_tb;
  reg in3_tb;
  wire out_tb; // Must be wire, because it's output port
  
  gates_area UUT1( // UUT is an instance of the gate module. UUT - unit under test
    .in1(in1_tb),  // Binding vars from test with vars from model
    .in2(in2_tb),
    .in3(in3_tb),
    .out_or(out_tb)
  );

  initial begin // Behavioral level, there are two types of blocks at this level: initial and 
  // always. Inside these blocks, the instructions are executed sequentially.
    $dumpfile("tb.vcd"); 
    $dumpvars;
    $display("\t\t time | in1 | in2 | in3 | out");
    $monitor($time, "  |  %d  |  %d  |  %d  |  %d", in1_tb, in2_tb, in3_tb, out_tb);
    // %d will print the variable in decimal,
    // %4b will print the varilable in binary - that has width of 4,
    // %h will print the variable in hexadecimal.
    
    in1_tb = 0;
    in2_tb = 0;
    in3_tb = 0;
    #1
    in1_tb = 0;
    in2_tb = 1;
    in3_tb = 1;
    #1
    in1_tb = 1;
    in2_tb = 0;
    in3_tb = 0;
	#1
    in1_tb = 1;
    in2_tb = 1;
    in3_tb = 1;
    // In this case we aren't add $finish command ($finish ends simulation,
    // dumpfile operation and variable monitoring), because we don't have
    // infinite loop. In this testbench the code will run sequentially.
  end
endmodule








