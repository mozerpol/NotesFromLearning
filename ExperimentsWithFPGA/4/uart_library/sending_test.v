module sending
   #(parameter BAUD = 115200, F = 50000000)
   (
      input wire clk,
      input wire rst,
      output wire tx
   );

   wire counter1_ov;
   reg [7:0] data;

   // Measure some time, when overflow send byte
   counter #(.N(10)) counter1 (
      .clk(clk),
      .rst(!rst),
      .ce(1'b1),
      .q(),
      .ov(counter1_ov)
   );

   // Send numbers from 0 to 7 when overflow on counter1
   counter #(.N(8)) counter2 (
      .clk(clk),
      .rst(!rst),
      .ce(counter1_ov),
      .q(data),
      .ov()
   );

   uart_tx #(
      .BAUD(BAUD), 
      .F(F)
   ) uart(
      .clk(clk),
      .rst(rst),
      .tx(tx),
      .data((8'b00000111 & data))
   );

endmodule
