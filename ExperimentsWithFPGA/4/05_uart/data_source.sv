/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

 `default_nettype none

module data_source #(
	parameter F = 50000000
) (
    StreamBus.Master bus
);
    logic c_1s_ov;

    counter #(.N(F)) c_1s (
        .clk(bus.clk),
        .rst(bus.rst),
        .ce(bus.ready),
        .q(),
        .ov(c_1s_ov)
    );

    counter #(.N(10)) c_data (
        .clk(bus.clk),
        .rst(bus.rst),
        .ce(c_1s_ov & bus.ready),
        .q(bus.data),
        .ov()
    );

    assign bus.valid = c_1s_ov;

endmodule

`default_nettype wire
