module programmable_gate(
  input wire a,
  input wire b,
  input wire f0,
  input wire f1,
  output wire y
);
  
  wire b1y, b2y, b3y, b4y;
  wire b5y, b8y, b10y, b13y, b15y;
  wire b6y, b7y, b9y, b11y, b12y, b14y;
  
  not(b1y, f1);
  not(b2y, f0);
  not(b3y, a);
  not(b4y, b);
  
  or(b5y, b, a);
  and(b6y, b, a);
  and(b7y, b5y, f0);
  or(b8y, b7y, b6y);
  and(b9y, b8y, b1y);

  or(b10y, b4y, b3y);
  and(b11y, b4y, b3y);
  and(b12y, b10y, b2y);
  or(b13y, b12y, b11y);
  and(b14y, b13y, f1);
  
  or(y, b9y, b14y);
  
endmodule
