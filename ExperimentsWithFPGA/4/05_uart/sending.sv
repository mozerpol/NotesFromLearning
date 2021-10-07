/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

 `default_nettype none

module sending #(
	parameter F = 50000000
) (
    input wire clk,
    input wire rst,
    output logic tx
);
    StreamBus #(.N(4)) bus_num (.clk(clk), .rst(rst));
    StreamBus #(.N(8)) bus_ascii (.clk(clk), .rst(rst));

    data_source #(.F(F)) source (
        .bus(bus_num)
    );

    to_ascii ascii (
        .bus_in(bus_num),
        .bus_out(bus_ascii)
    );

    uart_tx #( 
        .F(F),
        .BAUD(115200)
    ) uart (
        .bus(bus_ascii),
        .tx(tx)
    );

endmodule

`default_nettype wire
