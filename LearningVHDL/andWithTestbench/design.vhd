library ieee;
  use ieee.std_logic_1164.all;

entity gate is port (
    in1  : in    std_logic;
    in2  : in    std_logic;
    out1 : out   std_logic
  );
end entity gate;

architecture rtl of gate is

begin

  out1 <= (in1 and in2);

end architecture rtl;