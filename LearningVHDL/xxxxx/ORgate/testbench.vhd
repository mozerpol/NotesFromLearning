-- Testbench for OR gate

library IEEE;
  use IEEE.std_logic_1164.all;

entity testbench is
  -- empty
end entity testbench;

architecture tb of testbench is

  -- DUT component, component <component_name>
  component or_gate is
    port (
      a : in    std_logic;
      b : in    std_logic;
      q : out   std_logic
    );
  end component;

  signal a_in  : std_logic;
  signal b_in  : std_logic;
  signal q_out : std_logic;

begin

  -- Connect DUT
  dut : component or_gate
    port map (
      a => a_in,
      b => b_in,
      q => q_out
    );

  process_tb : process is
  begin

    a_in <= '0';
    b_in <= '0';
    wait for 1 ns;
    assert(q_out='0')     -- assert statement tests the boolean condition. If
      -- this is false, it outputs a message containing the reopirt string to
      -- the simulator screen.
      report "Fail 0/0"   -- report <message_string> [severity <severity_level>];
      severity error;     -- The severity level may be defined as note, warning,
    -- error or failure Level failure normally aborts the simulation.

    a_in <= '0';
    b_in <= '1';
    wait for 1 ns;
    assert(q_out='1')
      report "Fail 0/1"
      severity error;

    a_in <= '1';
    b_in <= 'X';
    wait for 1 ns;
    assert(q_out='1')
      report "Fail 1/X"
      severity error;

    a_in <= '1';
    b_in <= '1';
    wait for 1 ns;
    assert(q_out='1')
      report "Fail 1/1"
      severity error;

    -- Clear inputs
    a_in <= '0';
    b_in <= '0';

    assert false
      report "Test done."
      severity note;
    wait;

  end process process_tb;

end architecture tb;
