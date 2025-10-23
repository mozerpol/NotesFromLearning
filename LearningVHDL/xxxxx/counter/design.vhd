library ieee;
  use ieee.std_logic_1164.all;

entity counter is
  generic (
    n : integer 10
  );
  port (
    clk : in    std_logic;
    rst : in    std_logic;
    ce  : in    std_logic;
    ov  : out   std_logic
  );
end entity counter;

architecture rtl of counter is

begin

  counter_process : process (clk) is
  begin

    if (clk'event and clk = '1') then
    end if;

  end process counter_process;

end architecture rtl;
