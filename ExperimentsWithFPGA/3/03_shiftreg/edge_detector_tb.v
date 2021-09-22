`timescale 100ns / 100ns

module edge_detector_tb;
  reg clk, rst, d;

  initial begin
    clk = 1'b1;
    forever #62.5 clk = ~clk;
  end

  initial begin
    rst = 1'b0;
    #125 rst = 1'b1;
  end

  initial
    begin
      $dumpfile("tb.vcd"); 
      $dumpvars;
      d = 1'b0;
      repeat (2) begin
        repeat(4) @(posedge clk);
        d = 1'b1;
        repeat(4) @(posedge clk);
        d = 1'b0;
      end
      repeat(2) @(posedge clk);
      #100 $finish;
    end

  edge_detector dut (
    .clk(clk),
    .d(d),
    .rst(rst),
    .q()
  );

endmodule
