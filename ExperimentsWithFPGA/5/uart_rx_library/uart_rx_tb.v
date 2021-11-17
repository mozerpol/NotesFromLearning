`timescale 100ns/100ns

module uart_rx_tb();

   reg clk = 1'b1;
   reg rx;
   parameter BAUD = 115200;
   parameter F = 8000000;

   uart_rx #( .BAUD(BAUD), .F(F) ) uut(
      .rx(rx)
   );

   initial begin
      #100 $stop;
   end

   always #5 clk <= ~clk;

endmodule
