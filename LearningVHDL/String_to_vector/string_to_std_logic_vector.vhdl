    ----------------------------------------------------------------
    --  string_to_std_logic_vector
    ----------------------------------------------------------------
    impure function string_to_std_logic_vector(
        input_string        : string
    ) return std_logic_vector is
        constant ss         : string(1 to input_string'length) := input_string;
        variable hex_result : std_logic_vector(0 to 4 * input_string'length - 1);
    begin

        for i in ss'range loop
            case (ss(i)) is
                when '0'        => hex_result((i-1)*4 to (i-1)*4+3) := "0000";
                when '1'        => hex_result((i-1)*4 to (i-1)*4+3) := "0001";
                when '2'        => hex_result((i-1)*4 to (i-1)*4+3) := "0010";
                when '3'        => hex_result((i-1)*4 to (i-1)*4+3) := "0011";
                when '4'        => hex_result((i-1)*4 to (i-1)*4+3) := "0100";
                when '5'        => hex_result((i-1)*4 to (i-1)*4+3) := "0101";
                when '6'        => hex_result((i-1)*4 to (i-1)*4+3) := "0110";
                when '7'        => hex_result((i-1)*4 to (i-1)*4+3) := "0111";
                when '8'        => hex_result((i-1)*4 to (i-1)*4+3) := "1000";
                when '9'        => hex_result((i-1)*4 to (i-1)*4+3) := "1001";
                when 'a' | 'A'  => hex_result((i-1)*4 to (i-1)*4+3) := "1010";
                when 'b' | 'B'  => hex_result((i-1)*4 to (i-1)*4+3) := "1011";
                when 'c' | 'C'  => hex_result((i-1)*4 to (i-1)*4+3) := "1100";
                when 'd' | 'D'  => hex_result((i-1)*4 to (i-1)*4+3) := "1101";
                when 'e' | 'E'  => hex_result((i-1)*4 to (i-1)*4+3) := "1110";
                when 'f' | 'F'  => hex_result((i-1)*4 to (i-1)*4+3) := "1111";
                when others     => report "Unknown character in the file"
                                    severity error;
            end case ;
        end loop;

        return hex_result;

    end function;
