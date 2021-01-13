module comb_complex_tb();
  
  reg b1_i_tb;
  reg b2_i_tb;
  reg b3_i_tb;
  wire b4_o_tb;
  
  comb_complex UUT1(
    .b1_i(b1_i_tb),
    .b2_i(b2_i_tb),
    .b3_i(b3_i_tb),
    .b4_o(b4_o_tb)
  );
  
  initial begin
   	$dumpfile("tb.vcd"); 
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
    
  end
  
endmodule






