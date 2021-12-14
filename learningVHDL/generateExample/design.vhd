library IEEE;
  use IEEE.std_logic_1164.all;

entity generate_design is port (
    clk : in    std_logic
  );
end entity generate_design;

architecture rtl of generate_design is

  signal pattern_vector : std_logic_vector(0 to 4) := ('0', '1', '1', '0', '1');
  signal empty_vector   : std_logic_vector(0 to 4);

begin

  g_generate_for : for i in 0 to 4 generate
    empty_vector(i) <= pattern_vector(i);
  end generate g_generate_for;

  generate_process : process (clk) is
  begin

  end process generate_process;

end architecture rtl;
