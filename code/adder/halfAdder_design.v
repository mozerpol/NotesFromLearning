module halfAdder(
  input wire A,
  input wire B,
  output wire C,
  output wire S
);
  
  xor(S, A, B);
  and(C, A, B);
  
  assign S = A ^ B; // bitwise xor
  assign C = A & B; // bitwise and
  
endmodule
