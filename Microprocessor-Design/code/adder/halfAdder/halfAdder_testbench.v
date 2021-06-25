module halfAdder_tb; // if it's testbech it is worth adding "_tb"
  // variable declaration, which are using in our testbench
  integer i;
  reg A_tb, B_tb; // If inputs in our model are wire type, then variables in testbench should be reg type
  wire C_tb, S_tb; // If we want connect output from our model, then variables in testbench should be wire type
  
  halfAdder UUT( // binding vars from test with model
    .A(A_tb),
    .B(B_tb),
    .C(C_tb),
    .S(S_tb)
  );
  
  initial
    begin
      $dumpfile("tb.vcd");
      $dumpvars;

      A_tb <= $random; // Assign random number from 0 to 1 to var
      B_tb <= $random;
      
      for(i = 1; i < 10; i = i+1) // Count up to ten, because will be more possibilities in our waveform
        begin
          #5 
          A_tb <= $random;
          B_tb <= $random;
        end
    end
endmodule
