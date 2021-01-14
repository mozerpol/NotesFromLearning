module gates_area_tb();

  reg in1_tb = 1;
  reg in2_tb = 0;
  reg in3_tb = 0;
  wire out_tb;
  
  gates_area UUT1(
    .in1(in1_tb),
    .in2(in2_tb),
    .in3(in3_tb),
    .out_or(out_tb)
  );
  
  integer i = 0;

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;
    $display("\t\t time | in1 | in2 | in3 | out");
    
    for(i=0; i<=7; i=i+1)
      begin
        #1       
        in1_tb = 1^in1_tb;
        in2_tb = i>>1&1;
        in3_tb = i>>2&1;
        $monitor($time, "  |  %d  |  %d  |  %d  |  %d", in1_tb, in2_tb, in3_tb, out_tb);
      end
  end
      
endmodule
