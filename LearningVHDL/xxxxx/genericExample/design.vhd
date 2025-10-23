library ieee;
  use ieee.std_logic_1164.all;

entity genericexample is
  generic (
    count_width : integer := 8
  );
  port (
    clk : in    std_logic
  );
end entity genericexample;

architecture rtl of genericexample is

  signal r_row : natural range 0 to count_width;

begin

  generic_process : process (clk) is
  begin

    if (clk'event and clk = '1') then
      -- if body
    end if;

  end process generic_process;

end architecture rtl;