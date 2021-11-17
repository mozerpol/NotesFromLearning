/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

 `default_nettype none

module uart_inc #(
	parameter F = 8000000
) (
    input wire clk,
    input wire rst,
    input wire rx,
    output logic tx
);
    StreamBus #(.N(8)) bus_rx (.clk(clk), .rst(rst));
    StreamBus #(.N(8)) bus_tx (.clk(clk), .rst(rst));

    uart_rx #(.F(F), .BAUD(115200)) urx (
        .rx(rx),
        .bus(bus_rx));

    inc increment (
        .bus_in(bus_rx),
        .bus_out(bus_tx));

    uart_tx #(.F(F), .BAUD(115200)) utx (
        .bus(bus_tx),
        .tx(tx));

endmodule

`default_nettype wire
