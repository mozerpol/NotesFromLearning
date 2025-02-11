library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;


entity and_gate is
   generic (
      G_GENERATE : integer := 0;
      -- 0 - don't generate cnt_1 and cnt_2
      -- 1 - generate cnt_1
      -- 2 - generate cnt_2
      -- 3 - generate cnt_1 and cnt_2
      G_NUMBER_1 : integer := 2;
      G_NUMBER_2 : integer := 4
   );
   port (
      i_clk : in std_logic;
      a     : in std_logic;
      b     : in std_logic;
      c     : out std_logic;
      d_1   : out integer;
      d_2   : out integer
);
end entity and_gate;


architecture rtl of and_gate is


begin


   G_GENERATE_CNT_1 : if ((G_GENERATE = 1) or (G_GENERATE = 3)) generate
      process_cnt_1 : process(i_clk)
         variable v_cnt_1 : integer := 0;
      begin
         if (i_clk'event and i_clk = '1') then
            if (v_cnt_1 = G_NUMBER_1) then
               v_cnt_1 := 0;
            else
               v_cnt_1 := v_cnt_1 + 1;
            end if;
            d_1 <= v_cnt_1;
         end if;
      end process;
   end generate G_GENERATE_CNT_1;


   G_GENERATE_CNT_2 : if ((G_GENERATE = 2) or (G_GENERATE = 3)) generate
      process_cnt_2 : process(i_clk)
         variable v_cnt_2 : integer := 0;
      begin
         if (i_clk'event and i_clk = '1') then
            if (v_cnt_2 = G_NUMBER_2) then
               v_cnt_2 := 0;
            else
               v_cnt_2 := v_cnt_2 + 1;
            end if;
            d_2 <= v_cnt_2;
         end if;
      end process;
   end generate G_GENERATE_CNT_2;


   process_and : process (a, b)
   begin
      c <= a and b;
   end process process_and;


end architecture rtl;
