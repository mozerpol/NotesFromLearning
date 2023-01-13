library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
library std;
use std.env.all;

entity simplegate_tb is
end entity simplegate_tb;

architecture tb of simplegate_tb is

  component simplegate is
      port (
        i_a : in    std_logic;
        o_b : out   std_logic
      );
  end component;

  signal a : std_logic;
  signal b : std_logic;

begin

  dut : component simplegate
    port map (
      i_a => a,
      o_b => b 
    );

  p_tb : process is
  begin

    wait for 25 ns;
    a <= '0';
    wait for 25 ns;
    a <= '1';
    wait for 25 ns;
    a <= '0';
    
    stop(2);
  end process p_tb;

end architecture tb;












