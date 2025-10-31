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


   type t_record is record
      data_1      : std_logic;
      data_2      : std_logic;
   end record;

   -- Create pointer to record
   type t_pointer_to_record is access t_record;
   -- Create unconstrained array of pointers. Each pointer points to a recrord.
   -- The size of an array is set later, during compilation
   type t_array_of_pointers_to_record is array (natural range <>) of t_pointer_to_record;
   -- Create pointer to a array of pointers. Thanks to this it's possible
   -- return this pointer by function. Function, can't return any array, but can
   -- return pointer to an array.
   type t_pointer_to_array_of_pointers is access t_array_of_pointers_to_record;

   -- Signals for the component
   signal clk_tb  : std_logic;
   signal a_tb    : std_logic;
   signal b_tb    : std_logic;
   signal c_tb    : std_logic;


   impure function fill_array_of_record
   return t_pointer_to_array_of_pointers is
      variable v_pointer_to_array_of_pointers : t_pointer_to_array_of_pointers;
   begin
      -- Create a new pointer which points to an unconstrained array of pointers
      -- Here is set the size of unconstrained array. In this case is 11 (from
      -- 0 to 10).
      v_pointer_to_array_of_pointers  := new t_array_of_pointers_to_record(0 to 10);

      for i in 0 to 10 loop
         -- Add a new record to an array
         v_pointer_to_array_of_pointers(i)        := new t_record;
         --  Assign values to the newly created record
         v_pointer_to_array_of_pointers(i).data_1 := '0';
         v_pointer_to_array_of_pointers(i).data_2 := '1';
      end loop;

      return v_pointer_to_array_of_pointers;
   end function;


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
      variable v_array_of_test_data : t_pointer_to_array_of_pointers;
   begin

      v_array_of_test_data := fill_array_of_record;

      wait for 100 ns;
      wait until rising_edge(clk_tb);

      for i in 0 to 10 loop
         a_tb <= v_array_of_test_data(i).data_1;
         b_tb <= v_array_of_test_data(i).data_2;
         wait until rising_edge(clk_tb);
      end loop;

      wait for 100 ns;
      stop;

   end process process_tb;


end architecture tb;
