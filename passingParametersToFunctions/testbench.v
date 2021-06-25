/* There are two ways to pass parameters to a function:
1. By the command defparam.
2. When embedding the module. */
module showNumber; // This is the function what we want to call later and pass its arguments
  parameter number = 0; // These are its parameters
  parameter character = "A"; 
  
  initial // Behavioral level. As we only have one statement in block, we don't
  // need to give commands that group "begin" and "end".
    $display("Value of the number: %d; Character: %c", number, character);
endmodule

module firstWay; // we always have to use defparam before calling a module
  defparam one.number = 1, two.number = 2; // defparam properName.argumentOfCallingFunction
  showNumber one(); // calling the module
  showNumber two();
endmodule

module secondWay;
  showNumber #(13, "B") callFunction();
  // If there are several arguments, we list them after the decimal point in the order 
  // they were declared in the module definition.
  showNumber #(.number(14), .character("C")) anyFunction(); // The same way as above, 
  // but thanks to this we do not have to give the parameters in the correct order.
endmodule









