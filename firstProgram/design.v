module test();

wire out1; // wire - network of connections between components in a digital circuit.
// They are 1-bit wide and default value is "z". If we don't define type, then default
// will be wire.
reg in1, in2; // reg - registers, it's used for modeling of memory elements.
  nand U1(out1, in1, in2); // The outputs are as the first argument. U1 - name of gate.

initial begin // Behavioral level, there are two types of blocks at this level: initial and 
  // always. Inside these blocks, the instructions are executed sequentially.
  $dumpfile("tb.vcd"); 
  $dumpvars;
	$monitor("input1 = %b input2 = %b output = %b", in1, in2, out1);
	in1 = 0;
	in2 = 0;
	#1 in1 = 1; // 1 sec delay from previous instruction. It's possible because 
	// the instructions in the initial block are executed sequentially, one after the other.
	in2 = 1;
	#1 in1 = 0; 
  	#2 in1 = 1;
  	in2 = 0;
	#10 $finish; // $ - from this system commands begin. finish - it stop simpulation
end // begin, end - grouping commands, something like braces in C.

endmodule




