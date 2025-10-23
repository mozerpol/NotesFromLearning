library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component counter is
    generic (
      n : integer
    );
    port (
      clk : in    std_logic;
      rst : in    std_logic;
      ce  : in    std_logic;
      ov  : out   std_logic
    );
  end component;

  constant n      : integer := 10;
  signal   clk_in : std_logic := '0';
  signal   rst    : std_logic;
  signal   ce     : std_logic;
  signal   ov     : std_logic;

begin

  dut : component counter
    generic map (
      n => n
    )
    port map (
      clk => clk_in,
      rst => rst,
      ce  => ce,
      ov  => ov
    );

  tb_process : process is
  begin

    wait for 25 ns; stop;

  end process tb_process;

  always_process : process is
  begin

    wait for 1 ns; clk_in <= not(clk_in);

  end process always_process;

end architecture tb;
