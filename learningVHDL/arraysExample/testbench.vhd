library ieee;
  use ieee.std_logic_1164.all;
  use std.env.stop;

entity testbench is
end entity testbench;

architecture tb of testbench is

  -- Create constrained one-dim array of eight bits, it's looks like:
  -- [0, 1, 2, 3, 4, 5, 6, 7, 8]
  type con_one_dim is array (0 to 7) of std_logic; -- For one dim we can use 
  -- std_logic type, but for multi dimensional array we must use std_logic_vector
  signal array_con_1 : con_one_dim;

  -- Create constrained multi-dim array of two bits, it's looks like:
  -- 0: [1, 0]
  -- 1: [1, 0]
  -- 2: [1, 0]
  -- 3: [1, 0]
  type con_mul_dim_1 is array (0 to 3) of std_logic_vector (1 downto 0); -- define
  -- the type of array.
  signal array_con_2 : con_mul_dim_1; -- array2 is a mul-dim array of std_logic type.

  -- Create constrained multi-dim array of two bits, it's looks like: 
  -- 0: [0, 1] 
  -- 1: [0, 1] 
  -- 2: [0, 1] 
  -- 3: [0, 1]
  -- This array is almost the same as above, but in this case we must use
  -- integer type. I'm not sure that this example is synthesizable. 
  type con_mul_dim_2 is array (0 to 3, 0 to 1) of integer ; 
  signal array_con_3 : con_mul_dim_2;


begin

  tb_process : process is

  begin

    -- Accessing to the: "type one_dim_8 is array (0 to 7) of std_logic;"
    array_con_1(0) <= '1';
    array_con_1(1) <= '0';
    array_con_1(2) <= '1';
    array_con_1(3 to 5) <= "010";

    -- Accessing to the: 
    -- "type mul_dim_1 is array (0 to 3) of std_logic_vector (1 downto 0);" 
    array_con_2(0)(0) <= '0';
    array_con_2(0)(1) <= '1';
    array_con_2(1)(0) <= '0';
    array_con_2(1)(1) <= '1';
    array_con_2(2)(1 downto 0) <= "00";
    -- array_con_2(3,0) <= '1'; It's illegal

    -- Accessing to the: "type mul_dim_2 is array (0 to 3, 0 to 1) of integer;"
    array_con_3(0,0) <= 99;
    array_con_3(0,1) <= 23;
    array_con_3(1,0) <= 12;
    array_con_3(1,1) <= 0;

    wait for 10 ns;
    stop;

  end process tb_process;

end architecture tb;
