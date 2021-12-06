library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

entity testbench is
    end entity testbench;

    architecture tb of testbench is 
    component and_area is 
    port (
        in1 : in std_logic;
        in2 : in std_logic;
        out1_and : out std_logic
    );
    end component;
    begin

    end architecture tb;