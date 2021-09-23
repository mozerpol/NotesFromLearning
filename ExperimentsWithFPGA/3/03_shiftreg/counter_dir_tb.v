`timescale 100ns / 10ns

module counter_dir_tb;
  reg clk, rst, ce, dir;

  initial begin
    clk <= 1;
    forever #5 clk <= ~clk;
  end

  initial 
    begin
      rst <= 1'b0;
      #10 rst <= 1'b1;
    end

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;
    dir <= 1'b1;
    ce <= 1'b1;
    repeat (10) @(posedge clk);
    ce <= 1'b0;
    repeat (5) @(posedge clk);
    ce <= 1'b1;
    dir <= 1'b0;
    repeat (10) @(posedge clk);
    #80 $finish;
  end

  counter_dir #(.N(3)) dut (
    .clk(clk),
    .rst(rst),
    .ce(ce),
    .dir(dir),
    .q()
  );
endmodule
