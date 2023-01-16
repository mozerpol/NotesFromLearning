library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
library and_gate;
  use and_gate.all;
  use and_gate.and_gate_pkg.all;
library or_gate;
  use or_gate.all;
  use or_gate.or_gate_pkg.all;

entity all_gates is
  port (
    i_a_all : in    std_logic;
    i_b_all : in    std_logic;
    i_c_all : in    std_logic;
    o_d_all : out   std_logic
  );
end entity all_gates;


architecture rtl of all_gates is

    signal a_or : std_logic;
    signal b_or : std_logic;
    signal c_or : std_logic;
    signal a_and : std_logic;
    signal b_and : std_logic;
    signal c_and : std_logic;
    signal internal_wire : std_logic;

component or_gate is
  port (
    i_a_or : in    std_logic;
    i_b_or : in    std_logic;
    o_c_or : out   std_logic
  );
end component or_gate;

component and_gate is
  port (
    i_a_and : in    std_logic;
    i_b_and : in    std_logic;
    o_c_and : out   std_logic
  );
end component and_gate;


begin

  inst_and_gate : and_gate
  port map(
    i_a_and => i_a_all,
    i_b_and => i_b_all,
    o_c_and => a_or
   );

   inst_or_gate : or_gate
   port map(
      i_a_or => a_or,
      i_b_or => i_c_all,
      o_c_or => o_d_all
   );

end architecture rtl;
