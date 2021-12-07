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

      case option is

        when '0' =>
          q <= '0';
        when '1' =>
          q <= '1';
        when 'U' =>
          q <= 'U';
        when others =>
          q <= 'Z';

      end case;

    end if;

  end process case_process;

end architecture rtl;
