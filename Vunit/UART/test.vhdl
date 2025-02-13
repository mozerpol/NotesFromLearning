library IEEE;
   use IEEE.std_logic_1164.all;
library vunit_lib;
   context vunit_lib.vunit_context;
   context vunit_lib.vc_context;


entity tb_example is
   generic (
      runner_cfg        : string := runner_cfg_default;
      G_BAUD_TB         : integer;
      G_FREQUENCY_HZ_TB : integer
   );
end entity;


architecture tb of tb_example is


   component uart is
   generic(
      G_BAUD               : positive := G_BAUD_TB;        -- 115200;
      G_FREQUENCY_HZ       : positive := G_FREQUENCY_HZ_TB -- 50000000
   ); port (
      i_rst_n              : in std_logic;
      i_clk                : in std_logic;
      i_uart_wdata         : in std_logic_vector(31 downto 0);
      i_uart_rx            : in std_logic;
      i_uart_we            : in std_logic;
      o_uart_data          : out std_logic_vector(31 downto 0);
      o_uart_tx            : out std_logic
   );
   end component;


   signal rst_n_tb      : std_logic;
   signal clk_tb        : std_logic;
   signal uart_wdata_tb : std_logic_vector(31 downto 0);
   signal uart_rx_tb    : std_logic;
   signal uart_tx_tb    : std_logic;
   signal uart_we_tb    : std_logic;
   signal uart_data_tb  : std_logic_vector(31 downto 0);
constant uart_bfm : uart_slave_t := new_uart_slave(initial_baud_rate => G_BAUD_TB, data_length => 8);
constant uart_stream : stream_slave_t := as_stream(uart_bfm);

begin


   inst_uart        : component uart
   port map (
      i_rst_n        => rst_n_tb,
      i_clk          => clk_tb,
      i_uart_wdata   => uart_wdata_tb,
      i_uart_rx      => uart_rx_tb,
      i_uart_we      => uart_we_tb,
      o_uart_data    => uart_data_tb,
      o_uart_tx      => uart_tx_tb
   );


   process_clk : process
   begin
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
      wait for 5 ns;
   end process;
   
   
   process_tb : process is
   begin
      -- Setup VUnit
      test_runner_setup(runner, runner_cfg);

         if run("test_send_one_byte") then
            info("===== TEST CASE 1 =====");
            wait for 1 us;
         end if;

      test_runner_cleanup(runner); -- Simulation ends here

   end process process_tb;


end architecture tb;
