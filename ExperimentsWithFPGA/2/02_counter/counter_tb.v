`timescale 100ps / 100ps

module counter_tb;
  reg clk, rst, ce, ov1;

  initial begin
    clk = 1;
    forever #5 clk = ~clk;
  end

  initial begin
    rst <= 1'b0;
    #10 rst <= 1'b1;
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;

    ce <= 1'b1;
    #20 ce <= 1'b0;
    #20 ce <= 1'b1;
    #400 $finish;
  end

  counter #(.N(10)) dut1(
    .clk(clk),
    .rst(rst),
    .ce(ce),
    .q(),
    .ov(ov1)
  );

  counter #(.N(10)) dut2(
    .clk(clk),
    .rst(rst),
    .ce(ce & ov1),
    .q(),
    .ov()
  );
  
endmodule
