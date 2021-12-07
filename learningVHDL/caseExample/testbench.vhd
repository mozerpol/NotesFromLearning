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

  end process tb_process;

end architecture tb;
