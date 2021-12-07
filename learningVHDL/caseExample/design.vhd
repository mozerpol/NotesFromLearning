library ieee;
  use ieee.std_logic_1164.all;

entity caseexample is port (
    clk    : in    std_logic;
    option : in    std_logic;
    q      : out   std_logic
  );
end entity caseexample;

architecture rtl of caseexample is

begin

  case_process : process (clk) is
  begin

    if (clk'event and clk = '1') then
    end if;

  end process case_process;

end architecture rtl;
