-- SR flip-flop or RS flip-flop
-- It's the easiest flip-flop. We have two possible states:
-- 1. s - set = 1, r - reset = 0, then q = 1
-- 2. s - set = 0, r - reset = 1, then q = 0
-- The state when s = 1, r = 1 is not allowed.

library ieee;
  use ieee.std_logic_1164.all;

entity srff is
  port (
    clk : in    std_logic;
    s   : in    std_logic;
    r   : in    std_logic;
    q   : out   std_logic
  );
end entity srff;

architecture rtl of srff is

begin

  srff_process : process (clk) is

    variable q_reg         : std_logic;
    variable v_concatenate : std_logic_vector(1 downto 0);

  begin

    if (clk'event and clk = '1') then
      v_concatenate := s & r;

      case v_concatenate is

        when "00" =>
          q_reg := q_reg;
        when "01" =>
          q_reg := '0';
        when "10" =>
          q_reg := '1';
        when "11" =>
          q_reg := 'X';
        when others =>
          q_reg := 'X';

      end case;

    end if;

    q <= q_reg;

  end process srff_process;

end architecture rtl;
