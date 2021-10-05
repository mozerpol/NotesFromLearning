`define WAIT	2'b00
`define START	2'b01
`define DATA	2'b10
`define STOP	2'b11

module uart_tx #( 
  parameter F = 8000000,
  parameter BAUD = 115200,
  parameter N = 8 
)(
  input wire clk,
  input wire rst,
  input wire [N-1:0] data,
  input wire valid,
  output wire ready,
  output wire tx
);

  reg [1:0] state;
  reg [7:0] txb;
  reg [2:0] i;
  wire handshake;
  reg tx_clk;
  reg ctx_rst, data_count_rst;
  reg data_count_ov, data_count_ov_d;
  reg tx_reg;
  assign tx = tx_reg;

  assign handshake = valid & ready;

  always_ff@(posedge clk or negedge rst)
    if (!rst) state <= `WAIT;
  else
    begin
      case(state)
        `WAIT: state <= valid ? `START : `WAIT;
        `START: state <= tx_clk ? `DATA : `START;
        `DATA: state <= data_count_ov_d ? `STOP : `DATA;
        `STOP: state <= tx_clk ? `WAIT : `STOP;
        default: state <= `WAIT;
      endcase
    end
  assign ready = (state == 2'b00);

  always@(posedge clk)
    if(handshake)
      txb <= data;

  always@(posedge clk)
    case (state)
      `START: tx_reg <= 1'b0;
      `DATA: tx_reg <= data_count_ov_d ? 1'b1 : txb[i];
      default: tx_reg <= 1'b1;
    endcase

  assign ctx_rst = (state == 0);
  counter #(.N((F+BAUD/2)/BAUD)) ctx (
    .clk(clk),
    .rst(!ctx_rst),
    .ce(1'b1),
    .q(),
    .ov(tx_clk)
  );

  assign data_count_rst = (state != `DATA);
  counter #(.N(8)) data_count (
    .clk(clk),
    .rst(!data_count_rst),
    .ce(tx_clk),
    .q(i),
    .ov(data_count_ov)
  );

  always@(posedge clk)
    if (tx_clk)
      data_count_ov_d <= data_count_ov;

endmodule
