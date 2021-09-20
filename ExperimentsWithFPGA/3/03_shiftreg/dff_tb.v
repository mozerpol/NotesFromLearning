module dff_tb();

  wire q, neg_q;
  reg d = 1'b1, clk = 1'b1;

  dff UUT(
    .d(d),
    .clk(clk),
    .q(q),
    .neg_q(neg_q)
  );

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;
    #50 d = 0;
    #55 d = 1;
    #50 d = 0;
    #55 d = 1;
    #55 d = 0;
    #50 d = 1;

    #50 $finish;
  end

  always #10 clk <= ~clk;  

endmodule
