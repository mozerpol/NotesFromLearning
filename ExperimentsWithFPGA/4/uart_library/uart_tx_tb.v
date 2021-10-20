`timescale 100ps / 100ps

`define START 2'b00
`define DATA 2'b01
`define STOP 2'b10
`define IDLE 2'b11

module uart_tx_tb;
	reg clk = 1'b1;
	reg rst_tb;
	reg [7:0] data_tb;
	wire tx;
	parameter BAUD = 115200;
	parameter F = 50000000;

	uart_tx #(.BAUD(BAUD), .F(F)) tx_test (
		.clk(clk),
		.rst(rst_tb),
		.data(data_tb),
		.tx(tx)
	);

	initial begin
      rst_tb = 1'b1;
      #100 rst_tb = 1'b0;
      data_tb = 8'b11010011;
      //#2000 rst_tb = 1'b1;
      #10000000 data_tb = 8'b00101100;
	end

	always #10 clk <= ~clk;

endmodule
