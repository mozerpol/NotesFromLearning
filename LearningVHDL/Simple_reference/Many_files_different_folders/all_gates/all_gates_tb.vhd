library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
library std;
use std.env.all;

entity all_gates_tb is
end entity all_gates_tb;

architecture tb of all_gates_tb is

  component all_gates is
  port (
    i_a_all : in    std_logic;
    i_b_all : in    std_logic;
    i_c_all : in    std_logic;
    o_d_all : out   std_logic
  );
  end component;
  

  signal a_all : std_logic;
  signal b_all : std_logic;
  signal c_all : std_logic;
  signal d_all : std_logic;

begin

  inst_dut : all_gates
    port map (
      i_a_all => a_all,
      i_b_all => b_all,
      i_c_all => c_all,
      o_d_all => d_all
    );

  p_tb : process is
  begin
    a_all <= '0';
    b_all <= '0';
    c_all <= '0';
    wait for 25 ns;
    a_all <= '1';
    b_all <= '0';
    c_all <= '0';
    wait for 25 ns;
    a_all <= '0';
    b_all <= '1';
    c_all <= '0';
    wait for 25 ns;
    a_all <= '1';
    b_all <= '1';
    c_all <= '0';
    wait for 25 ns;
    a_all <= '0';
    b_all <= '0';
    c_all <= '1';
    wait for 25 ns;
    a_all <= '1';
    b_all <= '0';
    c_all <= '1';
    wait for 25 ns;
    a_all <= '0';
    b_all <= '1';
    c_all <= '1';
    wait for 25 ns;
    a_all <= '1';
    b_all <= '1';
    c_all <= '1';
    wait for 25 ns;
    
    stop(2);
  end process p_tb;

end architecture tb;












