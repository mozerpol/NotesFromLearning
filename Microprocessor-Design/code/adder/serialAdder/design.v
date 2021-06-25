module serial_adder(// after keyword "module" is its name and portlist, thanks to 
// which you can communicate with the environment.   
  input clk,
  input in_A, in_B,
  output out
);

  reg flag = 0; // internal variable declaration
  reg out = 0;

  always@(posedge clk)
    begin
      if(!flag) flag = 1;
      else out = (!(in_A & in_B)) ? 1 : in_A ^ in_B;
    end 
endmodule 
