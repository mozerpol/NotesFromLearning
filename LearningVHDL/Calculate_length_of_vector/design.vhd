library ieee;
   use ieee.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use IEEE.math_real.all;


entity simplecounter is
   generic (
      count_up_to : integer := 2
   );
   port (
      clk : in    std_logic;
      q   : out   std_logic := '0'
   );
end entity simplecounter;


architecture rtl of simplecounter is


   constant vector_length : integer :=
                              integer(ceil(log2(real(count_up_to) + real(1))));
   signal   counter       : std_logic_vector(vector_length downto 0) :=
                              (others => '0');

begin


end architecture rtl;
