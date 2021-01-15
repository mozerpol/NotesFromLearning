module programmable_gate_tb();

  reg a, b, f0, f1;
  wire y;
  
  programmable_gate UUT1(
    .a(a),
    .b(b),
    .f0(f0),
    .f1(f1),
    .y(y)
  );
  
  integer i;
  
  initial begin
    
    f1 = 0; 
    f0 = 0;  
    a = 0;
    b = 0;
    $display("\tf1 | f0 |  A |  B | y");
    $monitor("\t %d | %d  | %d  | %d  | %d", f1, f0, a, b, y);
    for(i=1; i <16; i=i+1)
      begin
        #1
        b = 1^b;
        a = i>>1&1;
        f0 = i>>2&1;
        f1 = i>>3&1;
      end
  end

endmodule
