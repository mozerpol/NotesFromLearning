module uart_tx
   #(parameter BAUD = 115200, F = 50000000)
   (
      input wire rst,
      input wire clk,
      input wire [7:0] data,
      output wire tx
   );

   wire tx_clk;
   wire [3:0] i;
   reg stop_counter = 1'b1;
   reg ov_clkBaud = 1'b0;
   reg rst_cnt = 1'b0;

   // Generate clock cycle for data transmission (baud rate)
   counter #(.N(1000)) clkTx (
      .clk(clk),
      .rst(!(rst || rst_cnt)),
      .ce(stop_counter),
      .q(),
      .ov(tx_clk)
   );
   
   // Go through array and send data 
   counter #(.N(10)) clkBaud (
      .clk(clk),
      .rst(!(rst || rst_cnt)),
      .ce(tx_clk),
      .q(i),
      .ov(ov_clkBaud)
   );

   wire [7:0] ascii_data;
   assign ascii_data = 8'd48 + data;
   wire [9:0] full_frame;
   assign full_frame[0] = 1'b0; // Start bit
   assign full_frame[9] = 1'b1; // Stop bit
   assign full_frame[8:1] = ascii_data;
   assign tx = full_frame[i];
   reg [7:0] old_data;
   reg flag = 1'b1;

   always@(posedge clk)
   begin
      if(flag && ov_clkBaud) begin // Latch current value
         old_data <= data;
         flag <= 1'b0;
         stop_counter <= 1'b0;
         rst_cnt <= 1'b1;
      end
      if(old_data^data) begin
         flag <= 1'b1; // Value has changed
         stop_counter <= 1'b1;
         rst_cnt <= 1'b0;
      end
   end

endmodule
