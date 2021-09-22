`timescale 100ns/100ns

module shift_reg_tb; 
  reg clk, rst, ce, d;

  initial begin
    clk = 1'b0;
    forever #60 clk = ~clk;
  end

  initial begin
    rst = 1'b0;
    #120 rst = 1'b1;
  end

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;
    ce = 1'b1;
    d = 1'b1;
    repeat (2) @(posedge clk);
    d = 1'b0;
    @(posedge clk);
    d = 1'b1;
    @(posedge clk);
    d = 1'b0;
    repeat (2) @(posedge clk);
    d = 1'b1;
    repeat (1) @(posedge clk);
    d = 1'b0;
    repeat (5) @(posedge clk);
    #120 $finish;
  end

  shift_reg #(.N(4)) dut (
    .clk(clk),
    .rst(rst),
    .ce(ce),
    .d(d),
    .q()
  );

endmodule
