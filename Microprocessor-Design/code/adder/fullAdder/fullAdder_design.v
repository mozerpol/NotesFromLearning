module fullAdder(
  input wire A,
  input wire B,
  input wire Cin,
  output wire S,
  output wire Cout
);
  
  /*
  // This part is diffrent way for creating full adder using gates
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

/*
he truth table for mux looks like:
| A | B | Cin |Cout | S |
-------------------------
| 0 | 0 |  0  |  0  | 0 |
| 0 | 1 |  0  |  0  | 1 |
| 1 | 0 |  0  |  0  | 1 |
| 1 | 1 |  0  |  1  | 0 |
| 0 | 0 |  1  |  0  | 1 |
| 0 | 1 |  1  |  1  | 0 |
| 1 | 0 |  1  |  1  | 0 |
| 1 | 1 |  1  |  1  | 1 |
*/
