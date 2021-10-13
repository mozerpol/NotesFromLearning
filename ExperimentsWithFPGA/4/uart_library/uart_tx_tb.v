`timescale 100ps / 100ps

`define START 2'b00
`define DATA 2'b01
`define STOP 2'b10
`define IDLE 2'b11

module uart_tx_tb;
	reg clk = 1'b1;
	reg rst;
	reg [7:0] data;
	wire tx;
	parameter BAUD = 9600;
	parameter F = 50000000;

	uart_tx #(.BAUD(BAUD), .F(F)) tx_test (
		.clk(clk),
		.rst(rst),
		.data(data),
		.tx(tx)
	);

	initial begin
                data = 8'b10101010;
                rst = 1'b0;
                #100 rst = 1'b1;
		//#1000000 $stop;
	end

	always #10 clk <= ~clk;

endmodule
