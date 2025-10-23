library IEEE;
  use IEEE.std_logic_1164.all;
  use std.env.stop;

entity testbench is -- The top-level entity in a simulateable VHDL model is
  -- usually "empty", i.e. has no ports
end entity testbench;

architecture tb of testbench is

  -- Architecture statement defines the structure or description of a design and
  -- is bounded with an entity
  component dff is
    -- The component declaration describes the interface of a component with its
    -- environment
    port (
      clk : in    std_logic;
      d   : in    std_logic;
      q   : out   std_logic
    );
  end component;

  signal clk_in : std_logic := '0';
  signal d_in   : std_logic;
  signal q_out  : std_logic; --  Signal assignment statements execute only
  -- when the associated signals (on the right side) change values.

begin

  dut : component dff
    port map (
      clk => clk_in,
      d   => d_in,
      q   => q_out
    );

  tb_process : process is
  begin

    wait for 10 ns; d_in <= '1';
    wait for 35 ns; d_in <= '0';
    wait for 40 ns; d_in <= '1';
    wait for 35 ns; d_in <= '0';
    wait for 30 ns; d_in <= '1';
    wait for 5 ns; d_in  <= '0';
    wait for 5 ns; d_in  <= '1';
    wait for 20 ns;
    stop;

  end process tb_process;

  always_process : process is
  begin

    clk_in <= not(clk_in);
    wait for 10 ns;

  end process always_process;

end architecture tb;
