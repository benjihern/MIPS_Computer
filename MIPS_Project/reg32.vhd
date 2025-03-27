library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg32 is
    generic (
        WIDTH : integer := 32  -- Default width is 32 bits, but can be changed when instantiated
    );
    Port ( 
        clk     : in STD_LOGIC;
        reset   : in STD_LOGIC;
        enable  : in STD_LOGIC;                                   -- Write enable
        d       : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);         -- Data input
        q       : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)         -- Data output
    );
end reg32;

architecture Behavioral of reg32 is
    signal reg_data : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            reg_data <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                reg_data <= d;
            end if;
        end if;
    end process;

    q <= reg_data;

end Behavioral;