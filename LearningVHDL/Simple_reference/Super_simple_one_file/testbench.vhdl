library ieee;
   use ieee.std_logic_1164.all;
   use std.env.stop;


entity testbench is
end entity testbench;


architecture tb of testbench is


   component and_gate is port (
      i_clk : in std_logic;
      i_a   : in  std_logic;
      i_b   : in  std_logic;
      o_c   : out std_logic
   );
   end component;


   signal clk_tb  : std_logic;
   signal a_tb    : std_logic;
   signal b_tb    : std_logic;
   signal c_tb    : std_logic;


begin


   dut : component and_gate
   port map (
      i_clk => clk_tb,
      i_a   => a_tb,
      i_b   => b_tb,
      o_c   => c_tb
   );


   clk_process : process is
   begin
      wait for 5 ns;
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
   end process clk_process;


   process_tb : process is
   begin

      wait for 100 ns;
      wait until rising_edge(clk_tb);
      a_tb <= '0';
      b_tb <= '0';
      wait until rising_edge(clk_tb);
      a_tb <= '0';
      b_tb <= '1';
      wait until rising_edge(clk_tb);
      a_tb <= '1';
      b_tb <= 'X';
      wait until rising_edge(clk_tb);
      a_tb <= '1';
      b_tb <= '1';
      wait until rising_edge(clk_tb);
      a_tb <= '0';
      b_tb <= '0';
      
      wait for 100 ns;
      stop;

   end process process_tb;


end architecture tb;
