library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component caseexample is
    port (
      clk    : in    std_logic;
      option : in    std_logic;
      q      : out   std_logic
    );
  end component;

  signal clk_in    : std_logic := '0';
  signal option_in : std_logic;
  signal q_out     : std_logic;

begin

  dut : component caseexample
    port map (
      clk    => clk_in,
      option => option_in,
      q      => q_out
    );

  tb_process : process is
  begin

    wait for 5 ns;
    option_in <= '0';
    wait for 5 ns;
    option_in <= '1';
    wait for 5 ns;
    option_in <= 'U';
    wait for 5 ns;
    option_in <= '0';
    wait for 5 ns;
    option_in <= 'W';
    wait for 5 ns;
    stop;

  end process tb_process;

  always_process : process is
  begin

    wait for 1 ns;
    clk_in <= not(clk_in);

  end process always_process;

end architecture tb;
