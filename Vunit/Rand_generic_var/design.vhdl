library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;


entity and_gate is
   generic (
      G_NUMBER : integer := 2
   ); 
   port (
      i_clk : in std_logic;
      a     : in std_logic;
      b     : in std_logic;
      c     : out std_logic;
      d     : out integer
);
end entity and_gate;


architecture rtl of and_gate is


begin


   process_cnt : process(i_clk)
      variable v_cnt : integer := 0;
   begin
      if (i_clk'event and i_clk = '1') then
         if (v_cnt = G_NUMBER) then
            v_cnt := 0;
         else
            v_cnt := v_cnt + 1;
         end if;
         d <= v_cnt;
      end if;
   end process;

   process_and : process (a, b)
   begin
      c <= a and b;
   end process process_and;


end architecture rtl;
