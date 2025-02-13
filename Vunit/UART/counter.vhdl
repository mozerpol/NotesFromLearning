library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;


entity counter  is
   generic(
      G_COUNTER_VALUE   : positive := 511
   ); port(
      i_rst_n           : in std_logic;
      i_clk             : in std_logic;
      i_cnt1_we         : in std_logic;
      i_cnt1_set_reset  : in std_logic;
      o_cnt1_overflow   : out std_logic;
      o_cnt1_q          : out integer range 0 to 511
);
end entity counter;


architecture rtl of counter  is


   signal s_ce_latch : std_logic;


begin


   process (i_clk)
      variable v_cnt : integer range 0 to G_COUNTER_VALUE;
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst_n = '0') then
            s_ce_latch        <= '0';
            v_cnt             := 0;
            o_cnt1_overflow   <= '0';
         else
            if (i_cnt1_we = '1' and i_cnt1_set_reset = '1') then
               s_ce_latch     <= '1';
            elsif (i_cnt1_we = '1' and i_cnt1_set_reset = '0') then
               s_ce_latch     <= '0';
            end if;

            if (s_ce_latch = '1') then
               if (v_cnt = G_COUNTER_VALUE) then
                  v_cnt             := 0;
                  o_cnt1_overflow   <= '1';
               else
                  v_cnt             := v_cnt + 1;
                  o_cnt1_overflow   <= '0';
               end if;
            else
               v_cnt                := 0;
               o_cnt1_overflow      <= '0';
            end if;
         end if;
         o_cnt1_q    <= v_cnt;
      end if;
   end process;


end architecture;
