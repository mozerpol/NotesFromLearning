library IEEE; -- IEEE 1164 standard describes the definitions of logic values
  use IEEE.std_logic_1164.all;

entity and_gate is port ( -- entity is used to describe a hardware module
    a : in    std_logic;  -- <signal_name> : <direction> <logic_type>
    b : in    std_logic;
    c : out   std_logic
  );
end entity and_gate;

architecture rtl of and_gate is

begin

  process_and : process (a, b) is -- process (<optional_sensitivity_list>)
  begin             -- Code inside the process statement is executed sequentially

    c <= a and b;

  end process process_and;

end architecture rtl;
