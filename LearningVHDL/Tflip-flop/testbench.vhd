library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component tff is
    port (
      clk : in    std_logic;
      t   : in    std_logic;
      q   : out   std_logic
    );
  end component tff;

  signal clk_in : std_logic := '0';
  signal t_in   : std_logic;
  signal q_out  : std_logic;

begin

  dut : component tff
    port map (
      clk => clk_in,
      t   => t_in,
      q   => q_out
    );

  tb_process : process is
  begin

    wait for 10 ns; t_in <= '0';
    wait for 40 ns; t_in <= '1';
    wait for 40 ns; t_in <= '0';
    wait for 40 ns; t_in <= '1';
    wait for 5 ns; t_in  <= '0';
    wait for 5 ns; t_in  <= '1';
    wait for 40 ns; stop;

  end process tb_process;

  always_process : process is
  begin

    clk_in <= not(clk_in);
    wait for 10 ns;

  end process always_process;

end architecture tb;