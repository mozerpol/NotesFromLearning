library ieee;
  use ieee.std_logic_1164.all;

entity simpleram is generic (
    wordsize    : integer := 8;
    addresssize : integer := 32;
    w           : integer := 12
  );
  port (
    clk  : in    std_logic;
    we   : in    std_logic; -- Write enable
    re   : in    std_logic; -- Read enable
    addr : in    std_logic_vector(w - 1 downto 0);
    data : inout std_logic_vector(7 downto 0)
  );
end entity simpleram;

architecture rtl of simpleram is

  type mem_type is array (0 to addresssize - 1) of std_logic_vector(wordsize - 1 downto 0);

  signal memory   : mem_type;
  signal addr_int : integer := 0;

begin

  simpleram_process : process (clk) is
  begin

    if (clk'event and clk = '1') then
      if ((re and not(we)) = '1') then
        data <= memory(addr_int);
      else
        data <= "ZZZZZZZZ";
      end if;
    end if;

  end process simpleram_process;

end architecture rtl;
