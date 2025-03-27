library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Concat is
    Port ( 
        input_28bit : in STD_LOGIC_VECTOR(27 downto 0);
        input_4bit : in STD_LOGIC_VECTOR(3 downto 0);
        output : out STD_LOGIC_VECTOR(31 downto 0)
    );
end Concat;

architecture Behavioral of Concat is
begin
    output <= input_4bit & input_28bit;
end Behavioral;