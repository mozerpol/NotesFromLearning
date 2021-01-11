module test();

wire out1;
reg in1, in2; 
  nand U1(out1, in1, in2);

initial begin 
  $dumpfile("tb.vcd"); 
  $dumpvars;
	$monitor("wejscie1 = %b wejscie2 = %b wyjscie = %b", in1, in2, out1);
	in1 = 0;
	in2 = 0;
	#1 in1 = 1;
	in2 = 1;
	#1 in1 = 0; 
  	#2 in1 = 1;
  	in2 = 0;
	#10 $finish;
end

endmodule

