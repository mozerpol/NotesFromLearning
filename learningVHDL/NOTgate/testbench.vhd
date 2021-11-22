library IEEE;
  use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component not_gate is
    -- component declaration describes the interface of a component with its
    -- environment
    port (
      a : in    std_logic;
      b : out   std_logic
    );
  end component;

  signal a_in, b_out : std_logic; --  Signal assignment statements execute only
  -- when the associated signals (on the right side) change values.

begin

  dut : component not_gate
    -- The component declaration describes the interface of a component with its
    -- environment
    port map (
      a => a_in,
      b => b_out
    );

  process_tb : process is
  begin

    a_in <= '0';
    wait for 1 ns;
    -- Have a few possibilities of delays:
    -- wait for <time>;
    -- wait
    -- wait on <signal_list>;
    -- wait until <condition>;
    -- More here: https://www.ics.uci.edu/~jmoorkan/vhdlref/waits.html
    a_in <= '1';
    wait for 1 ns;
    a_in <= 'X';
    wait for 1 ns;
    -- Clear inputs
    a_in <= '0';
    wait;

  end process process_tb;

end architecture tb;
