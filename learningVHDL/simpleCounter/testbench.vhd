library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component simplecounter is
    port (
      clk : in    std_logic;
      q   : out   std_logic
    );
  end component;

  signal   clk_in      : std_logic := '0';
  constant count_up_to : integer := 12;
  signal   q_out       : std_logic;

begin

  dut : component simplecounter
    generic map (
      count_up_to => count_up_to
    )
    port map (
      clk => clk_in,
      q   => q_out
    );

  tb_process : process is
  begin

    wait for 10 ns; stop;

  end process tb_process;

  always_process : process is
  begin

    wait for 1 ns; clk_in <= not(clk_in);

  end process always_process;

end architecture tb;
