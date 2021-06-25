module mux_4to1_tb; // if it's testbech it is worth adding "_tb"
  reg [3:0] a_tb; // variable declaration, which are using in our testbench
  reg [3:0] b_tb;
  reg [3:0] c_tb;
  reg [3:0] d_tb;
  wire [3:0] out_tb;
  reg [1:0] sel_tb;
  integer i;
  
  mux_4to1 UUT( // UUT - it's label, unit under test
    .a(a_tb), // Thanks to this we can connect module "mux_4to1" ports with our testbench.
    // Later we can use variable "a_tb" in our testbench.
    .b(b_tb),
    .c(c_tb),
    .d(d_tb),
    .sel(sel_tb),
    .out(out_tb)
  );
  
  initial // it's behavioral level, initial and aways are its blocks. Initial run only once, on the begining.
    begin // It's like bracket int C.
      $dumpfile("tb.vcd"); // For edaplayground purpose
    $dumpvars; // For edaplayground purpose
    $monitor("[%0t] sel=0x%0h a=0x%0h b=0x%0h c=0x%0h d=0x%0h out=0x%0h", $time, sel_tb, a_tb, b_tb, c_tb, d_tb, out_tb);
    sel_tb <= 0; // <= - it's assignment type nonblocking. 
    a_tb <= $random;
      b_tb <= 15; // For fun, 15 it's max value, because b_tb is four bit value (0b1111 = 15 in dec).
    c_tb <= $random;
    d_tb <= $random;
    
    for(i = 1; i < 4; i = i+1)
      begin
        #5 sel_tb <= i; // Wait five sec and run sel_tb <= i.
      end
    
    #5 $finish;
    
    end // The end of initial part.
  
endmodule
