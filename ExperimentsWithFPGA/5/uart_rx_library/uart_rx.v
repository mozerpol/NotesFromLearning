`define SAMPLING 1'b0
`define IDLE     1'b1

module uart_rx #(
   parameter F = 8000000,
   parameter BAUD = 115200
) (
   input wire rx,
   input wire clk,
   input wire rst,
   output wire [7:0] data_out
);
   
   wire [3:0] i;
   wire ov_clkBaud;
   reg rst_after_ov = 1'b0;
   wire tx_clk; // Bring together clkTx with clkBaud
   
   // Generate clock cycle for data transmission (baud rate)
   counter #(.N((F+BAUD/2)/BAUD)) clkTx (
      .clk(clk),
      .rst(!(rst_after_ov || rst)),
      .ce(1'b1),
      .q(),
      .ov(tx_clk)
   );
   
   // Go through array and send data 
   counter #(.N(9)) clkBaud (
      .clk(clk),
      .rst(!(rst_after_ov || rst)),
      .ce(tx_clk),
      .q(i),
      .ov(ov_clkBaud)
   );

   always@(posedge clk) begin
      if(!rx &)
   end

endmodule
