library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component defineexample is
    port (
      clk : in    std_logic
    );
  end component;

  signal clk_in : std_logic := '0';

begin

  dut : component defineexample
    port map (
      clk => clk_in
    );

  tb_process : process is
  begin

    wait for 10 ns;
    stop;

  end process tb_process;

  always_process : process is
  begin

    wait for 1 ns; clk_in <= not(clk_in);

  end process always_process;

end architecture tb;
