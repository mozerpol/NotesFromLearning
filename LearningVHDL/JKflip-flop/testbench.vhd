library IEEE;
  use IEEE.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component jkff is
    port (
      clk : in    std_logic;
      j   : in    std_logic;
      k   : in    std_logic;
      q   : out   std_logic
    );
  end component;

  signal clk_in : std_logic := '0';
  signal j_in   : std_logic;
  signal k_in   : std_logic;
  signal q_out  : std_logic;

begin

  dut : component jkff
    port map (
      clk => clk_in,
      j   => j_in,
      k   => k_in,
      q   => q_out
    );

  tb_process : process is
  begin

    wait for 10 ns;
    j_in <= '0';
    k_in <= '0';
    wait for 20 ns;
    j_in <= '1';
    k_in <= '0';
    wait for 20 ns;
    j_in <= '0';
    k_in <= '1';
    wait for 8 ns;
    j_in <= '0';
    k_in <= '0';
    wait for 8 ns;
    j_in <= '1';
    k_in <= '0';
    wait for 4 ns;
    j_in <= '1';
    k_in <= '1';
    wait for 40 ns;
    j_in <= '0';
    k_in <= '0';
    wait for 40 ns; stop;

  end process tb_process;

  always_process : process is
  begin

    clk_in <= not(clk_in);
    wait for 10 ns;

  end process always_process;

end architecture tb;
