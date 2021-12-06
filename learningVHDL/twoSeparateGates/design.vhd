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

  and_process : process (in1, in2) is
  begin

    out1_and <= in1 and in2;

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

  component and_area is
    port (
      in1      : in    std_logic;
      in2      : in    std_logic;
      out1_and : out   std_logic
    );
  end component and_area;

  signal internal_wire : std_logic;

begin

  component_and_area : component and_area
    port map (
      in1      => in1,
      in2      => in2,
      out1_and => internal_wire
    );

  gates_process : process (in3, internal_wire) is

  begin

    out_or <= in3 or internal_wire;

  end process gates_process;

end architecture rtl2;