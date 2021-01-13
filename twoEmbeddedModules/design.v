module comb_simple(a1_i, a2_i, a3_o);
  
  input a1_i, a2_i;
  output a3_o;
  wire tmp;
  not N1(tmp, a2_i);
  and A1(a3_o, a1_i, tmp);
  
endmodule

module comb_complex(b1_i, b2_i, b3_i, b4_o);
  
  input b1_i, b2_i, b3_i;
  output b4_o;
  wire internal_wire;
  comb_simple M1(b1_i, b2_i, internal_wire);
  comb_simple M2(internal_wire, b3_i, b4_o);
  
endmodule
