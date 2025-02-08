library ieee;
   use ieee.std_logic_1164.all;


entity and_gate is
   port (
      i_a_and : in    std_logic;
      i_b_and : in    std_logic;
      o_c_and : out   std_logic
   );
end entity and_gate;


architecture rtl of and_gate is
begin


   p_and : process (i_a_and, i_b_and)
   begin
      case i_a_and & i_b_and is
         when "00" => o_c_and <= '0';
         when "01" => o_c_and <= '0';
         when "10" => o_c_and <= '0';
         when "11" => o_c_and <= '1';
         when others => o_c_and <= '0';
      end case;
   end process p_and;


end architecture rtl;
