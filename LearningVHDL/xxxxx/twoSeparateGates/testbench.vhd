library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  component gates_area is
    port (
      in1    : in    std_logic;
      in2    : in    std_logic;
      in3    : in    std_logic;
      out_or : out   std_logic
    );
  end component;

  signal in1    : std_logic;
  signal in2    : std_logic;
  signal in3    : std_logic;
  signal out_or : std_logic;

begin

  dut : component gates_area
    port map (
      in1    => in1,
      in2    => in2,
      in3    => in3,
      out_or => out_or
    );

  tb_process : process is
  begin

    wait for 1 ns;
    in1 <= '0';
    in2 <= '0';
    in3 <= '0'; -- out_or should return: 0
    wait for 1 ns;
    report "time: " & time'image(now) &
           "; int1: " & std_logic'image(in1) &
           "; int2: " & std_logic'image(in2) &
           "; out_or: " & std_logic'image(out_or);
    in1 <= '0';
    in2 <= '1';
    in3 <= '1'; -- out_or should return: 1
    wait for 1 ns;
    report "time: " & time'image(now) &
           "; int1: " & std_logic'image(in1) &
           "; int2: " & std_logic'image(in2) &
           "; out_or: " & std_logic'image(out_or);
    in1 <= '1';
    in2 <= '0';
    in3 <= '0'; -- out_or should return:  0
    wait for 1 ns;
    report "time: " & time'image(now) &
           "; int1: " & std_logic'image(in1) &
           "; int2: " & std_logic'image(in2) &
           "; out_or: " & std_logic'image(out_or);
    in1 <= '1';
    in2 <= '1';
    in3 <= '1'; -- out_or should return: 1
    wait for 1 ns;
    report "time: " & time'image(now) &
           "; int1: " & std_logic'image(in1) &
           "; int2: " & std_logic'image(in2) &
           "; out_or: " & std_logic'image(out_or);
    stop;

  end process tb_process;

end architecture tb;