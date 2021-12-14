library ieee;
  use ieee.std_logic_1164.all;

entity simpleram is generic (
    wordsize    : integer := 8;
    addresssize : integer := 32;
    w           : integer := 12
  );
  port (
    clk  : in    std_logic;
    we   : in    std_logic;
    re   : in    std_logic;
    addr : in    std_logic_vector(w - 1 downto 0);
    data : inout std_logic_vector(7 downto 0)
  );
end entity simpleram;

architecture rtl of simpleram is

begin

  simpleram_process : process (clk) is
  begin

  end process simpleram_process;

end architecture rtl;
