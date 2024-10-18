library ieee; -- IEEE 1164 standard describes the definitions of logic values
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity and_gate is port ( -- entity is used to describe a hardware module
    a : in    std_logic;
    b : in    std_logic;
    c : out   std_logic
  );
end entity and_gate;

architecture rtl of and_gate is

begin

  process_and : process (a, b) is
  begin             -- Code inside the process statement is executed sequentially

    c <= a and b;

  end process process_and;

end architecture rtl;
