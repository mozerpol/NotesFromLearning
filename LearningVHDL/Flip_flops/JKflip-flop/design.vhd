library IEEE;
  use IEEE.std_logic_1164.all;

entity jkff is port (
    clk : in    std_logic;
    j   : in    std_logic;
    k   : in    std_logic;
    q   : out   std_logic
  );
end entity jkff;

architecture rtl of jkff is

begin

  jkff_process : process (clk) is

    variable q_reg         : std_logic;
    variable v_concatenate : std_logic_vector(1 downto 0);

  begin

    if (clk'event and clk = '1') then
      v_concatenate := j & k;

      case v_concatenate is

        when "00" =>
          q_reg := q_reg;
        when "01" =>
          q_reg := '0';
        when "10" =>
          q_reg := '1';
        when "11" =>
          q_reg := not(q_reg);
        when others =>
          q_reg := q_reg;

      end case;

    end if;

    q <= q_reg;

  end process jkff_process;

end architecture rtl;
