module gates_area_tb(); // It's good to add "_tb"

  reg in1_tb = 1; // Must be reg type, because in our model b1_i is wire type.
  reg in2_tb = 0; // This is declaring variables and assigning them initial values.
  reg in3_tb = 0;
  wire out_tb; // Must be wire, because it's output port
  /* There are two methods of connecting the pins of the instance with external signals:
  1. Connecting by order, as it occurs in the module definition
  2. Connecting by name which is shown below */
  gates_area UUT1( // UUT is an instance of the gate module. UUT - unit under test
    .in1(in1_tb), // Binding vars from test with vars from model
    .in2(in2_tb),
    .in3(in3_tb),
    .out_or(out_tb)
  );

  integer i = 0; // Variable declaration for loop for purposes.

  initial begin
    // Behavioral level, there are two types of blocks at this level: initial and 
    // always. Inside these blocks, the instructions are executed sequentially.
    $dumpfile("tb.vcd"); // $dumpfile - should be given at the beginning to
    // monitor the state of the variables from beginning.
    $dumpvars;
    $display("\t\t time | in1 | in2 | in3 | out");

    for(i=0; i<=7; i=i+1)
      begin
        #1 // 1 sec delay from previous instruction. It's possible because 
        // the instructions in the initial block are executed sequentially, one after the other.
        in1_tb = 1^in1_tb;
        in2_tb = i>>1;
        in3_tb = i>>2;
        $monitor($time, "  |  %d  |  %d  |  %d  |  %d", in1_tb, in2_tb, in3_tb, out_tb);
      end
  end
endmodule
/*
1. in1_tb = 1^in1_tb; 
It's the same like in "C" lang: var ^= var, but in Verilog we can't do this,
so we're doing: var = 1*(change sign)*var

2. in2_tb = i>>1; 
It is simple bitwise operation. For instance:
0>>1: 0000>>1: 0000
1>>1: 0001>>1: 0000
2>>1: 0010>>1: 0001
3>>1: 0011>>1: 0001
4>>1: 0100>>1: 0010
5>>1: 0101>>1: 0010
6>>1: 0110>>1: 0011
*/
