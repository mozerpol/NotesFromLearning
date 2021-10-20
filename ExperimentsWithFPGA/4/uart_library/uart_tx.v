module uart_tx
   #(parameter BAUD = 9600, F = 50000000)
   (
      input wire rst,
      input wire clk,
      input wire [7:0] data,
      output wire tx
   );

   wire tx_clk;
   reg rst_reg;
   assign rst_reg = rst;
   reg flag;
   reg [3:0] i;

   // Generate clock cycle for data transmission (baud rate)
   counter #(.N(1000)) clkTx (
      .clk(clk),
      .rst(!rst),
      .ce(1'b1),
      .q(),
      .ov(tx_clk)
   );
   
   // Go through array and send data 
   counter #(.N(10)) clkBaud (
      .clk(clk),
      .rst(!rst),
      .ce(tx_clk),
      .q(i),
      .ov()
   );
   reg [7:0] ascii_data;
   assign ascii_data = 8'd48 + data;
   reg [9:0] full_frame;
   assign full_frame[0] = 1'b0; // Start bit
   assign full_frame[9] = 1'b1; // Stop bit
   assign full_frame[8:1] = ascii_data;
   assign tx = full_frame[i];

endmodule
