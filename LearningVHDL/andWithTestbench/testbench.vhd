library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component gate is
    port (
      in1  : in    std_logic;
      in2  : in    std_logic;
      out1 : out   std_logic
    );
  end component;

  signal in1_tb  : std_logic;
  signal in2_tb  : std_logic;
  signal out1_tb : std_logic;

  signal s1 : std_logic := '1';

begin

  dut : component gate
    port map (
      in1  => in1_tb,
      in2  => in2_tb,
      out1 => out1_tb
    );

  tb_process : process is
  begin

    in1_tb <= '0';
    in2_tb <= '0';
    wait for 1 ns;
    report "int1_tb: " & std_logic'image(in1_tb) &
           "; int2_tb: " & std_logic'image(in2_tb) &
           "; out1_tb: " & std_logic'image(out1_tb);
    in1_tb <= '0';
    in2_tb <= '1';
    wait for 1 ns;
    report "int1_tb: " & std_logic'image(in1_tb) &
           "; int2_tb: " & std_logic'image(in2_tb) &
           "; out1_tb: " & std_logic'image(out1_tb);
    in1_tb <= '1';
    in2_tb <= '0';
    wait for 1 ns;
    report "int1_tb: " & std_logic'image(in1_tb) &
           "; int2_tb: " & std_logic'image(in2_tb) &
           "; out1_tb: " & std_logic'image(out1_tb);
    in1_tb <= '1';
    in2_tb <= '1';
    wait for 1 ns;
    report "int1_tb: " & std_logic'image(in1_tb) &
           "; int2_tb: " & std_logic'image(in2_tb) &
           "; out1_tb: " & std_logic'image(out1_tb);
    wait;

  end process tb_process;

end architecture tb;