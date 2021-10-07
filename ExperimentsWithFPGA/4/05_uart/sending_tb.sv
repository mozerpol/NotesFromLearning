/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

 `default_nettype none
 `timescale 100ps / 100ps
 
module sending_tb;	
     logic clk;
     logic rst;
 
     initial begin
         clk <= '0;
         forever #625 clk <= ~clk;
     end
 
     initial begin
         rst <= 1'b0;
         #1250 rst <= 1'b1;
     end
 
   sending #(
        .F(8000000)
    ) dut (
        .clk(clk),
        .rst(rst),
        .tx()
    );

endmodule
 
 `default_nettype wire
 