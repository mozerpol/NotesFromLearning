`timescale 100ns / 100ns

module shift_reg_led_tb; 
  reg clk = 1'b1;
  reg rst = 1'b0;
  reg ce_in = 1'b1;
  reg d_in = 1'b1;

  always #50 clk <= ~clk;
  always #120 ce_in <= ~ce_in;
  always #120 d_in <= ~d_in;

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;

    #500 rst = 1'b1;
    #500 rst = 1'b0;
    #500 rst = 1'b1;
    #2000 $finish;
  end

  shift_reg_led dut (
    .clk(clk),
    .rst(rst),
    .ce_in(ce_in),
    .d_in(d_in),
    .led()
  );

endmodule
