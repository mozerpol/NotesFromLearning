`define START 2'b00
`define DATA 2'b01
`define STOP 2'b10
`define IDLE 2'b11

module uart_tx
   #(parameter BAUD = 9600, F = 50000000)
   (
      input wire rst,
      input wire clk,
      input wire [7:0] data,
      output wire tx
   );

   // Data sending part
   reg [7:0] data_reg;
   assign data_reg = data;
   wire tx_clk;
   reg [2:0] i;

   // Generate clock cycle for data transmission
   counter #(.N(8)) clkTx (
      .clk(clk),
      .rst(rst),
      .ce(1'b1),
      .q(),
      .ov(tx_clk)
   );
   
   // Generate clock for baud rate 
   counter #(.N(8)) clkBaud (
      .clk(clk),
      .rst(rst),
      .ce(tx_clk),
      .q(i),
      .ov()
   );

   assign tx = data_reg[i];

endmodule
