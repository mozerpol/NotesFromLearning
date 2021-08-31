module gates(
	input wire clk,
	input wire in1,
	input wire in2,
	output wire led1,
	output wire led2,
	output wire led3
);
	reg in1_n, in2_n;

	always@(*)
	begin
		in1_n = ~in1;
		in2_n = ~in2;
	end

	reg led1_r, led2_r, led3_r;
	assign led1 = led1_r;
	assign led2 = led2_r;
	assign led3 = led3_r;
	
	always@(posedge clk)
	begin
		led1_r <= in1_n & in2_n;
		led2_r <= in1_n | in2_n;
		led3_r <= in1_n ^ in2_n;
	end
endmodule
