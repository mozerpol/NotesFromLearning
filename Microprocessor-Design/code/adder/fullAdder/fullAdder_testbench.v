module fullAdder_tb;// if it's testbech it is worth adding "_tb"
  // variable declaration, which are using in our testbench
  
  integer i; // For loop purposes 
  reg A_tb, B_tb, Cin_tb;
  wire S_tb, Cout_tb;
  
  fullAdder UUT(
    .A(A_tb),
    .B(B_tb),
    .Cin(Cin_tb),
    .S(S_tb),
    .Cout(Cout_tb)
  );
  
  initial
    begin
      $dumpfile("tb.vcd");
      $dumpvars;
      
      A_tb = 0;
      B_tb = 0;
      Cin_tb = 0;
      
      for(i = 1; i < 9; i = i+1)
        begin
          #5
          A_tb = 1^A_tb; // A_tb = 0101010101...
          B_tb = i>>1&1; // B_tb = 001100110011...
          Cin_tb = i>>2&1; // Cin_tb = 000011110000...
        end
    end
endmodule
