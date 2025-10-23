library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;


entity example_generate is
   generic (
      g_debug : natural := 1 -- 0: empty_vector is equal 0, 1: empty_vector is 1
   );
end entity example_generate;


architecture behave of example_generate is


   signal pattern_vector_1 : std_logic_vector(0 to 4) := (others => '0');
   signal pattern_vector_2 : std_logic_vector(0 to 4) := (others => '1');
   signal empty_vector     : std_logic_vector(0 to 4);


begin


   -- if condition generate
   ----- statements
   -- elsif condition2 generate
   ----- statements
   -- else generate
   ----- statements
   -- end generate;

   g_keep_debug : if g_debug = 0 generate
      p_test : process (pattern_vector_1) is
      begin
         for i in 0 to 4 loop
            empty_vector(i) <= pattern_vector_1(i);
         end loop;
      end process p_test;
   end generate g_keep_debug;

   g_remove_debug : if g_debug = 1 generate
      p_test : process (pattern_vector_2) is
      begin
         for i in 0 to 4 loop
            empty_vector(i) <= pattern_vector_2(i);
         end loop;
      end process p_test;
   end generate g_remove_debug;


end architecture behave;
