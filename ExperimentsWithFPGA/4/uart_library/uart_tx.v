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

   reg [1:0] state = `IDLE;
   reg [7:0] data_reg;
   assign data = data_reg;
   reg rst_reg;
   assign rst = rst_reg;
   wire cd_data_byte;
   reg [2:0] i;

   always @(posedge clk) begin
      case(state)
         `START: rst_reg = 1'b1;
         `DATA: rst_reg = 1'b1;
         `STOP: rst_reg = 1'b0;
         `IDLE: rst_reg = 1'b0;
         default: rst_reg = 1'b0;
      endcase
   end

   // Generate clock cycle for data transmission
   counter #(.N((F+BAUD/2)/BAUD)) ctx (
      .clk(clk),
      .rst(rst),
      .ce(1'b1),
      .q(),
      .ov(cd_data_byte)
   );
   
   // 
   counter #(.N(8)) cdata (
      .clk(clk),
      .rst(rst),
      .ce(cd_data_byte),
      .q(i),
      .ov()
   );

   //assign tx = data_reg[i];

endmodule
