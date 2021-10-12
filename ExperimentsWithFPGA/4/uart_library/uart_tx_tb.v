`define START 2'b00
`define DATA 2'b01
`define STOP 2'b10

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

	always #10 clk = ~clk;

	initial begin
		#100 $stop;
	end

endmodule
