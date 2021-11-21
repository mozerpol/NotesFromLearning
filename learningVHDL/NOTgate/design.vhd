library IEEE;
use IEEE.std_logic_1164.all;

entity not_gate is
  port(
    a: in std_logic;
    b: out std_logic;
  );
end not_gate;

architecture rtl of not_gate is
begin
  process(a) is
    begin
      b <= not a;
    end process;
end rtl;
