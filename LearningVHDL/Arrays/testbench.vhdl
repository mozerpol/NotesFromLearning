library ieee;
   use ieee.std_logic_1164.all;
   use std.env.stop;


entity testbench is
end entity testbench;


architecture tb of testbench is


   -- Create constrained one-dim array of five bits:
   -- [0, 1, 2, 3, 4]
   type t_con_one_dim_std_logic is array (0 to 4) of std_logic;
   signal a_con_one_dim_std_logic : t_con_one_dim_std_logic :=
                                       ('0', '1', '1', '1', '0');

   -- Create constrained multi-dim array of two bits, it's looks like:
   -- 0: [1, 0]
   -- 1: [1, 0]
   -- 2: [1, 0]
   -- 3: [1, 0]
   type t_con_mul_dim_vector is array (0 to 3) of std_logic_vector (1 downto 0);
   signal a_con_mul_dim_vector : t_con_mul_dim_vector :=
                                    ("00", "11", "11", "00");

   -- Create constrained multi-dim array of integers:
   -- 0: [0, 1, 2, 3, 4]
   -- 1: [0, 1, 2, 3, 4]
   -- 2: [0, 1, 2, 3, 4]
   -- 3: [0, 1, 2, 3, 4]
   -- 4: [0, 1, 2, 3, 4]
   -- 5: [0, 1, 2, 3, 4]
   type t_con_mul_dim_integer is array (0 to 5, 0 to 4) of integer;
   signal a_con_mul_dim_integer : t_con_mul_dim_integer := (
                                    (99, 5, 0, 72, 1),
                                    (9, 15, 10, 7, 0),
                                    (9, 25, 0, 81, 1),
                                    (22, 41, 0, 3, 3),
                                    (99, 5, 0, 72, 1),
                                    (1, 2, 3, 4, 5)
                                 );

   -- Create unconstrained one-dim array of bits
   type t_uncon_one_dim_bit is array (natural range <>) of bit;
   signal a_uncon_one_dim_bit_short : t_uncon_one_dim_bit(0 to 2);
   signal a_uncon_one_dim_bit_long  : t_uncon_one_dim_bit(0 to 999);

   -- Create unconstrained one-dim array of real
   type t_uncon_one_dim_real is array (natural range <>) of real;
   signal a_uncon_one_dim_real : t_uncon_one_dim_real(0 to 2) :=
   (0.25, 0.5, 0.75);

   -- Create unconstrained one-dim array of charactes. Have to be constant, in
   -- case of signal definition, the length have to be known.
   type t_uncon_one_dim_char is array (positive range <>) of character;
   constant a_uncon_one_dim_char_1 : t_uncon_one_dim_char := "ala ma kota";
   constant a_uncon_one_dim_char_2 : t_uncon_one_dim_char := "kot ma ale!1234";


begin


   tb_process : process is
   begin

      wait for 10 ns;

      -- type t_con_one_dim_std_logic is array (0 to 4) of std_logic;
      a_con_one_dim_std_logic(0) <= '1';
      a_con_one_dim_std_logic(1) <= '0';
      a_con_one_dim_std_logic(2) <= '0';
      a_con_one_dim_std_logic(3) <= '0';
      a_con_one_dim_std_logic(4) <= '1';
      
      -- type t_con_mul_dim_vector is array (0 to 3) of std_logic_vector (1 downto 0);
      a_con_mul_dim_vector(0) <= "11";
      a_con_mul_dim_vector(1) <= "00";
      a_con_mul_dim_vector(2) <= "00";
      a_con_mul_dim_vector(3) <= "11";
      
      -- type t_con_mul_dim_integer is array (0 to 5, 0 to 4) of integer;
      a_con_mul_dim_integer(0, 1) <= 1;
      a_con_mul_dim_integer(0, 2) <= 2;
      a_con_mul_dim_integer(0, 3) <= 3;
      a_con_mul_dim_integer(0, 4) <= 4;
      a_con_mul_dim_integer(5, 4) <= 54;
      
      -- type t_uncon_one_dim_bit is array (natural range <>) of bit;
      a_uncon_one_dim_bit_short <= (others => '0');
      a_uncon_one_dim_bit_long <= (others => '1');
      a_uncon_one_dim_bit_short(2) <= '1';
      a_uncon_one_dim_bit_long(999) <= '0';
      
      -- type t_uncon_one_dim_real is array (natural range <>) of real;
      a_uncon_one_dim_real <= (0.1, 0.2, 3.1234);
      
      -- type t_uncon_one_dim_char is array (positive range <>) of character;
      -- Can't change the value coz it's constant

      wait for 10 ns;
      stop;

  end process tb_process;


end architecture tb;
