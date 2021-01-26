module halfAdder(
  // after 'module' keyword we have name of our module and and ports list. 
  input wire A, // A - it's first input
  input wire B, // B - it's second input
  output wire C, // C like carry
  output wire S // S like sum
);
  
  // It's first way to create half adder, it's the lowest way in verilog, using gates.
  xor(S, A, B); // xor(output, input1, input2)
  and(C, A, B); // and(output, input1, input2)
  
  assign S = A ^ B; // bitwise xor
  assign C = A & B; // bitwise and
  
endmodule

/*
he truth table for mux looks like:
| A | B | C | S |
-----------------
| 0 | 0 | 0 | 0 |
| 0 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 0 |
*/
