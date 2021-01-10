module wyswietlLiczbe;
  parameter liczba = 0;
  parameter znak = "A"; 
  
  initial
    $display("Wartosc liczby: %d; Znak: %c", liczba, znak);
endmodule

module pierwszySposob;
  defparam jeden.liczba = 1, dwa.liczba = 2;
  wyswietlLiczbe jeden();
  wyswietlLiczbe dwa();
endmodule

module drugiSposob;
  wyswietlLiczbe #(13, "B") wywolajFunkcje();
  wyswietlLiczbe #(.liczba(14), .znak("C")) jakasFunkcja();
endmodule
