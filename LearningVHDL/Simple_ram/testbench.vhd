library ieee;
   use ieee.std_logic_1164.all;
   use std.env.stop;


entity testbench is
end entity testbench;


architecture tb of testbench is


   component simpleram is
   generic (
      data_size   : integer := 8;
      data_depth  : integer := 5
  ); port (
      clk      : in std_logic;
      we       : in std_logic;
      addr     : in integer range 0 to data_depth - 1;
      data_in  : in std_logic_vector(data_size - 1 downto 0);
      data_out : out std_logic_vector(data_size - 1 downto 0)
   );
  end component;


  signal clk_tb      : std_logic;
  signal we_tb       : std_logic;
  signal addr_tb     : integer range 0 to 5 - 1; -- Simulation error when from
  -- 0 to data_depth
  signal data_in_tb  : std_logic_vector(7 downto 0);
  signal data_out_tb : std_logic_vector(7 downto 0);


begin


   dut : component simpleram
   port map (
      clk      => clk_tb,
      we       => we_tb,
      addr     => addr_tb,
      data_in  => data_in_tb,
      data_out => data_out_tb
    );


   clk_process : process is
   begin
      wait for 5 ns;
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
   end process clk_process;


   tb_process : process is
   begin

   -- Set initial values
   we_tb       <= '0';
   addr_tb     <= 0;

   wait for 100 ns;
   wait until rising_edge(clk_tb);

   -- Write to memory
   we_tb       <= '1';
   addr_tb     <= 0;
   data_in_tb  <= (others => '1');
   wait until rising_edge(clk_tb);
   addr_tb     <= 1;
   data_in_tb  <= (others => '1');
   wait until rising_edge(clk_tb);
   addr_tb     <= 2;
   data_in_tb  <= (others => '1');
   wait until rising_edge(clk_tb);

   -- Read from memory
   we_tb       <= '0';
   addr_tb     <= 0;
   wait until rising_edge(clk_tb);
   addr_tb     <= 1;
   wait until rising_edge(clk_tb);
   addr_tb     <= 2;

   wait for 100 ns;
   stop;

  end process tb_process;


end architecture tb;
