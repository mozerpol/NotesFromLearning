module comb_simple( // after keyword "module" is its name and portlist, thanks to 
// which you can communicate with the environment. If we don't define type, then
// default will be wire.
    a1_i, 
    a2_i, 
    a3_o
);
  input a1_i, a2_i; // If we don't define type, then default will be wire.
  output a3_o;
  wire tmp;
  not N1(tmp, a2_i); // The outputs are as the first argument. N1 - name of gate.
  and A1(a3_o, a1_i, tmp);
  // Different way for this exercise, it's register level
  // assign a3_o = a1_i & ~a2_i;
endmodule

module comb_complex(b1_i, b2_i, b3_i, b4_o);
  
  input b1_i, b2_i, b3_i;
  output b4_o;
  wire internal_wire;
  comb_simple M1(b1_i, b2_i, internal_wire);
  comb_simple M2(internal_wire, b3_i, b4_o);
  
endmodule

/*
The action of this is easy:
We have exactly two the same modules: comb_simple, which are located inside the
larger one, comb_complex. comb_simple has two inputs (a1_i and a2_i) and two
gates connected in series: and, not. The output of first comb_simple go to input
second comb_simple.
*/





