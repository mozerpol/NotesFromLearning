library ieee;
  use ieee.std_logic_1164.all;

entity defineexample is port (
    clk : in    std_logic
  );
end entity defineexample;

architecture rtl of defineexample is

  -- constant <constant_name> : <type> := <value>;
  constant const_var : integer := 8;

begin

  defineexample_process : process (clk) is
  begin

    if (clk'event and clk = '1') then
      -- if body
    end if;

  end process defineexample_process;

end architecture rtl;
