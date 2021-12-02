library ieee;
  use ieee.std_logic_1164.all;

entity simplecounter is
  generic (
    count_up_to : integer := 8
  );
  port (
    clk : in    std_logic;
    q   : out   std_logic
  );
end entity simplecounter;

architecture rtl of simplecounter is

begin

  simplecounter_process : process (clk) is
  begin

    if (clk'event and clk = '1') then
    end if;

  end process simplecounter_process;

end architecture rtl;
