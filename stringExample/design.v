module testbench;
  
  reg [8*12:1] napis; /* string should be declared as a reg vector.
  reg [8*liczba_znakow:0]
  8 - because strings are ascii characters, so each string needs 8 bits.
  liczba_znakow - you know ;p If the declared value is too small, it will cut 
  the string from the left, if there are too many declared characters, it will
  add zeros from the left, if there is too less, also will add zeros from the
  left.
  :1 - I don't know ;p
  */
  
  initial begin // initial - block on the behavioral level (also exsist always),
  // is executed at the beginning of the simulation.
	napis = "ala ma \nkota";
    $display("%s", napis); // display - system command, it always puts a newline
    // at the end. %s - format character
  end // begin, end - something like brackets in C.
  
endmodule
