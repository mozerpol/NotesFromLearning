`timescale 100ps / 100ps

module debounce_tb; 
  reg clk, d, rst;

  initial begin
    clk = 1'b1;
    forever #625 clk = ~clk;
  end

  initial begin
    rst = 1'b0;
    #1250 rst = 1'b1;
  end

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    
    d = 1'b1;
    repeat (7) @(posedge clk);
    d = 1'b0;
    repeat (2) @(posedge clk);
    d = 1'b1;
    repeat (2) @(posedge clk);
    d = 1'b0;
    repeat (5) @(posedge clk);
    d = 1'b1;
    repeat (2) @(posedge clk);
    d = 1'b0;
    repeat (2) @(posedge clk);
    d = 1'b1;
    repeat (7) @(posedge clk);
    #1000 $finish;
  end

  debounce #(.N(3)) dut (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q()
  );
endmodule
