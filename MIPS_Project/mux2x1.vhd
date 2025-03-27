library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2x1 is
    Port ( 
        d0 : in STD_LOGIC_VECTOR(31 downto 0);
        d1 : in STD_LOGIC_VECTOR(31 downto 0);
        sel : in STD_LOGIC;
        y : out STD_LOGIC_VECTOR(31 downto 0)
    );
end mux2x1;

architecture Behavioral of mux2x1 is
begin
    process(d0, d1, sel)
    begin
        case sel is
            when '0' => y <= d0;
            when '1' => y <= d1;
            when others => y <= (others => '0');
        end case;
    end process;
end Behavioral;