library IEEE; -- IEEE 1164 standard describes the definitions of logic values
  use IEEE.std_logic_1164.all;
  -- std_logic_1164 package defines functions for logical operators applied to
  -- values of type std_ulogic and std_ulogic_vector. We can use them in
  -- functional models to write Boolean equations that represent the behavior of
  -- a design.
  -- library <library_name>;
  -- use <library_name>.<packet_name>.all;
entity dff is port (       -- entity is used to describe a hardware module,
    -- contains a port that defines all inputs and outputs to a file.
    clk : in    std_logic; -- <signal_name> : <direction> <logic_type>
    d   : in    std_logic; -- std_logic type is used to hold a single bit
    q   : out   std_logic
  );
end entity dff;

architecture rtl of dff is -- architecture is called "rtl" of entity "dff"

  -- Architecture statement defines the structure or description of a design and
  -- is bounded with an entity. Defines how the entity blocks should behave, or
  -- what they should consist of. Inside architecture all processes, functions
  -- and procedures are executed simultaneously. It is possible to have multiple
  -- architecture blocks associated with one entity block, but only one architecture
  -- block is selected for a given entity during simulation or synthesis.

begin

  dff_process : process (clk) is -- process (<optional_sensitivity_list>).
    -- Code inside the process statement is executed sequentially
  begin

    if (clk'event and clk = '1') then -- Condition will be true, when the
      -- actual value of the signal is '1' and there was an event on it (the
      -- value changed recently). An event on a signal is a change of the
      -- signal's value.
      q <= d;
    end if;

  end process dff_process;

end architecture rtl;
