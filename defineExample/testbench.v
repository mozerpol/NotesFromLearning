module testbench; // after keyword "module" is its name and portlist, thanks to 
// which you can communicate with the environment.
  
  `define JEDEN 1'b1 // `define <macro_name> <text> - defines a macro. After
  // that, each occurrence of <macro_name> is replaced with <text>. So every
  // occurrence in the ONE code will be replaced with 1'b1.
  
  reg switch = `JEDEN; // If we use a macro we have to give a this sign: `
  // before using it.
  
  initial begin // behavioral level - initial and always its blocks.
    $display("%d", switch); // system tasks begin with the character: $
  end // begin, end - something like brackets in C. Actually, when we have one
  // command, as in this case, begin and end can be omitted.
  
endmodule
