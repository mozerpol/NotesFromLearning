library IEEE;
   use IEEE.std_logic_1164.all;
library vunit_lib;
   context vunit_lib.vunit_context;


entity tb_example is
   generic (
      runner_cfg    : string := runner_cfg_default;
      G_GENERATE_TB : integer;
      G_NUMBER_1_TB : integer;
      G_NUMBER_2_TB : integer
   );
end entity;


architecture tb of tb_example is


   component and_gate is
   generic (
      G_GENERATE  : natural := 0;
      -- 0 - don't generate cnt_1 and cnt_2
      -- 1 - generate cnt_1
      -- 2 - generate cnt_2
      -- 3 - generate cnt_1 and cnt_2
      G_NUMBER_1  : integer := 2;
      G_NUMBER_2  : integer := 4
   );
   port (
      i_clk       : in std_logic;
      a           : in std_logic;
      b           : in std_logic;
      c           : out std_logic;
      d_1         : out integer;
      d_2         : out integer
   );
   end component;


   signal clk     : std_logic;
   signal a_in    : std_logic;
   signal b_in    : std_logic;
   signal c_out   : std_logic;
   signal d_1_out : integer;
   signal d_2_out : integer;


begin


   dut : component and_gate
   generic map (
      G_GENERATE  => G_GENERATE_TB,
      G_NUMBER_1  => G_NUMBER_1_TB,
      G_NUMBER_2  => G_NUMBER_2_TB
   )
   port map (
      i_clk       => clk,
      a           => a_in,
      b           => b_in,
      c           => c_out,
      d_1         => d_1_out,
      d_2         => d_2_out
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
            wait for 100 ns;
         end if;

      test_runner_cleanup(runner); -- Simulation ends here

   end process process_tb;


end architecture tb;
