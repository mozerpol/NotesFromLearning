library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.math_real.all;

entity or_gate is
  port (
    i_a_or : in    std_logic;
    i_b_or : in    std_logic;
    o_c_or : out   std_logic
  );
end entity or_gate;

architecture rtl of or_gate is
begin

  p_or : process (i_a_or, i_b_or)
  begin
    case i_a_or & i_b_or is
     when "00" =>
        o_c_or <= '0';
     when "01" =>
        o_c_or <= '1';
     when "10" =>
        o_c_or <= '1';
     when "11" =>
        o_c_or <= '1';
     when others =>
        o_c_or <= '0';
    end case;
  end process p_or;


end architecture rtl;







