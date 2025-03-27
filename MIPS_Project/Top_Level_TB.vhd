library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_Level_TB is
end Top_Level_TB;

architecture Behavioral of Top_Level_TB is
    -- Component Declaration
    component Top_Level is
        Port ( 
            clk : in STD_LOGIC;
            switches : in STD_LOGIC_VECTOR(9 downto 0);
            buttons : in STD_LOGIC_VECTOR(1 downto 0);
            LED : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;
    
    -- Signal Declarations
    signal clk : STD_LOGIC := '0';
    signal switches : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal buttons : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal LED : STD_LOGIC_VECTOR(9 downto 0);
    
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Top_Level port map (
        clk => clk,
        switches => switches,
        buttons => buttons,
        LED => LED
    );
    
    -- Clock generation process
    process
    begin
        clk <= '0';
        wait for 50 ms;
        clk <= '1';
        wait for 50 ms;
    end process;
    
    -- Test stimulus process
    process
    begin
        buttons(1) <= '1';
        wait for 100 ms;
        buttons(1) <= '0';
		  buttons(0) <= '1';
		  switches <= "0111111111";
        wait;
    end process;

end Behavioral;