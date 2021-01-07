module fullAdder_tb;
  
  integer i;
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
          A_tb = 1^A_tb;
          B_tb = i>>1&1;
          Cin_tb = i>>2&1;
        end
      
    end
  
endmodule
