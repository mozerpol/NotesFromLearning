module ALU_1_bit(
  input a,
  input b, 
  input [1:0] operation, // We have four possible operations, so we need two bits,
  						 // 2^2 = 4. 4 = four operations
  output reg result
);

  always@(a or b or operation) // @ - this is event control.
    begin
      case (operation)
        2'b00:  result = a & b; // AND
        2'b01:  result = a | b; // OR
        2'b10:  result = a + b; // ADD
        2'b11:  result = a - b; // SUB
      endcase
    end
endmodule 
