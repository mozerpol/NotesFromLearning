module testbench;
  
  reg [8*12:1] napis; 
    
  initial begin
	napis = "ala ma \nkota";
    $display("%s", napis);
  end
  
endmodule
