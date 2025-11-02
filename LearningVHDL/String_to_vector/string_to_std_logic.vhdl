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
