module gate_tb(); 
  
  reg in1_tb; 
  reg in2_tb;
  wire out1_tb; 
  
  

  gate UUT( 
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
	#1 in1_tb = 0; 
	in2_tb = 1;
    #1 in1_tb = 1'b1;
  	in2_tb = 1'b0;
    #1 in1_tb = 1;
  	in2_tb = 1; 
    
	#1 $finish;
    
  end
  
endmodule
