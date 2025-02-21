Output from ModelSim: <br/>
![a](https://user-images.githubusercontent.com/43972902/144634594-e8b8c98e-c773-452f-99ce-5e33ea701b28.png)

I used *generic* and calculating length of vector during compilation by: <br/>
```VHDL
constant vector_length : integer := integer(ceil(log2(real(count_up_to) + real(1))));
```

And filling array with zeros: <br/>
```VHDL
signal   counter       : std_logic_vector(vector_length downto 0) := (others => '0');
```
