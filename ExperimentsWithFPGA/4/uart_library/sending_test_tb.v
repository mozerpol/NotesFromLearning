`timescale 100ps / 100ps

module sending_tb;
	reg clk = 1'b1;
	reg rst;
	wire tx;
	parameter BAUD = 9600;
	parameter F = 50000000;

	sending #(.BAUD(BAUD), .F(F)) dut (
		.clk(clk),
		.rst(rst),
		.tx(tx)
	);

	initial begin
      rst <= 1'b1;
      #1000 rst <= 1'b0;
	end

	always #10 clk <= ~clk;

endmodule

