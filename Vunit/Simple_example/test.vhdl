library IEEE;
   use IEEE.std_logic_1164.all;
library vunit_lib;
   context vunit_lib.vunit_context;


entity tb_example is
   generic (runner_cfg : string := runner_cfg_default);
end entity;


architecture tb of tb_example is


   component and_gate is port (
      i_clk : in std_logic;
      a     : in  std_logic;
      b     : in  std_logic;
      c     : out std_logic
   );
   end component;


   signal clk   : std_logic;
   signal a_in  : std_logic;
   signal b_in  : std_logic;
   signal c_out : std_logic;


begin


   dut : component and_gate
   port map (
      i_clk => clk,
      a     => a_in,
      b     => b_in,
      c     => c_out
   );


   process_clk : process
   begin
      clk <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 1 ns;
   end process;
   
   
   process_tb : process is
   begin
      -- Setup VUnit
      test_runner_setup(runner, runner_cfg);

         if run("test_case_name") then
            info("===== TEST CASE 1 =====");
            a_in <= '0';
            b_in <= '0';
            wait for 10 ns;
            check(c_out = '0', "ERROR, SHOUDL BE 0");
         elsif run("test_case_name2") then
            info("===== TEST CASE 2 =====");
            a_in <= '1';
            b_in <= '1';
            wait for 10 ns;
            check(c_out = '1', "ERROR, SHOUDL BE 1");
         elsif run("test_case_name3") then
            info("===== TEST CASE 3 =====");
            a_in <= '0';
            b_in <= '1';
            wait for 10 ns;
            check(c_out = '1', "ERROR, SHOUDL BE 1");
         elsif run("test_case_name4") then
            check_equal(to_string(17), "17");
         end if;

      test_runner_cleanup(runner); -- Simulation ends here

   end process process_tb;


end architecture tb;
