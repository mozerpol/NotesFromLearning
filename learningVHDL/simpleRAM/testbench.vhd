library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component simpleram is
    port (
      clk  : in    std_logic;
      we   : in    std_logic;
      re   : in    std_logic;
      addr : in    std_logic_vector(11 downto 0);
      data : inout std_logic_vector(7 downto 0)
    );
  end component;

  signal clk_in : std_logic := '0';
  signal we     : std_logic;
  signal re     : std_logic;
  signal addr   : std_logic_vector(11 downto 0);
  signal data   : std_logic_vector(7 downto 0);

begin

  dut : component simpleram
    port map (
      clk  => clk_in,
      we   => we,
      re   => re,
      addr => addr,
      data => data
    );

  tb_process : process is
  begin

    wait for 10 ns;
    stop;

  end process tb_process;

end architecture tb;
