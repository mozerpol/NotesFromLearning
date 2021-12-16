library ieee;
  use ieee.std_logic_1164.all;
  USE ieee.numeric_std.ALL; -- Thanks to this we can use "to_integer"

entity simpleram is generic (
    wordsize    : integer := 8;
    addresssize : integer := 32;
    w           : integer := 5
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

  type mem_type is array (0 to addresssize - 1) of 
  std_logic_vector(wordsize - 1 downto 0); 

  signal memory   : mem_type := (others => x"00");
  signal addr_int : integer := 0;

begin

  simpleram_process : process (clk) is
  begin

    if (rising_edge(clk)) then
      if ((re and not(we)) = '1') then
        data <= memory(to_integer(unsigned(addr)));
      elsif ((we and not(re)) = '1') then
       memory(to_integer(unsigned(addr))) <= data;
      else
        data <= "ZZZZZZZZ";
      end if;
    end if;

  end process simpleram_process;

end architecture rtl;
