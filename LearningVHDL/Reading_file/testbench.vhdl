library ieee;
   use ieee.std_logic_1164.all;
   use std.env.stop;
context ieee.ieee_std_context;
   use std.textio.all; -- Access to types like line or I/O functions


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


   ----------------------------------------------------------------
   --  string_to_std_logic
   ----------------------------------------------------------------
   impure function string_to_std_logic(
      input_string    : character
   ) return std_logic is
      variable result : std_logic;
   begin
      if (input_string = '0') then
         result := '0';
      elsif (input_string = '1') then
         result := '1';
      else
         result := 'X';
      end if;

      return result;
   end function;


   ----------------------------------------------------------------
   --  fill_array_of_record
   ----------------------------------------------------------------
   impure function fill_array_of_record(
      constant filename    : string
   ) return t_pointer_to_array_of_pointers is
      variable v_pointer_to_array_of_pointers : t_pointer_to_array_of_pointers;
      file     input_file                     : text open read_mode is filename;
      variable line_buffer                    : line;
      variable v_number_of_lines_in_file      : integer := 0;
   begin
      -- Open txt file and count number of lines there
      while (not endfile(input_file)) loop
         readline(input_file, line_buffer);
         v_number_of_lines_in_file   := v_number_of_lines_in_file + 1;
      end loop;
      file_close(input_file);

      -- Create a new pointer which points to an unconstrained array of pointers
      -- Here is set the size of unconstrained array.
      v_pointer_to_array_of_pointers  := new t_array_of_pointers_to_record(0 to
                                                v_number_of_lines_in_file - 1);

      -- Open the same txt file as before
      file_open(input_file, filename, read_mode);

      for i in 0 to v_number_of_lines_in_file - 1 loop
         readline(input_file, line_buffer); -- read line from opened file
         -- writeline(output, line_buffer); -- print out whole line

         -- Add a new record to an array
         v_pointer_to_array_of_pointers(i)        := new t_record;
         --  Assign values to the newly created record
         -- In data.txt on the positions 1 and 4 are test vectors
         v_pointer_to_array_of_pointers(i).data_1 := string_to_std_logic(line_buffer.all(1));
         v_pointer_to_array_of_pointers(i).data_2 := string_to_std_logic(line_buffer.all(4));
      end loop;

      file_close(input_file);

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
      variable v_array_of_test_data           : t_pointer_to_array_of_pointers;
      file     input_file                     : text open read_mode is "data.txt";
      variable line_buffer                    : line;
      variable v_current_line_number          : integer := 0;
      variable v_number_of_lines_in_file      : integer := 0;
   begin
      wait for 100 ns;
      wait until rising_edge(clk_tb);

      -- Open txt file and count number of lines there
      while (not endfile(input_file)) loop
         readline(input_file, line_buffer);
         v_number_of_lines_in_file   := v_number_of_lines_in_file + 1;
      end loop;
      file_close(input_file);

      v_array_of_test_data := fill_array_of_record("data.txt");

      for i in 0 to v_number_of_lines_in_file - 1 loop
         a_tb <= v_array_of_test_data(i).data_1;
         b_tb <= v_array_of_test_data(i).data_2;
         wait until rising_edge(clk_tb);
      end loop;

      wait for 100 ns;
      stop;

   end process process_tb;


end architecture tb;
