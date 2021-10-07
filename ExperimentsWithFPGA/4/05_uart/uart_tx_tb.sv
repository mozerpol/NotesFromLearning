/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none
`timescale 100ps / 100ps

module uart_tx_tb;
	reg clk;
	reg rst;
  reg ready;
  reg [7:0] data;
  reg valid;
	StreamBus bus(clk, rst);

	initial begin
		clk <= 1'b1;
		forever #625 clk <= ~clk;
	end

	initial begin
		rst <= 1'b0;
		#1250 rst <= 1'b1;
	end

	initial begin
		bus.valid <= 1'b0;
		#1250;
		bus.valid <= 1'b1;
		bus.data <= 8'hab;
	end

	uart_tx dut(
		.bus(bus),
		.tx()
	);
endmodule

`default_nettype wire
