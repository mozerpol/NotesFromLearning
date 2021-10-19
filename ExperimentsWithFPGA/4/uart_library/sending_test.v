module sending
   #(parameter BAUD = 9600, F = 50000000)
   (
      input wire clk,
      input wire rst,
      output wire tx
   );

   reg c_1s_ov;

   counter #(.N(F)) c_1s (
      .clk(clk),
      .rst(rst),
      .ce(1'b1),
      .q(),
      .ov(c_1s_ov)
    );

    counter #(.N(10)) c_data (
        .clk(clk),
        .rst(rst),
        .ce(c_1s_ov),
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
      .data(data)
   );

endmodule
