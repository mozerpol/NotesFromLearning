/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

module uart_tx #( 
	parameter F = 50000000,
	parameter BAUD = 115200
) (
	StreamBus.Slave bus,
	output logic tx
);
	uartPkg::state state;
	logic [7:0]txb;
	logic [2:0]i;
	logic handshake;
	logic tx_clk;
	logic ctx_rst, data_count_rst;
	logic data_count_ov, data_count_ov_d;

	assign handshake = bus.valid & bus.ready;

	always_ff @(posedge bus.clk or negedge bus.rst)
		if (!bus.rst)
			state <= uartPkg::WAIT;
		else
			case (state)
				uartPkg::WAIT: state <= bus.valid ? uartPkg::START : uartPkg::WAIT;
				uartPkg::START: state <= tx_clk ? uartPkg::DATA : uartPkg::START;
				uartPkg::DATA: state <= data_count_ov_d ? uartPkg::STOP : uartPkg::DATA;
				uartPkg::STOP: state <= tx_clk ? uartPkg::WAIT : uartPkg::STOP;
				default: state <= uartPkg::WAIT;
			endcase

	assign bus.ready = (state == uartPkg::WAIT);

	always_ff @(posedge bus.clk)
		if (handshake)
			txb <= bus.data;

	always_ff @(posedge bus.clk)
		case (state)
			uartPkg::START: tx <= 1'b0;
			uartPkg::DATA: tx <= data_count_ov_d ? 1'b1 : txb[i];
			default: tx <= 1'b1;
		endcase

	assign ctx_rst = (state == uartPkg::WAIT);
	counter #(.N((F+BAUD/2)/BAUD)) ctx (
		.clk(bus.clk),
		.rst(!ctx_rst),
		.ce(1'b1),
		.q(),
		.ov(tx_clk)
	);

	assign data_count_rst = (state != uartPkg::DATA);
	counter #(.N(8)) data_count (
		.clk(bus.clk),
		.rst(!data_count_rst),
		.ce(tx_clk),
		.q(i),
		.ov(data_count_ov)
	);

	always_ff @(posedge bus.clk)
		if (tx_clk)
			data_count_ov_d <= data_count_ov;

endmodule

`default_nettype wire
