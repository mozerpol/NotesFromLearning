-- Simple OR gate design
library IEEE; -- library defines how keywords behave in file
use IEEE.std_logic_1164.all;

-- Below entity is called "or_gate"
entity or_gate is -- entity contains a port that defines all inputs and outputs to a file.
port(
  a: in std_logic; -- std_logic - type
  b: in std_logic;
  q: out std_logic
  );
end or_gate;

-- architecture is used to describe the functionality of a particular entity
architecture rtl of or_gate is -- architecture is called "rtl" of entity "or_gate" 
begin
  process(a, b) is
  begin
    q <= a or b; -- "q" - it's output, "input_1", "input_2" - inputs.
  end process;
end rtl;
