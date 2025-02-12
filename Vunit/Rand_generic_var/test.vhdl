library IEEE;
   use IEEE.std_logic_1164.all;
library vunit_lib;
   context vunit_lib.vunit_context;


entity tb_example is
   generic (
      runner_cfg  : string := runner_cfg_default;
      G_NUMBER_TB : integer
   );
end entity;


architecture tb of tb_example is


   component and_gate is
   generic (
      G_NUMBER : integer
   ); 
   port (
      i_clk : in std_logic;
      a     : in  std_logic;
      b     : in  std_logic;
      c     : out std_logic;
      d     : out integer
   );
   end component;


   signal clk   : std_logic;
   signal a_in  : std_logic;
   signal b_in  : std_logic;
   signal c_out : std_logic;
   signal d_out : integer;


begin


   dut : component and_gate
   generic map (
      G_NUMBER => G_NUMBER_TB
   )
   port map (
      i_clk => clk,
      a     => a_in,
      b     => b_in,
      c     => c_out,
      d     => d_out
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
            wait for G_NUMBER_TB*2 * ns;
            check(c_out = '0', "ERROR, SHOUDL BE 0");
            check_equal(d_out, G_NUMBER_TB, "message");
           -- wait for 100 ns;
         end if;

      test_runner_cleanup(runner); -- Simulation ends here

   end process process_tb;


end architecture tb;
