module ALU_1_bit_tb;
  
  integer i;
  integer j;
  reg a_tb, b_tb;
  reg [1:0] operation_tb;
  wire result_tb;
  
  ALU_1_bit UUT(
    .a(a_tb),
    .b(b_tb),
    .operation(operation_tb),
    .result(result_tb)
  );
  
  initial
    begin
      $dumpfile("tb.vcd");
      $dumpvars;
      $monitor("[%0t] opcode = %00b | A = %00b | B = %00b | Result = %00b |", $time, operation_tb, a_tb, b_tb, result_tb);
      
      a_tb = 0;
      b_tb = 0;
      operation_tb = 2'b00;
      
      for(i = 1; i <= 4; i = i+1)
        begin         
          for(j = 0; j <= 4; j = j+1)
            begin
              #5 operation_tb = j;
            end
          a_tb = 1^a_tb;
          b_tb = i>>1&1;
        end
    end
  
endmodule
