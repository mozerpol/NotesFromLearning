module testbench; // after keyword "module" is its name and portlist (in this
// case don't have any ports) 
  
  reg switch = 1'b1; // variable declaration
  
  // initial - the beginning of the block at the behavioral level. There can be
  // many blocks in a module, all of them execute in parallel, but the middle, 
  // the body of the block, is executed sequentially. We distinguish between two
  // blocks, "always" and "initial". The "initial" block is only run once, at
  // the begining and is used for initialization and monitoring.
  initial begin // begin, end - it's like brackets in C.
    $dumpfile("dump.vcd"); // $dumpfile - should be given at the beginning to
    // monitor the state of the variables from beginning.
    $dumpvars;
    #100 switch = 1'b0; // "#<czas>" - is a delay from the previous instruction.
    // In the initial block everything is done step by step, so giving # 100 we
    // make a delay of 100 seconds in relation to the previous instruction. 
    #110 $finish; // $finish - ends simulation, dumpfile operation and variable
    // monitoring.
  end
 
endmodule
