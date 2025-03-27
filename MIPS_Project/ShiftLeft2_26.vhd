library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftLeft2_26 is
    Port ( 
        input : in STD_LOGIC_VECTOR(25 downto 0);
        output : out STD_LOGIC_VECTOR(27 downto 0)
    );
end ShiftLeft2_26;

architecture Behavioral of ShiftLeft2_26 is
begin
    output <= input & "00";
end Behavioral;