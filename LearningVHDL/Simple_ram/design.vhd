library ieee;
   use ieee.std_logic_1164.all;


entity simpleram is
   generic (
      data_size   : integer := 8;
      data_depth  : integer := 5
  ); port (
      clk      : in std_logic;
      we       : in std_logic;
      addr     : in integer range 0 to data_depth - 1;
      data_in  : in std_logic_vector(data_size - 1 downto 0);
      data_out : out std_logic_vector(data_size - 1 downto 0)
   );
end entity simpleram;


architecture rtl of simpleram is


  type mem_type is array (0 to data_depth - 1) of
                                       std_logic_vector(data_size - 1 downto 0);
  signal memory : mem_type;
  signal q : std_logic_vector(data_size - 1 downto 0);


begin


   data_out <= q;

   ram_process : process (clk) is
   begin
      if (clk'event and clk = '1') then
         if (we = '1') then
            memory(addr) <= data_in;
         else
            q <= memory(addr);
         end if;
      end if;
  end process ram_process;


end architecture rtl;
