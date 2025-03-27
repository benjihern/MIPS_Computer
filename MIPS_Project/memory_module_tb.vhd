library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory_module_tb is
end memory_module_tb;

architecture Behavioral of memory_module_tb is
    -- Component Declaration
    component memory_module
        Port ( 
            clk : in STD_LOGIC;
            baddr : in STD_LOGIC_VECTOR(31 downto 0);
            dataIn : in STD_LOGIC_VECTOR(31 downto 0);
            memRead : in STD_LOGIC;
            memWrite : in STD_LOGIC;
            dataOut : out STD_LOGIC_VECTOR(31 downto 0);
            switches : in STD_LOGIC_VECTOR(31 downto 0);
				port_select : in STD_LOGIC;
            input_enable : in STD_LOGIC;
            display_out : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    -- Test Signals
    signal clk : STD_LOGIC := '0';
    signal baddr : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal dataIn : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal memRead : STD_LOGIC := '0';
    signal memWrite : STD_LOGIC := '0';
    signal dataOut : STD_LOGIC_VECTOR(31 downto 0);
    signal switches : STD_LOGIC_VECTOR(31 downto 0);
    signal input_enable : STD_LOGIC := '0';
    signal display_out : STD_LOGIC_VECTOR(31 downto 0);
	 signal port_select : STD_LOGIC := '0';
    
    -- Test monitoring signals
    signal inport0_value : STD_LOGIC_VECTOR(31 downto 0);
    signal inport1_value : STD_LOGIC_VECTOR(31 downto 0);
    
    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: memory_module port map (
        clk => clk,
        baddr => baddr,
        dataIn => dataIn,
        memRead => memRead,
        memWrite => memWrite,
        dataOut => dataOut,
        switches => switches,
		  port_select => port_select,
        input_enable => input_enable,
        display_out => display_out
    );

    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize
        wait for 100 ns;
        
        -- Test Case 1: Write 0x0A0A0A0A to byte address 0x00000000
        baddr <= x"00000000";
        dataIn <= x"0A0A0A0A";
        memWrite <= '1';
        wait for clk_period;
        memWrite <= '0';
        wait for clk_period;
        
        -- Test Case 2: Write 0xF0F0F0F0 to byte address 0x00000004
        baddr <= x"00000004";
        dataIn <= x"F0F0F0F0";
        memWrite <= '1';
        wait for clk_period;
        memWrite <= '0';
        wait for clk_period;

        -- Test Case 3: Read from byte address 0x00000000
        baddr <= x"00000000";
        memRead <= '1';
        wait for clk_period*2;  -- Wait two clock cycles for data to appear
        assert dataOut = x"0A0A0A0A" report "Failed reading 0x00000000" severity ERROR;
        wait for clk_period;

        -- Test Case 4: Read from byte address 0x00000001
        baddr <= x"00000001";
        wait for clk_period*2;
        assert dataOut = x"0A0A0A0A" report "Failed reading 0x00000001" severity ERROR;
        wait for clk_period;

        -- Test Case 5: Read from byte address 0x00000004
        baddr <= x"00000004";
        wait for clk_period*2;
        assert dataOut = x"F0F0F0F0" report "Failed reading 0x00000004" severity ERROR;
        wait for clk_period;

        -- Test Case 6: Read from byte address 0x00000005
        baddr <= x"00000005";
        wait for clk_period*2;
        assert dataOut = x"F0F0F0F0" report "Failed reading 0x00000005" severity ERROR;
        memRead <= '0';
        wait for clk_period;

        -- Test Case 7: Write to outport
        baddr <= x"0000FFFC";
        dataIn <= x"00001111";
        memWrite <= '1';
        wait for clk_period;
        memWrite <= '0';
        wait for clk_period;

        -- Test Case 8: Load value into INPORT0
        switches <= x"00010000";  -- Port select = 0
		  port_select <= '0';
        input_enable <= '1';
        wait for clk_period;
        input_enable <= '0';
        wait for clk_period;
        inport0_value <= switches;

        -- Test Case 9: Load value into INPORT1
        switches <= x"00000001";  -- Port select = 1
		  port_select <= '1';
        input_enable <= '1';
        wait for clk_period;
        input_enable <= '0';
        wait for clk_period;
        inport1_value <= switches;

        -- Test Case 10: Read from INPORT0
        baddr <= x"0000FFF8";
        memRead <= '1';
        wait for clk_period*2;
        assert dataOut = inport0_value report "Failed reading INPORT0" severity ERROR;
        wait for clk_period;

        -- Test Case 11: Read from INPORT1
        baddr <= x"0000FFFC";
        wait for clk_period*2;
        assert dataOut = inport1_value report "Failed reading INPORT1" severity ERROR;
        memRead <= '0';
        wait for clk_period;

        wait;
    end process;
    

end Behavioral;