`define SEND 1'b0
`define IDLE 1'b1

module uart_tx
   #(parameter BAUD = 115200, F = 50000000)
   (
      input wire rst,
      input wire clk,
      input wire [7:0] data,
      output wire tx
   );

   wire [3:0] i;
   wire ov_clkBaud;
   reg rst_after_ov = 1'b0;
   wire tx_clk; // Bring together clkTx with clkBaud
   
   // Generate clock cycle for data transmission (baud rate)
   counter #(.N(1000)) clkTx (
      .clk(clk),
      .rst(!(rst_after_ov || rst)),
      .ce(1'b1),
      .q(),
      .ov(tx_clk)
   );
   
   // Go through array and send data 
   counter #(.N(10)) clkBaud (
      .clk(clk),
      .rst(!(rst_after_ov || rst)),
      .ce(tx_clk),
      .q(i),
      .ov(ov_clkBaud)
   );

   // Prepare the frame for sending
   wire [9:0] full_frame;
   assign full_frame[0] = 1'b0; // Start bit
   assign full_frame[9] = 1'b1; // Stop bit
   assign full_frame[8:1] = 8'd48 + data; // Assign data from input and convert
   // it to ascii
   reg [7:0] old_data = 8'd0;
   reg tx_reg = 1'b1;
   assign tx = tx_reg;
   reg state;

   always@(posedge clk) begin
      if(data != old_data) state <= `SEND; // Latch new data and send it
      if(ov_clkBaud) state <= `IDLE;//When the last bit is sent stop sending data
   end

   always@(posedge clk) begin
      case(state)
         `SEND:
            begin
               old_data <= data;
               tx_reg <= full_frame[i]; // Assign to the output current bit
               rst_after_ov  <= 1'b0; // Within sending data dont reset counters 
            end
         `IDLE: 
            begin
               tx_reg <= full_frame[9]; // The last bit is high bit, means idle
               rst_after_ov <= 1'b1; //Reset all counters after sending all data
            end
      endcase
   end

endmodule
