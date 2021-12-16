library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all; -- Thanks to this packages we can do
  -- "std_logic_vector + 1;"
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component simpleram is
    port (
      clk  : in    std_logic;
      we   : in    std_logic;
      re   : in    std_logic;
      addr : in    std_logic_vector(4 downto 0);
      data : inout std_logic_vector(7 downto 0)
    );
  end component;

  signal clk_in : std_logic := '0';
  signal we     : std_logic;
  signal re     : std_logic;
  signal addr   : std_logic_vector(4 downto 0) := (others => '0');
  signal data   : std_logic_vector(7 downto 0) := (others => '0');

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
    we <= '1';
    re <= '1';

    for i in 0 to 4 loop
      wait for 10 ns;
      addr <= addr + 1;
      data <= data + 1;
    end loop;

    wait for 10 ns;
    re <= '1';
    we <= '0';

    for i in 0 to 4 loop
      wait for 10 ns;
      addr <= addr + 1;
    end loop;

    wait for 10 ns;
    stop;

  end process tb_process;

  clk_process : process is
  begin

    clk_in <= not(clk_in);
    wait for 10 ns;

  end process clk_process;

end architecture tb;
