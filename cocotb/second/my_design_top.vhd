library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library work;
   use work.all;
   use work.my_design_pkg.all;

entity my_design is
   generic (
      G_DATA_WIDTH : integer := 5
   );
   port (
      i_clk    : in std_logic;
      i_select : in std_logic_vector(1 downto 0);
      i_data   : in std_logic_vector(G_DATA_WIDTH-1 downto 0);
      o_data   : out std_logic_vector(C_DATA_WIDTH-1 downto 0)
   );
end entity my_design;

architecture rtl of my_design is

   signal internal_signal : std_logic;

begin

   internal_signal <= '1' when i_data = "0100" else '0';

   process (i_clk) is
   begin
      if (i_clk = '1' and i_clk'event) then
         case i_select is
            when "00" => o_data <= "00001";
            when "01" => o_data <= "00010";
            when "10" => o_data <= "00100";
            when "11" => o_data <= "01000";
            when others => o_data <= (others => '0');
         end case;
      end if;
   end process;

end architecture rtl;
