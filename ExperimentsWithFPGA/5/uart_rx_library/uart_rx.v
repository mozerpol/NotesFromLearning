`define IDLE     1'b0
`define SAMPLING 1'b1

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
   reg rst_after_ov = 1'b1;
   wire tx_clk; // Bring together clkTx with clkBaud
   reg state = 1'b0;
   
   // Generate clock cycle for data transmission (baud rate)
   counter #(.N(1000)) clkTx (
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

   reg flag = 1'b1;

   always@(posedge clk) begin
      if(!rx & flag) begin
         state <= 1'b1;
         flag <= 1'b0;
         rst_after_ov  <= 1'b0; // Within sending data dont reset counters
      end
      if(ov_clkBaud) begin
         rst_after_ov <= 1'b1; //Reset all counters after sending all data
         flag <= 1'b1;
      end
   end

endmodule
