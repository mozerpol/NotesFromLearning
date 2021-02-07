module serial_adder(  
  input clk,
  input in_A, in_B,
  output out
);

  reg flag = 0;
  reg out = 0;

  always@(posedge clk)
    begin
      if(!flag) flag = 1;
      else out = (!(in_A & in_B)) ? 1 : in_A ^ in_B;
    end 
endmodule 
