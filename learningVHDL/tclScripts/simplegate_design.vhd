library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;

entity simplegate is
  port (
    i_a : in    std_logic;
    o_b : out   std_logic
  );
end entity simplegate;

architecture rtl of simplegate is

signal c : std_logic;

begin

  p_gate : process (i_a) is
  begin

    if (i_a = '1') then
        o_b <= '0';
        c <= '1';
    else
        o_b <= '1';
        c <= '0';     
    end if;

  end process p_gate;


end architecture rtl;







