module halfAdder_tb;
  
  integer i;
  reg A_tb, B_tb;
  wire C_tb, S_tb;
  
  halfAdder UUT(
    .A(A_tb),
    .B(B_tb),
    .C(C_tb),
    .S(S_tb)
  );
  
  initial
    begin
      $dumpfile("tb.vcd");
      $dumpvars;

      A_tb <= $random;
      B_tb <= $random;
      
      for(i = 1; i < 10; i = i+1)
        begin
          #5 
          A_tb <= $random;
          B_tb <= $random;
        end
    end
endmodule
