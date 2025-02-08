library ieee;
   use ieee.std_logic_1164.all;
library and_gate_lib;
library or_gate_lib;
library vunit_lib;
   context vunit_lib.vunit_context;


entity all_gates_tb is
   generic (runner_cfg : string := runner_cfg_default);
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
   -- Setup VUnit
   test_runner_setup(runner, runner_cfg);

   if run("test_case_name") then
      info("===== TEST CASE 1 =====");
      a_all <= '0';
      b_all <= '0';
      c_all <= '0';
      wait for 1 ns;
      check(d_all = '0', "ERROR, SHOUDL BE 0");
      a_all <= '1';
      b_all <= '0';
      c_all <= '0';
      wait for 1 ns;
      check(d_all = '0', "ERROR, SHOUDL BE 0");
      a_all <= '0';
      b_all <= '1';
      c_all <= '0';
      wait for 1 ns;
      check(d_all = '0', "ERROR, SHOUDL BE 0");
      a_all <= '0';
      b_all <= '0';
      c_all <= '1';
      wait for 1 ns;
      check(d_all = '1', "ERROR, SHOUDL BE 1");
   end if;

   test_runner_cleanup(runner); -- Simulation ends here

   end process p_tb;


end architecture tb;
