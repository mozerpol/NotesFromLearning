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
      .ov(ov_clkBaud)
   );

   wire [9:0] full_frame;
   assign full_frame[0] = 1'b0; // Start bit
   assign full_frame[9] = 1'b1; // Stop bit
   assign full_frame[8:1] = data;//ascii_data;
   reg [7:0] old_data = 8'b00000000;
   reg tx_reg;
   assign tx = tx_reg;
   reg state;

   always@(posedge clk) begin
      if(data != old_data) begin
         old_data <= data;
         state <= 1'b0;
      end
			if(ov_clkBaud) begin
         state <= 1'b1;
      end
   end

   always@(posedge clk) begin
      case(state)
         1'b0: tx_reg <= full_frame[i];
         1'b1: tx_reg <= full_frame[9];
      endcase
   end

endmodule
