`timescale 100ps / 100ps

module gates_tb;
	reg clk, in1, in2;

	initial begin
		clk = 1;
		forever #62.5 clk = ~clk;
	end

	initial begin
      $dumpfile("dump.vcd"); $dumpvars;
		in1 = 1'b1;
		in2 = 1'b1;
		#200
		in1 = 1'b0;
		in2 = 1'b1;
		#200
		in1 = 1'b1;
		in2 = 1'b0;
		#200
		in1 = 1'b0;
		in2 = 1'b0;
		#200
		$finish;
	end

	gates dut (
		.clk(clk),
		.in1(in1),
		.in2(in2),
		.led1(),
		.led2(),
		.led3()
	);
endmodule
