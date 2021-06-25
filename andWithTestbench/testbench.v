module gate_tb(); // it's good to add "_tb"
  
  reg in1_tb; // must be reg type
  reg in2_tb;
  wire out1_tb; // must be wire, because it's output port
  /* There are two methods of connecting the pins of the instance with external signals:
  1. Connecting by order, as it occurs in the module definition
  2. Connecting by name which is shown below */
  gate UUT( // UUT is an instance of the gate module
    .in1(in1_tb),
    .in2(in2_tb),
    .out1(out1_tb)
  );
  
  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;
    $display("\t\t time | in1 | in2 | out");
    $monitor($time, "  |  %d  |  %d  |  %d ", in1_tb, in2_tb, out1_tb);
    
   	in1_tb = 0;
	in2_tb = 0;
	#1 in1_tb = 0; // This is a 1 second delay from the previous instruction. W blokach
    // In initial blocks, instructions are executed one after the other, so if we give 
    // a 1 second delay here, the next instruction may already be without it
	in2_tb = 1;
    #1 in1_tb = 1'b1;
  	in2_tb = 1'b0;
    #1 in1_tb = 1;
  	in2_tb = 1; 
	#1 $finish;
	
  end
endmodule
