`define START 2'b00
`define DATA 2'b01
`define STOP 2'b10

module uart_tx
	#(parameter BAUD = 9600, F = 50000000)
	(
	input clk,
	input rst,
	input [7:0] data,
	output tx
);



endmodule
