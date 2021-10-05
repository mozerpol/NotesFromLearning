`timescale 100ps / 100ps

module uart_tx_tb;
  reg clk;
  reg rst;
  reg [7:0] data;
  reg valid;
  wire ready;

  initial begin
    clk <= 1'b1;
    forever #625 clk = ~clk;
  end

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;

    valid <= 1'b0;
    rst <= 1'b0;
    #1250 rst <= 1'b1;
    valid <= 1'b1;
    data <= 8'hab;
    #3000000 $stop;
  end

  uart_tx dut(
    .clk(clk),
    .rst(rst),
    .ready(ready),
    .data(data),
    .valid(valid),
    .tx()
  );
endmodule
