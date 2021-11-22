library IEEE;
  use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component xor_gate is
    port (
      a : in    std_logic;
      b : in    std_logic;
      c : out   std_logic
    );
  end component;

  signal a_in  : std_logic;
  signal b_in  : std_logic;
  signal c_out : std_logic;

begin

  dut : component xor_gate
    port map (
      a => a_in,
      b => b_in,
      c => c_out
    );

  process_tb : process is
  begin

    a_in <= '0';
    b_in <= '0';
    wait for 1 ns;
    a_in <= '0';
    b_in <= '1';
    wait for 1 ns;
    a_in <= '1';
    b_in <= '0';
    wait for 1 ns;
    a_in <= '1';
    b_in <= '1';
    wait for 1 ns;
    a_in <= 'X';
    wait for 1 ns;
    -- Clear inputs
    a_in <= '0';
    b_in <= '0';
    wait;

  end process process_tb;

end architecture tb;
