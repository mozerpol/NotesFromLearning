// If you know how parallel adder works, this code will be easy ;p
// Ripple-Carry adder is several full adders connected in serial in this case
// we have four full adders
module RippleCarryAdder(
  // after 'module' keyword we have name of our module and and ports list. 
  input wire A_1, // If inputs in our model are wire type, then variables in testbench should be reg type
  input wire B_1,
  input wire A_2,
  input wire B_2,
  input wire A_3,
  input wire B_3,
  input wire A_4,
  input wire B_4,
  input wire Cin,
  output wire Cout, // If we want connect output from our model, then variables in testbench should be wire type
  output wire Sum_1,
  output wire Sum_2,
  output wire Sum_3,
  output wire Sum_4
);

  // variables for internal purposes
  wire Cout1_2, Cout2_3, Cout3_4; 
  wire Cin1_2, Cin2_3;

  fullAdder FIRST(A_1, B_1, Sum_1, Cin, Cout1_2);
  fullAdder SECOND(A_2, B_2, Sum_2, Cout1_2, Cin2_3);
  fullAdder THIRD(A_3, B_3, Sum_3, Cin2_3, Cout3_4);
  fullAdder FOURTH(A_4, B_4, Sum_4, Cout3_4, Cout);

endmodule

module fullAdder(
  input A, 
  input B, 
  output Sum, 
  output Cin, 
  output Cout
);

  assign Sum = (A ^ B) ^ Cin;
  assign Cout = (Cin & (A ^ B)) | (A & B); 

endmodule

/*
he truth table for one full adder looks like:
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
