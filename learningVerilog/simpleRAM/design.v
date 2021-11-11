module simpleRAM #(
   parameter wordSize = 8,
   parameter addressSize = 32
)(
   input wire clk,
   input wire we, // Write enable
   input wire re, // Read enable
   inout wire data
);

   reg [wordSize-1:0] memory [0:addressSize-1];
   reg ce;

   assign memory[0][7:0] = 8'h1;
   assign memory[1][7:0] = 8'h2;
   assign memory[2][7:0] = 8'h3;

   always@(posedge clk) begin
      if(we&re); // do sth
   end

endmodule
