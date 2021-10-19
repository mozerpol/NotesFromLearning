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

   wire tx_clk;
   reg rst_reg;
   assign rst_reg = rst;
   reg flag;
   reg [3:0] i;

   // Generate clock cycle for data transmission (baud rate)
   counter #(.N(8)) clkTx (
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

   reg [9:0] full_frame;
   reg [7:0] prev_full_frame;
   assign full_frame[0] = 1'b0; // Start bit
   assign full_frame[9] = 1'b1; // Stop bit
   assign full_frame[8:1] = data;
   assign tx = full_frame[i];
/*
   always@(posedge clk)
   begin
      if(flag == 1'b1) begin
         rst_reg <= 1'b0;
         flag <= 1'b0;
      end
      if(full_frame[8:1] != data) 
      begin
         rst_reg <= 1'b1;
         flag <= 1'b1;
      end
   end
*/
endmodule
