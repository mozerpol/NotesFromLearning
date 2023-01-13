library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
library std;
  use std.env.all;

entity and_gate_tb is
end entity and_gate_tb;

architecture tb of and_gate_tb is

  component and_gate is
  port (
    i_a_and : in    std_logic;
    i_b_and : in    std_logic;
    o_c_and : out   std_logic
  );
  end component;

  signal a_and : std_logic;
  signal b_and : std_logic;
  signal c_and : std_logic;

begin

  dut : component and_gate
    port map (
      i_a_and => a_and,
      i_b_and => b_and,
      o_c_and => c_and 
    );

  p_tb : process is
  begin
    wait for 25 ns;
    a_and <= '0';
    b_and <= '0';
    wait for 25 ns;
    a_and <= '0';
    b_and <= '1';
    wait for 25 ns;
    a_and <= '1';
    b_and <= '0';
    wait for 25 ns;
    a_and <= '1';
    b_and <= '1';
    wait for 25 ns;
    stop(2);
  end process p_tb;

end architecture tb;












