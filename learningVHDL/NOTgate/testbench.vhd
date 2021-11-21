library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is 
  end testbench;

  architecture tb of testbench is
    component not_gate is
      port(
        a: in std_logic;
        b: out std_logic;
      );
    end component;

      signal a_in, b_out: std_logic;

  begin

    DUT: not_gate port map(a_in, b_out);

process begin
  a_in <= '0';
  wait for 1 ns;
  a_in <= '1';
wait for 1 ns;
  a_in <= 'X';
wait for 1 ns;
  -- Clear inputs
  a_in <= '0';
wait;
end process;
  end tb;
