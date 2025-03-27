library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity io_module is
    Port ( 
        clk : in STD_LOGIC;
        -- Physical I/O
        switches : in STD_LOGIC_VECTOR(31 downto 0);
        input_enable : in STD_LOGIC;
        display_out : out STD_LOGIC_VECTOR(31 downto 0);
		  port_select: in STD_LOGIC;
		  
        -- Memory interface
        inport0_out : out STD_LOGIC_VECTOR(31 downto 0);
        inport1_out : out STD_LOGIC_VECTOR(31 downto 0);
        outport_write : in STD_LOGIC;
        outport_data : in STD_LOGIC_VECTOR(31 downto 0)
    );
end io_module;

architecture Behavioral of io_module is
    signal input_enable_prev : std_logic := '0';
    signal input_enable_edge : std_logic;
    signal inport0_reg : STD_LOGIC_VECTOR(31 downto 0);
    signal inport1_reg : STD_LOGIC_VECTOR(31 downto 0);
    signal outport_reg : STD_LOGIC_VECTOR(31 downto 0);

begin
    -- Edge detection for input enable
    process(clk)
    begin
        if rising_edge(clk) then
            input_enable_prev <= input_enable;
            
            -- Handle outport register
            if outport_write = '1' then
                outport_reg <= outport_data;
            end if;
        end if;
    end process;

    input_enable_edge <= '1' when input_enable = '1' and input_enable_prev = '0' else '0';

    -- Input port registers
    process(clk)
    begin
        if rising_edge(clk) then
            if input_enable_edge = '1' then
                if port_select = '0' then  -- INPORT0
                    inport0_reg <= switches;
                else                       -- INPORT1
                    inport1_reg <= switches;
                end if;
            end if;
        end if;
    end process;

    -- Connect registers to outputs
    inport0_out <= inport0_reg;
    inport1_out <= inport1_reg;
    display_out <= outport_reg;

end Behavioral;