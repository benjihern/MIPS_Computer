library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ZeroExtend is
    Port ( 
        input : in STD_LOGIC_VECTOR(9 downto 0);  -- 10-bit input
        output : out STD_LOGIC_VECTOR(31 downto 0)  -- 32-bit output
    );
end ZeroExtend;

architecture Behavioral of ZeroExtend is
begin
    -- Concatenate 22 zeros with the input
    output <= "0000000000000000000000" & input;
end Behavioral;