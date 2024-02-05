library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;

entity my_design is
   port (
      clk : in std_logic
   );
end entity my_design;

architecture rtl of my_design is

  signal my_signal_1 : std_logic;
  signal my_signal_2 : std_logic;

begin

  my_signal_1 <= '1';
  my_signal_2 <= '0';

end architecture rtl;
