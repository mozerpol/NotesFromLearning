/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

 `default_nettype none

module uart_rx #( 
	parameter F = 8000000,
	parameter BAUD = 115200
) (
	input wire rx,
	StreamBus.Master bus
);
	import uartPkg::*;
	localparam MOD = (F+BAUD/2)/BAUD;
	localparam MOD_LOG = $clog2(MOD);

	state s;
	logic [7:0]rxb;
	logic [2:0]i;
	logic [MOD_LOG-1:0]ctx_q;
	logic ctx_rst, data_count_rst;
	logic rx_clk;
	logic data_count_ov, data_count_ov_d;

	always_ff @(posedge bus.clk or negedge bus.rst)
		if (!bus.rst)
			s <= WAIT;
		else
			case (s)
				WAIT: s <= rx ? WAIT : START;
				START: s <= rx_clk ? DATA : START;
				DATA: s <= data_count_ov_d ? STOP : DATA;
				STOP: s <= rx_clk ? WAIT : STOP;
				default: s <= WAIT;
			endcase
	
	assign ctx_rst = (s == WAIT);
	counter #(.N(MOD)) crx (
		.clk(bus.clk),
		.rst(!ctx_rst),
		.ce(1'b1),
		.q(ctx_q),
		.ov());
	assign rx_clk = (ctx_q == MOD/2);

	assign data_count_rst = (s != uartPkg::DATA);
	counter #(.N(8)) data_count (
		.clk(bus.clk),
		.rst(!data_count_rst),
		.ce(rx_clk),
		.q(i),
		.ov(data_count_ov)
	);

	always_ff @(posedge bus.clk)
			if (rx_clk)
				data_count_ov_d <= data_count_ov;

	always_ff @(posedge bus.clk)
		if (rx_clk)
			rxb[i] <= rx;

	always_ff @(posedge bus.clk or negedge bus.rst)
		if (!bus.rst)
			bus.valid <= 1'b0;
		else if (data_count_ov_d && s == DATA)
			bus.valid <= 1'b1;
		else if (bus.ready)
			bus.valid <= 1'b0;

	always_ff @(posedge bus.clk)
		if (data_count_ov_d && s == DATA)
			bus.data <= rxb;

endmodule

`default_nettype wire
