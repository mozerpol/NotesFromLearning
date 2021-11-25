library ieee;
  use ieee.std_logic_1164.all;

entity tff is port (
    clk : in    std_logic;
    t   : in    std_logic;
    q   : out   std_logic
  );
end entity tff;

architecture rtl of tff is

begin

  tff_process : process (clk) is

    variable q_reg : std_logic := '0';

  begin

    if (clk'event and clk = '1') then
      if (t = '1') then
        q_reg := not(q_reg);
      end if;
    end if;

    q <= q_reg;

  end process tff_process;

end architecture rtl;