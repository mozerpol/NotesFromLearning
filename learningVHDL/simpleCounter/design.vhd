library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  use ieee.numeric_std.all;

entity simplecounter is
  generic (
    count_up_to : integer := 8
  );
  port (
    clk : in    std_logic;
    q   : out   std_logic := '0'
  );
end entity simplecounter;

architecture rtl of simplecounter is

  constant vector_length : integer := integer(ceil(log2(real(count_up_to) + real(1))));
  signal   counter       : std_logic_vector(vector_length downto 0);

begin

  simplecounter_process : process (clk) is
  begin

    if (clk'event and clk = '1' and count_up_to /= counter) then
      counter <= counter + 1;
    end if;

    if (count_up_to = counter) then
      q <= '1';
    end if;

  end process simplecounter_process;

end architecture rtl;
