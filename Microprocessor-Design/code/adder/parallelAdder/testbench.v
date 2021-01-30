module fullAdder_tb;// if it's testbech it is worth adding "_tb"
  // variable declaration, which are using in our testbench
  reg A_1_tb, B_1_tb, Cin_tb; // reg - registers, it's used for modeling of memory elements.
  reg A_2_tb, B_2_tb;
  reg A_3_tb, B_3_tb;
  reg A_4_tb, B_4_tb;

  parallelAdder UUT( // Unit Under Test, binding vars from test with model
    .A_1(A_1_tb),
    .B_1(B_1_tb),
    .A_2(A_2_tb),
    .B_2(B_2_tb),
    .A_3(A_3_tb),
    .B_3(B_3_tb),
    .A_4(A_4_tb),
    .B_4(B_4_tb),
    .Cin(Cin_tb)
  );

  initial begin // Behavioral level, there are two types of blocks at this level: initial and always. 
    //Inside these blocks, the instructions are executed sequentially.
      $dumpfile("tb.vcd");
      $dumpvars;

      A_1_tb = 0; B_1_tb = 0; Cin_tb = 0;
      A_2_tb = 0; B_2_tb = 0;
      A_3_tb = 0; B_3_tb = 0; 
      A_4_tb = 0; B_4_tb = 0;
      #10
      A_1_tb = 0; B_1_tb = 1; Cin_tb = 0;
      A_2_tb = 0; B_2_tb = 1;
      A_3_tb = 0; B_3_tb = 1;
      A_4_tb = 0; B_4_tb = 1;
      #10
      A_1_tb = 1; B_1_tb = 0; Cin_tb = 0;
      A_2_tb = 1; B_2_tb = 0;
      A_3_tb = 1; B_3_tb = 0;
      A_4_tb = 1; B_4_tb = 0;
      #10
      A_1_tb = 1; B_1_tb = 1; Cin_tb = 0;
      A_2_tb = 1; B_2_tb = 1;
      A_3_tb = 1; B_3_tb = 1;
      A_4_tb = 1; B_4_tb = 1;
      #10
      A_1_tb = 0; B_1_tb = 0; Cin_tb = 1;   
      A_2_tb = 0; B_2_tb = 0;
      A_3_tb = 0; B_3_tb = 0;
      A_4_tb = 0; B_4_tb = 0;
      #10
      A_1_tb = 0; B_1_tb = 1; Cin_tb = 1;    
      A_2_tb = 0; B_2_tb = 1;
      A_3_tb = 0; B_3_tb = 1;
      A_4_tb = 0; B_4_tb = 1;
      #10
      A_1_tb = 1; B_1_tb = 0; Cin_tb = 1;   
      A_2_tb = 1; B_2_tb = 0;
      A_3_tb = 1; B_3_tb = 0;
      A_4_tb = 1; B_4_tb = 0;
      #10
      A_1_tb = 1; B_1_tb = 1; Cin_tb = 1;   
      A_2_tb = 1; B_2_tb = 1;
      A_3_tb = 1; B_3_tb = 1;
      A_4_tb = 1; B_4_tb = 1;
      #10 $finish;
    end // begin, end - grouping commands, something like braces in C.

endmodule
