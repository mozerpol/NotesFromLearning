library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
library std;
  use std.env.all;

entity or_gate_tb is
end entity or_gate_tb;

architecture tb of or_gate_tb is

  component or_gate is
  port (
    i_a_or : in    std_logic;
    i_b_or : in    std_logic;
    o_c_or : out   std_logic
  );
  end component;

  signal a_or : std_logic;
  signal b_or : std_logic;
  signal c_or : std_logic;

begin

  dut : component or_gate
    port map (
      i_a_or => a_or,
      i_b_or => b_or,
      o_c_or => c_or 
    );

  p_tb : process is
  begin
    wait for 25 ns;
    a_or <= '0';
    b_or <= '0';
    wait for 25 ns;
    a_or <= '0';
    b_or <= '1';
    wait for 25 ns;
    a_or <= '1';
    b_or <= '0';
    wait for 25 ns;
    a_or <= '1';
    b_or <= '1';
    wait for 25 ns;
    stop(2);
  end process p_tb;

end architecture tb;












