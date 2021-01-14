module and_area( 
  input wire in1,
  input wire in2,
  output wire out1_and
);
  
  assign out1_and = in1 & in2;
  // and(out1_and, in1, in2); 
endmodule

module gates_area(
  input wire in1,
  input wire in2,
  input wire in3,
  output wire out_or
);
  
  wire internal_wire;
  
  and_area A1(in1, in2, internal_wire);
  or(out_or, in3, internal_wire);
endmodule
