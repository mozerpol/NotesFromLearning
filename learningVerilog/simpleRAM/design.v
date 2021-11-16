module simpleRAM #(
   parameter wordSize = 8,
   parameter addressSize = 32,
   parameter W = $clog2(addressSize)
)(
   input wire clk,
   input wire we, // Write enable
   input wire re, // Read enable
   input wire [W-1:0] addr,
   inout wire [7:0] data
);

   reg [wordSize-1:0] memory [0:addressSize-1];

   assign data = (re & !we) ? memory[addr] : 8'hzz;

   always@(posedge clk) if(we & !re) memory[addr] <= data;

endmodule
