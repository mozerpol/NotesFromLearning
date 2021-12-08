library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

begin

  tb_process : process is
  begin

    stop;

  end process tb_process;

end architecture tb;
