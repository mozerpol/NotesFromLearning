module clk_counter (
    input wire clk,
    input wire rst,
    output logic [7:0]led
);
    logic t100ms;

    counter #( 
        .N(800000)
    ) counter1 (
        .clk(clk),
        .rst(rst),
        .ce(1'b1),
        .q(),
        .ov(t100ms)
    );

    counter #( 
        .N(256)
    ) counter2 (
        .clk(clk),
        .rst(rst),
        .ce(t100ms),
        .q(led),
        .ov()
    );
endmodule
