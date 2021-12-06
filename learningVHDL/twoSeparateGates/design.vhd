library ieee;
  use ieee.std_logic_1164.all;

entity and_area is port (
    in1      : in    std_logic;
    in2      : in    std_logic;
    out1_and : out   std_logic
  );
end entity and_area;

architecture rtl of and_area is

begin

  and_process : process is
  begin

    out1_and <= in1 & in2;

  end process and_process;

end architecture rtl;

library ieee;
  use ieee.std_logic_1164.all;
entity gates_area is port (
    in1    : in    std_logic;
    in2    : in    std_logic;
    in3    : in    std_logic;
    out_or : out   std_logic
  );
end entity gates_area;

architecture rtl2 of gates_area is

begin

  gates_process : process is
  begin

  end process gates_process;

end architecture rtl2;
