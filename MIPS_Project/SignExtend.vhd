library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtend is
    Port ( 
        input : in STD_LOGIC_VECTOR(15 downto 0);
        isSigned : in STD_LOGIC;  -- '1' for signed extension, '0' for zero extension
        output : out STD_LOGIC_VECTOR(31 downto 0)
    );
end SignExtend;

architecture Behavioral of SignExtend is
begin
    process(input, isSigned)
    begin
        if isSigned = '1' then
            -- Sign extend based on the most significant bit of input
            if input(15) = '1' then
                output <= x"FFFF" & input;  -- Extend with 1's for negative numbers
            else
                output <= x"0000" & input;  -- Extend with 0's for positive numbers
            end if;
        else
            -- Zero extend
            output <= x"0000" & input;
        end if;
    end process;
end Behavioral;