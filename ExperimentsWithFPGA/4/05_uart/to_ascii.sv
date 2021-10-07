/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

module to_ascii (
    StreamBus.Slave bus_in,
    StreamBus.Master bus_out
);

    always_ff @(posedge bus_in.clk)
        if (bus_out.ready)
            bus_out.data <= 8'd48 + bus_in.data;

    always_ff @(posedge bus_in.clk or negedge bus_in.rst)
        if (!bus_in.rst)
            bus_out.valid = 1'b0;
        else if (bus_out.ready)
            bus_out.valid <= bus_in.valid;

    assign bus_in.ready = bus_out.ready;
endmodule

`default_nettype wire
