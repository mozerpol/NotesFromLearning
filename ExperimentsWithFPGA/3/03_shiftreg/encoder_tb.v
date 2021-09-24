`timescale 100ns / 10ns

module encoder_tb;
  reg clk, rst, a, b;

  initial 
    begin
      clk <= 1'b1;
      forever #60 clk = ~clk;
    end

  initial 
    begin
      rst <= 1'b0;
      #120 rst <= 1'b1;
    end

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;

    a <= 1'b0;
    b <= 1'b1;
    repeat (10) begin
      #10 a <= 1'b1;
      #10 b <= 1'b0;
      #10 a <= 1'b0;
      #10 b <= 1'b1;
    end
    repeat (10) begin
      #10 b <= 1'b0;
      #10 a <= 1'b1;
      #10 b <= 1'b1;
      #10 a <= 1'b0;
    end
    #2000 $finish;
  end

  encoder #(
    .LED_N(8),
    .DEBONUCE_N(14)
  ) dut (
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .led()
  );
endmodule
