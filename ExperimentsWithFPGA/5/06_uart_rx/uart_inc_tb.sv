/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

 `default_nettype none
 `timescale 100ps / 100ps
 
module uart_inc_tb;
    logic clk;
    logic rst;
    logic rtx, trx;
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
		bus_tx.valid <= 1'b1;
		bus_tx.data <= 8'hab;
	end

    uart_tx #(.F(8000000)) utx(
		.bus(bus_tx),
		.tx(rtx));

    uart_inc #(
        .F(8000000)
    ) dut (
        .clk(clk),
        .rst(rst),
        .rx(rtx),
        .tx(trx));

    uart_rx #(.F(8000000)) urx(
        .rx(trx),
		.bus(bus_rx));

endmodule
 
 `default_nettype wire
