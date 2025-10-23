library IEEE;
  use IEEE.std_logic_1164.all;
  -- std_logic_1164 package defines functions for logical operators applied to
  -- values of type std_ulogic and std_ulogic_vector. We can use them in
  -- functional models to write Boolean equations that represent the behavior of
  -- a design.

entity not_gate is       -- entity is used to describe a hardware module
  port (
    a : in    std_logic; -- <signal_name> : <direction> <logic_type>
    b : out   std_logic  -- std_logic type is used to hold a single bit
  );
end entity not_gate;

architecture rtl of not_gate is

  -- architecture defines how the entity blocks should behave, or what they
  -- should consist of. Inside architecture all processes, functions and
  -- procedures are executed simultaneously

begin

  process_not : process (a) is -- inside process instructions are executed
    -- sequentially.
  begin

    b <= not a;

  end process process_not;

end architecture rtl;
