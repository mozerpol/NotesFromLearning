module testbench;
  
  `define JEDEN 1'b1
  
  reg switch = `JEDEN;
  
  initial begin 
    $display("%d", switch);
  end 
  
endmodule
