module gate(
  input wire in1,
  input wire in2,
  output wire out1
);

  and (out1, in1, in2);
  
endmodule
