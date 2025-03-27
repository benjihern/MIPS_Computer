library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_Level is
    Port ( 
        clk : in STD_LOGIC;
        switches : in STD_LOGIC_VECTOR(9 downto 0);
        buttons : in STD_LOGIC_VECTOR(1 downto 0);
        LED : out STD_LOGIC_VECTOR(9 downto 0)
    );
end Top_Level;

architecture Behavioral of Top_Level is
    -- Datapath component
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
            OpCode: out STD_LOGIC_VECTOR(5 downto 0);
				funct : out STD_LOGIC_VECTOR(5 downto 0);
            branch_taken: out STD_LOGIC
        );
    end component;
    
    -- Controller component
    component controller is
        Port ( 
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            opcode : in STD_LOGIC_VECTOR(5 downto 0);
				funct : in STD_LOGIC_VECTOR(5 downto 0);
            MemRead : out STD_LOGIC;
            MemWrite : out STD_LOGIC;
            MemtoReg : out STD_LOGIC;
            IorD : out STD_LOGIC;
            IRWrite : out STD_LOGIC;
            PCWrite : out STD_LOGIC;
            PCWriteCond : out STD_LOGIC;
            PCSource : out STD_LOGIC_VECTOR(1 downto 0);
            ALUOp : out STD_LOGIC_VECTOR(1 downto 0);
            ALUSrcA : out STD_LOGIC;
            ALUSrcB : out STD_LOGIC_VECTOR(1 downto 0);
            RegWrite : out STD_LOGIC;
            RegDst : out STD_LOGIC;
            JumpAndLink : out STD_LOGIC;
            IsSigned : out STD_LOGIC
        );
    end component;

    -- Internal control signals
    signal OpCode : STD_LOGIC_VECTOR(5 downto 0);
	 signal funct : STD_LOGIC_VECTOR(5 downto 0);
    signal MemRead : STD_LOGIC;
    signal MemWrite : STD_LOGIC;
    signal MemtoReg : STD_LOGIC;
    signal IorD : STD_LOGIC;
    signal IRWrite : STD_LOGIC;
    signal PCWrite : STD_LOGIC;
    signal PCWriteCond : STD_LOGIC;
    signal PCSource : STD_LOGIC_VECTOR(1 downto 0);
    signal ALUOp : STD_LOGIC_VECTOR(1 downto 0);
    signal ALUSrcA : STD_LOGIC;
    signal ALUSrcB : STD_LOGIC_VECTOR(1 downto 0);
    signal RegWrite : STD_LOGIC;
    signal RegDst : STD_LOGIC;
    signal branch_taken : STD_LOGIC;
    signal PC_enable : STD_LOGIC;
    signal JumpAndLink : STD_LOGIC;
    signal IsSigned : STD_LOGIC;

begin
    -- Instantiate Datapath
    Datapath_inst: Datapath port map (
        clk => clk,
        IorD => IorD,
        PC_enable => PC_enable,
        memRead => MemRead,
        memWrite => MemWrite,
        IRWrite => IRWrite,
        RegDst => RegDst,
        MemToReg => MemtoReg,
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
        OpCode => OpCode,
		  funct => funct,
        branch_taken => branch_taken
    );
    
    -- Instantiate Controller
    Controller_inst: controller port map (
        clk => clk,
        reset => buttons(1),
        opcode => OpCode,
		  funct => funct,
        MemRead => MemRead,
        MemWrite => MemWrite,
        MemtoReg => MemtoReg,
        IorD => IorD,
        IRWrite => IRWrite,
        PCWrite => PCWrite,
        PCWriteCond => PCWriteCond,
        PCSource => PCSource,
        ALUOp => ALUOp,
        ALUSrcA => ALUSrcA,
        ALUSrcB => ALUSrcB,
        RegWrite => RegWrite,
        RegDst => RegDst,
        JumpAndLink => JumpAndLink,
        IsSigned => IsSigned
    );

    PC_enable <= PCWrite or (PCWriteCond and branch_taken);

end Behavioral;