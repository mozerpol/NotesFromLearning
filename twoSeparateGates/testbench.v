module gates_area_tb();

  reg in1_tb;
  reg in2_tb;
  reg in3_tb;
  wire out_tb;
  
  gates_area UUT1(
    .in1(in1_tb),
    .in2(in2_tb),
    .in3(in3_tb),
    .out_or(out_tb)
  );

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;
    $display("\t\t time | in1 | in2 | in3 | out");
    $monitor($time, "  |  %d  |  %d  |  %d  |  %d", in1_tb, in2_tb, in3_tb, out_tb);
    
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
  end
endmodule








