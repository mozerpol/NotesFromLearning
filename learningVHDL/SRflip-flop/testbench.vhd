library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component srff is
    port (
      clk : in    std_logic;
      s   : in    std_logic;
      r   : in    std_logic;
      q   : out   std_logic
    );
  end component;

  signal clk_in : std_logic := '0';
  signal s_in   : std_logic;
  signal r_in   : std_logic;
  signal q_out  : std_logic;

begin

  dut : component srff
    port map (
      clk => clk_in,
      s   => s_in,
      r   => r_in,
      q   => q_out
    );

  tb_process : process is
  begin

    wait for 10 ns; s_in <= '1';
    r_in                 <= '0';
    wait for 20 ns; s_in <= '0';
    r_in                 <= '1';
    wait for 20 ns; s_in <= '0';
    r_in                 <= '0';
    wait for 20 ns; s_in <= '1';
    r_in                 <= '1';
    wait for 40 ns; stop;

  end process tb_process;

  always_process : process is
  begin

    clk_in <= not(clk_in);
    wait for 10 ns;

  end process always_process;

end architecture tb;
