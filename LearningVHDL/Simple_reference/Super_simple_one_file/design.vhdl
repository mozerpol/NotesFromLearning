library ieee;
   use ieee.std_logic_1164.all;


entity and_gate is port (
   i_clk : in std_logic;
   i_a   : in  std_logic;
   i_b   : in  std_logic;
   o_c   : out std_logic
);
end entity and_gate;


architecture rtl of and_gate is


begin

   process_and : process (i_clk) is
   begin

      if (i_clk'event and i_clk = '1') then
         o_c <= i_a and i_b;
      end if;

   end process process_and;


end architecture rtl;
