/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

interface StreamBus #(
		parameter N = 8
	) (
		input wire clk,
		input wire rst
	);
	logic [N-1:0] data;
	logic valid;
	logic ready;

	modport Master (
		input clk,
		input rst,
		input ready,
		output data,
		output valid
	);

	modport Slave (
		input clk,
		input rst,
		input data,
		input valid,
		output ready
	);

endinterface

package uartPkg;

	typedef enum logic [1:0] {
		WAIT,
		START,
		DATA,
		STOP
	} state;

endpackage : uartPkg

`default_nettype wire
