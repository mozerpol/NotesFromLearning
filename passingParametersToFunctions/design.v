module showNumber;
  parameter number = 0;
  parameter character = "A"; 
  
  initial
    $display("Value of the number: %d; Character: %c", number, character);
endmodule

module firstWay;
  defparam one.number = 1, two.number = 2;
  showNumber one();
  showNumber two();
endmodule

module secondWay;
  showNumber #(13, "B") callFunction();
  showNumber #(.number(14), .character("C")) anyFunction();
endmodule
