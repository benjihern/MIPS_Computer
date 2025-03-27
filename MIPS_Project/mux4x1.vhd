library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4x1 is
    Port ( 
        d0 : in STD_LOGIC_VECTOR(31 downto 0);
        d1 : in STD_LOGIC_VECTOR(31 downto 0);
        d2 : in STD_LOGIC_VECTOR(31 downto 0);
        d3 : in STD_LOGIC_VECTOR(31 downto 0);
        sel : in STD_LOGIC_VECTOR(1 downto 0);
        y : out STD_LOGIC_VECTOR(31 downto 0)
    );
end mux4x1;

architecture Behavioral of mux4x1 is
begin
    process(d0, d1, d2, d3, sel)
    begin
        case sel is
            when "00" => y <= d0;
            when "01" => y <= d1;
            when "10" => y <= d2;
            when "11" => y <= d3;
            when others => y <= (others => '0');
        end case;
    end process;
end Behavioral;