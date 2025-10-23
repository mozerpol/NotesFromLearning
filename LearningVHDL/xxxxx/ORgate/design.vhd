-- Simple OR gate design

library IEEE; -- library defines how keywords behave in file
  use IEEE.std_logic_1164.all;

-- Below entity is called "or_gate"

entity or_gate is        -- entity contains a port that defines all inputs and outputs to a file.
  port (
    a : in    std_logic; -- std_logic - type
    b : in    std_logic;
    q : out   std_logic
  );
end entity or_gate;

-- architecture is used to describe the functionality of a particular entity.
-- It is possible to have multiple architecture blocks associated with one
-- entity block, but only one architecture block is selected for a given entity
-- during simulation or synthesis.

architecture rtl of or_gate is -- architecture is called "rtl" of entity "or_gate"

begin

  process_or : process (a, b) is
  begin            -- Code inside the process statement is executed sequentially

    q <= a or b; -- "q" - it's output, "input_1", "input_2" - inputs.

  end process process_or;

end architecture rtl;
