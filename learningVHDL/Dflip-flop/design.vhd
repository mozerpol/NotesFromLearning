library IEEE;
  use IEEE.std_logic_1164.all;

entity dff is port (
    clk : in    std_logic;
    d   : in    std_logic;
    q   : out   std_logic
  );
end entity dff;

architecture rtl of dff is

begin

  dff_process : process (clk) is
  begin

    if (clk'event and clk = '1') then
      q <= d;
    end if;

  end process dff_process;

end architecture rtl;
