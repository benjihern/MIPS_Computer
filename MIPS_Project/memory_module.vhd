library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory_module is
    Port ( 
        clk : in STD_LOGIC;
        -- Memory interface
        baddr : in STD_LOGIC_VECTOR(31 downto 0);
        dataIn : in STD_LOGIC_VECTOR(31 downto 0);
        memRead : in STD_LOGIC;
        memWrite : in STD_LOGIC;
        dataOut : out STD_LOGIC_VECTOR(31 downto 0);
        
        -- Physical I/O interface
        switches : in STD_LOGIC_VECTOR(31 downto 0);
        port_select : in STD_LOGIC;
        input_enable : in STD_LOGIC;
        display_out : out STD_LOGIC_VECTOR(31 downto 0)
    );
end memory_module;

architecture Behavioral of memory_module is
    -- RAM component declaration
    component RAM
        PORT (
            address : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            clock   : IN STD_LOGIC  := '1';
            data    : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            wren    : IN STD_LOGIC;
            q       : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
    end component;

    -- I/O Module component declaration
    component io_module
        Port ( 
            clk : in STD_LOGIC;
            switches : in STD_LOGIC_VECTOR(31 downto 0);
            port_select : in STD_LOGIC;
            input_enable : in STD_LOGIC;
            display_out : out STD_LOGIC_VECTOR(31 downto 0);
            inport0_out : out STD_LOGIC_VECTOR(31 downto 0);
            inport1_out : out STD_LOGIC_VECTOR(31 downto 0);
            outport_write : in STD_LOGIC;
            outport_data : in STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Internal signals
    signal ram_addr : STD_LOGIC_VECTOR(7 downto 0);
    signal ram_q : STD_LOGIC_VECTOR(31 downto 0);
    signal ram_wren : STD_LOGIC;
    signal ram_rden : STD_LOGIC;
    signal is_io_addr : STD_LOGIC;
    signal inport0_internal : STD_LOGIC_VECTOR(31 downto 0);
    signal inport1_internal : STD_LOGIC_VECTOR(31 downto 0);
    signal outport_write_enable : STD_LOGIC;

begin
    -- Convert byte address to word address for RAM
    ram_addr <= baddr(9 downto 2);

    -- Determine if address is I/O (FFF8-FFFC)
    is_io_addr <= '1' when (baddr = x"0000FFF8" or baddr = x"0000FFFC") else '0';
    
    -- RAM control signals
    ram_wren <= memWrite and (not is_io_addr);
    ram_rden <= memRead and (not is_io_addr);
    
    -- Outport write enable
    outport_write_enable <= '1' when (memWrite = '1' and baddr = x"0000FFFC") else '0';

    -- RAM instantiation
    ram_inst : RAM
    port map (
        address => ram_addr,
        clock => clk,
        data => dataIn,
        wren => ram_wren,
        q => ram_q
    );

    -- I/O module instantiation
    io_inst : io_module
    port map (
        clk => clk,
        switches => switches,
        port_select => port_select,
        input_enable => input_enable,
        display_out => display_out,
        inport0_out => inport0_internal,
        inport1_out => inport1_internal,
        outport_write => outport_write_enable,
        outport_data => dataIn
    );

    -- Output multiplexer
    process(baddr, memRead, ram_q, inport0_internal, inport1_internal, is_io_addr)
    begin
        if memRead = '1' then
            case baddr is
                when x"0000FFF8" =>  -- INPORT0
                    dataOut <= inport0_internal;
                when x"0000FFFC" =>  -- INPORT1
                    dataOut <= inport1_internal;
                when others =>
                    if is_io_addr = '0' then
                        dataOut <= ram_q;
                    else
                        dataOut <= (others => '0');
                    end if;
            end case;
        else
            dataOut <= (others => '0');
        end if;
    end process;

end Behavioral;