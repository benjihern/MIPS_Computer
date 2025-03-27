library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath_tb is
end datapath_tb;

architecture Behavioral of datapath_tb is
    component Datapath is
        Port ( 
            clk : in STD_LOGIC;
            IorD : in STD_LOGIC;
            PC_enable : in STD_LOGIC;
            memRead : in STD_LOGIC; 
            memWrite : in STD_LOGIC;
            IRWrite : in STD_LOGIC;
            RegDst : in STD_LOGIC;
            MemToReg: in STD_LOGIC;
            RegWrite: in STD_LOGIC;
            JumpAndLink: in STD_LOGIC;
            IsSigned: in STD_LOGIC;
            ALUSrcA: in STD_LOGIC;
            ALUSrcB: in STD_LOGIC_VECTOR(1 downto 0);
            ALUOp: in STD_LOGIC_VECTOR(1 downto 0);
            PCSource: in STD_LOGIC_VECTOR(1 downto 0);
            switches: in STD_LOGIC_VECTOR(9 downto 0);
            buttons: in STD_LOGIC_VECTOR(1 downto 0);
            LED: out STD_LOGIC_VECTOR(9 downto 0);
            branch_taken: out STD_LOGIC;
            funct: out STD_LOGIC_VECTOR(5 downto 0);
            OpCode: out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    -- Input signals
    signal clk : STD_LOGIC := '0';
    signal IorD, PC_enable, memRead, memWrite : STD_LOGIC := '0';
    signal IRWrite, RegDst, MemToReg, RegWrite : STD_LOGIC := '0';
    signal JumpAndLink, IsSigned, ALUSrcA : STD_LOGIC := '0';
    signal ALUSrcB : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal ALUOp : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal PCSource : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal switches : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal buttons : STD_LOGIC_VECTOR(1 downto 0) := "00";

    -- Output signals
    signal LED : STD_LOGIC_VECTOR(9 downto 0);
    signal branch_taken : STD_LOGIC;
    signal funct : STD_LOGIC_VECTOR(5 downto 0);
    signal OpCode : STD_LOGIC_VECTOR(5 downto 0);

begin
    -- Instantiate Datapath
    uut: Datapath port map (
        clk => clk,
        IorD => IorD,
        PC_enable => PC_enable,
        memRead => memRead,
        memWrite => memWrite,
        IRWrite => IRWrite,
        RegDst => RegDst,
        MemToReg => MemToReg,
        RegWrite => RegWrite,
        JumpAndLink => JumpAndLink,
        IsSigned => IsSigned,
        ALUSrcA => ALUSrcA,
        ALUSrcB => ALUSrcB,
        ALUOp => ALUOp,
        PCSource => PCSource,
        switches => switches,
        buttons => buttons,
        LED => LED,
        branch_taken => branch_taken,
        funct => funct,
        OpCode => OpCode
    );

    -- Clock generation process
    process
    begin
        clk <= '0';
        wait for 50 ms;
        clk <= '1';
        wait for 50 ms;
    end process;

    -- Test stimulus
    process
    begin
        buttons(1) <= '1';
        wait for 100 ms;
        buttons(1) <= '0';
        
        wait;
    end process;

end Behavioral;