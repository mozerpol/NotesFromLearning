/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none
`timescale 100ps / 100ps

module uart_rx_tb;
	logic clk;
	logic rst;
	logic rtx;
	StreamBus bus_tx(clk, rst);
	StreamBus bus_rx(clk, rst);

	initial begin
		clk <= '0;
		forever #625 clk <= ~clk;
	end

	initial begin
		rst <= 1'b0;
		#1250 rst <= 1'b1;
	end

	initial begin
		bus_rx.ready <= 1'b1;
		bus_tx.valid <= 1'b1;
		bus_tx.data <= 8'hab;
	end

	uart_tx uart_tx(
		.bus(bus_tx),
		.tx(rtx)
	);

	uart_rx dut(
		.rx(rtx),
		.bus(bus_rx)
	);

endmodule

`default_nettype wire
