module serial_adder(   
  input clk,
  input in_A, in_B,
  output reg out
);

  reg cin = 0, cout = 0;

  always@(posedge clk)
    begin
      // (condition) ? conditionFulfilled : conditionNotFulfilled ;
      if(in_A & in_B) cout = 1;
      else cin = 0;
      if(cout) cin = 1;
      else cout = 0;
      out = in_A ^ in_B ^ cin;
      //   cout = (in_A & in_B) | (cin & in_B) | (in_A & cin); 
    end 

endmodule 
