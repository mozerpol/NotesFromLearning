module fullAdder(
  input wire A,
  input wire B,
  input wire Cin,
  output wire S,
  output wire Cout
);
  
  /*
  wire xor1_out;
  wire and1_out;
  wire and2_out;
  
  xor(xor1_out, A, B);
  xor(S, xor1_out, Cin);
  and(and1_out, xor1_out, Cin);
  and(and2_out, A, B);
  or(Cout, and1_out, and2_out);
  */
  
  assign {Cout, S} = A + B + Cin;  
  
endmodule
