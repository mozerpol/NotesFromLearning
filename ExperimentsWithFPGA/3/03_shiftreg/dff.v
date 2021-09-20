module dff(
  input wire d,
  input wire clk,
  output wire q,
  output wire neg_q
);
  
  wire internalWireD;
  wire internalWireC;
  
  nand(internalWireD, d, clk);
  nand(internalWireC, internalWireD, clk);
  nand(q, neg_q, internalWireD);
  nand(neg_q, q, internalWireC);
  
endmodule
