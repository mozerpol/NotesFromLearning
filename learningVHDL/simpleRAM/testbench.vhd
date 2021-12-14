library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  signal clk_in : std_logic := '0';

begin

  dut : component simpleram
    port map (
      clk => clk_in
    );

  tb_process : process is
  begin

  end process tb_process;

end architecture tb;
