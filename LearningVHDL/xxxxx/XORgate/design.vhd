library IEEE; -- Libraries are made up of packages, while packages are made up
  -- of shared elements (e.g. type declarations, procedure functions, operators,
  -- etc.).
  use IEEE.std_logic_1164.all;
  -- library <library_name>;
  -- use <library_name>.<packet_name>.all;

entity xor_gate is -- entity is used to describe a hardware module, it
  -- specifies the name of entity and interface ports
  port (
    a : in    std_logic;
    b : in    std_logic;
    c : out   std_logic
  );
end entity xor_gate;

architecture rtl of xor_gate is

begin

  process_xor : process (a, b) is
  begin

    c <= a xor b;

  end process process_xor;

end architecture rtl;
