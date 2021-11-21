library IEEE;
use IEEE.std_logic_1164.all;

entity xor_gate is -- entity is used to describe a hardware module, it 
-- specifies the name of entity and interface ports
  port(
    a: in std_logic;
    b: in std_logic;
    c: out std_logic;
  );
end xor_gate;

architecture rtl of xor_gate is
  begin
    process(a, b) is
      begin 
        c <= a xor b;
    end process;
end rtl;
