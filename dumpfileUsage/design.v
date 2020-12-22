module testbench;
  
  reg switch = 1'b1;
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #100 switch = 1'b0; 
    #110 $finish; 
  end
 
