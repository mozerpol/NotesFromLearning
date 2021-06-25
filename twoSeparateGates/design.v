module and_area( // after keyword "module" is its name and portlist
  input wire in1,
  input wire in2,
  output wire out1_and
);
  
  // If we see "assign" it means, that it's register level
  assign out1_and = in1 & in2;
  // and(out1_and, in1, in2); // If we see gates, it means that it's gate level.
endmodule

module gates_area(
  input wire in1,
  input wire in2,
  input wire in3,
  output wire out_or
);
  
  wire internal_wire; // Variable for our internal purposes
  
  and_area A1(in1, in2, internal_wire);
  or(out_or, in3, internal_wire); // It's gate level
endmodule







