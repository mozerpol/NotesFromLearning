library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;

entity and_gate is port (
   a : in    std_logic;
   b : in    std_logic;
   c : out   std_logic
);
end entity and_gate;

architecture rtl of and_gate is

begin

   process_and : process (a, b) is
   begin

      c <= a and b;

   end process process_and;

end architecture rtl;
