module gate(
  input wire in1, // See desc at the bottom
  input wire in2,
  output wire out1
);

  and (out1, in1, in2);
  
endmodule
/* The rules to which signals we can connect the ports of the module:
    1. input - it can be wire, but to external module should connect to reg or wire
    2. output - it can be wire or reg, in the external module must be wire.
*/
