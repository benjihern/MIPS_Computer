library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datapath is
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
end Datapath;

architecture Behavioral of Datapath is
    -- Component declarations
    component reg32 is
        Port ( 
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            enable : in STD_LOGIC;
            d : in STD_LOGIC_VECTOR(31 downto 0);
            q : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
	 
	 component registerfile is
        port(
            clk : in std_logic;
            rst : in std_logic;
            rd_addr0 : in std_logic_vector(4 downto 0);
            rd_addr1 : in std_logic_vector(4 downto 0);
            wr_addr : in std_logic_vector(4 downto 0);
            wr_en : in std_logic;
            wr_data : in std_logic_vector(31 downto 0);
            rd_data0 : out std_logic_vector(31 downto 0);
            rd_data1 : out std_logic_vector(31 downto 0);
            JumpAndLink : in std_logic
        );
    end component;
	 
	 component memory_module is
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
	 
	 component mux2x1 is
        Port ( 
            d0 : in STD_LOGIC_VECTOR(31 downto 0);
            d1 : in STD_LOGIC_VECTOR(31 downto 0);
            sel : in STD_LOGIC;
            y : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
	 
	 component mux2x1_5 is
        Port ( 
            d0 : in STD_LOGIC_VECTOR(4 downto 0);
            d1 : in STD_LOGIC_VECTOR(4 downto 0);
            sel : in STD_LOGIC;
            y : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    component mux3x1 is
        Port ( 
            d0 : in STD_LOGIC_VECTOR(31 downto 0);
            d1 : in STD_LOGIC_VECTOR(31 downto 0);
            d2 : in STD_LOGIC_VECTOR(31 downto 0);
            sel : in STD_LOGIC_VECTOR(1 downto 0);
            y : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component mux4x1 is
        Port ( 
            d0 : in STD_LOGIC_VECTOR(31 downto 0);
            d1 : in STD_LOGIC_VECTOR(31 downto 0);
            d2 : in STD_LOGIC_VECTOR(31 downto 0);
            d3 : in STD_LOGIC_VECTOR(31 downto 0);
            sel : in STD_LOGIC_VECTOR(1 downto 0);
            y : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
	 
	 component SignExtend is
        Port ( 
            input : in STD_LOGIC_VECTOR(15 downto 0);
            isSigned : in STD_LOGIC;
            output : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
	 
	 component ShiftLeft2 is
        Port ( 
            input : in STD_LOGIC_VECTOR(31 downto 0);
            output : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
	 
	 component ShiftLeft2_26 is
        Port ( 
            input : in STD_LOGIC_VECTOR(25 downto 0);
            output : out STD_LOGIC_VECTOR(27 downto 0)
        );
    end component;
	 
	 component ZeroExtend is
        Port ( 
            input : in STD_LOGIC_VECTOR(9 downto 0);
            output : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
	 
	 component alu is
        Port ( 
            input1 : in STD_LOGIC_VECTOR(31 downto 0);
            input2 : in STD_LOGIC_VECTOR(31 downto 0);
            shamt : in STD_LOGIC_VECTOR(4 downto 0);
            alu_control : in STD_LOGIC_VECTOR(4 downto 0);
            result : out STD_LOGIC_VECTOR(31 downto 0);
            result_hi : out STD_LOGIC_VECTOR(31 downto 0);
            branch_taken : out STD_LOGIC
        );
    end component;
	 
    component alu_control is
        Port ( 
            ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
            opcode : in STD_LOGIC_VECTOR(5 downto 0);
            funct : in STD_LOGIC_VECTOR(5 downto 0);
            ALU_LO_HI : out STD_LOGIC_VECTOR(1 downto 0);
            HI_en : out STD_LOGIC;
            LO_en : out STD_LOGIC;
            alu_control_out : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;
	 
	 component Concat is
        Port ( 
            input_28bit : in STD_LOGIC_VECTOR(27 downto 0);
            input_4bit : in STD_LOGIC_VECTOR(3 downto 0);
            output : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

	 -- Internal Reset (Button 1)
	 signal reset : STD_LOGIC;
	 
	 -- Internal signals for PC Register
    signal PC_in : STD_LOGIC_VECTOR(31 downto 0);
    signal PC_out : STD_LOGIC_VECTOR(31 downto 0);
	 
    -- Internal signals for Instruction Register
    signal IR_in : STD_LOGIC_VECTOR(31 downto 0);
    signal IR_out : STD_LOGIC_VECTOR(31 downto 0);
	 
	 -- Register File signals
    signal RF_rd_addr0 : std_logic_vector(4 downto 0);
    signal RF_rd_addr1 : std_logic_vector(4 downto 0);
    signal RF_wr_addr : std_logic_vector(4 downto 0);
    signal RF_wr_en : std_logic;
    signal RF_wr_data : std_logic_vector(31 downto 0);
    signal RF_rd_data0 : std_logic_vector(31 downto 0);
    signal RF_rd_data1 : std_logic_vector(31 downto 0);
    signal RF_JumpAndLink : std_logic;
	 
	 -- Memory Module signals
    signal Memory_baddr : STD_LOGIC_VECTOR(31 downto 0);
    signal Memory_dataIn : STD_LOGIC_VECTOR(31 downto 0);
    signal Memory_dataOut : STD_LOGIC_VECTOR(31 downto 0);
    signal Memory_switches : STD_LOGIC_VECTOR(31 downto 0);
    signal Memory_port_select : STD_LOGIC;
    signal Memory_input_enable : STD_LOGIC;
    signal Memory_display_out : STD_LOGIC_VECTOR(31 downto 0);

    -- Internal signals for Memory Data Register
    signal MDR_enable : STD_LOGIC;
    signal MDR_in : STD_LOGIC_VECTOR(31 downto 0);
    signal MDR_out : STD_LOGIC_VECTOR(31 downto 0);

    -- Internal signals for Register A
    signal RegA_enable : STD_LOGIC;
    signal RegA_in : STD_LOGIC_VECTOR(31 downto 0);
    signal RegA_out : STD_LOGIC_VECTOR(31 downto 0);

    -- Internal signals for Register B
    signal RegB_enable : STD_LOGIC;
    signal RegB_in : STD_LOGIC_VECTOR(31 downto 0);
    signal RegB_out : STD_LOGIC_VECTOR(31 downto 0);

    -- Internal signals for ALU Out Register
    signal ALUOut_enable : STD_LOGIC;
    signal ALUOut_in : STD_LOGIC_VECTOR(31 downto 0);
    signal ALUOut_out : STD_LOGIC_VECTOR(31 downto 0);

    -- Internal signals for LO Register
    signal LO_enable : STD_LOGIC;
    signal LO_in : STD_LOGIC_VECTOR(31 downto 0);
    signal LO_out : STD_LOGIC_VECTOR(31 downto 0);

    -- Internal signals for HI Register
    signal HI_enable : STD_LOGIC;
    signal HI_in : STD_LOGIC_VECTOR(31 downto 0);
    signal HI_out : STD_LOGIC_VECTOR(31 downto 0);
	 
	 -- 2x1 MUX signals
    signal MUX2x1_A_sel : STD_LOGIC;
    signal MUX2x1_A_out : STD_LOGIC_VECTOR(31 downto 0);
    
    signal MUX2x1_B_sel : STD_LOGIC;
    signal MUX2x1_B_out : STD_LOGIC_VECTOR(4 downto 0);
    
    signal MUX2x1_C_sel : STD_LOGIC;
    signal MUX2x1_C_out : STD_LOGIC_VECTOR(31 downto 0);
    
    signal MUX2x1_D_sel : STD_LOGIC;
    signal MUX2x1_D_out : STD_LOGIC_VECTOR(31 downto 0);

    -- 3x1 MUX signals
    signal MUX3x1_A_sel : STD_LOGIC_VECTOR(1 downto 0);
    signal MUX3x1_A_out : STD_LOGIC_VECTOR(31 downto 0);
    
    signal MUX3x1_B_sel : STD_LOGIC_VECTOR(1 downto 0);
    signal MUX3x1_B_out : STD_LOGIC_VECTOR(31 downto 0);

    -- 4x1 MUX signals
    signal MUX4x1_A_sel : STD_LOGIC_VECTOR(1 downto 0);
    signal MUX4x1_A_out : STD_LOGIC_VECTOR(31 downto 0);
	 
    -- Sign Extension signals
    signal SignExtend_input : STD_LOGIC_VECTOR(15 downto 0);
    signal SignExtend_isSigned : STD_LOGIC;
    signal SignExtend_output : STD_LOGIC_VECTOR(31 downto 0);
	 
	 -- Shift Left 2 signals
    signal ShiftLeft2_A_input : STD_LOGIC_VECTOR(31 downto 0);
    signal ShiftLeft2_A_output : STD_LOGIC_VECTOR(31 downto 0);
    
    signal ShiftLeft2_B_input : STD_LOGIC_VECTOR(25 downto 0);
    signal ShiftLeft2_B_output : STD_LOGIC_VECTOR(27 downto 0);
	 
	 -- Zero Extend signals
    signal ZeroExtend_input : STD_LOGIC_VECTOR(9 downto 0);
    signal ZeroExtend_output : STD_LOGIC_VECTOR(31 downto 0);
	 
	 -- ALU signals
    signal ALU_input1 : STD_LOGIC_VECTOR(31 downto 0);
    signal ALU_input2 : STD_LOGIC_VECTOR(31 downto 0);
    signal ALU_shamt : STD_LOGIC_VECTOR(4 downto 0);
    signal ALU_result : STD_LOGIC_VECTOR(31 downto 0);
    signal ALU_result_hi : STD_LOGIC_VECTOR(31 downto 0);
    signal ALU_branch_taken : STD_LOGIC;
	 
    -- ALU Control signals
    signal ALUControl_ALUOp : STD_LOGIC_VECTOR(1 downto 0);
    signal ALUControl_opcode : STD_LOGIC_VECTOR(5 downto 0);
    signal ALUControl_funct : STD_LOGIC_VECTOR(5 downto 0);
    signal ALUControl_ALU_LO_HI : STD_LOGIC_VECTOR(1 downto 0);
    signal ALUControl_HI_en : STD_LOGIC;
    signal ALUControl_LO_en : STD_LOGIC;
    signal ALUControl_out : STD_LOGIC_VECTOR(4 downto 0);
	 
	 -- Concatenation signals
    signal Concat_input_28bit : STD_LOGIC_VECTOR(27 downto 0);
    signal Concat_input_4bit : STD_LOGIC_VECTOR(3 downto 0);
    signal Concat_output : STD_LOGIC_VECTOR(31 downto 0);

begin

	reset <= buttons(1);

    -- PC Register
    PC: reg32 port map (
        clk => clk,
        reset => reset,
        enable => PC_enable,
        d => MUX3x1_A_out,
        q => PC_out
    );
	 
	 -- Instruction Register
    IR: reg32 port map (
        clk => clk,
        reset => reset,
        enable => IRWrite,
        d => Memory_dataOut,
        q => IR_out
    );
	 
	 OpCode <= IR_out(31 downto 26);
	 
    -- Register File instance
    RegFile: registerfile port map(
        clk => clk,
        rst => reset,
        rd_addr0 => IR_out(25 downto 21),
        rd_addr1 => IR_out(20 downto 16),
        wr_addr => MUX2x1_B_out,
        wr_en => RegWrite,
        wr_data => MUX2x1_C_out,
        rd_data0 => RF_rd_data0,
        rd_data1 => RF_rd_data1,
        JumpAndLink => JumpAndLink
    );
	 
	 -- Memory Module instance
    Memory: memory_module port map(
        clk => clk,
        baddr => MUX2x1_A_out,
        dataIn => RegB_out,
        memRead => memRead,
        memWrite => memWrite,
        dataOut => Memory_dataOut,
        switches => ZeroExtend_output,
        port_select => ZeroExtend_output(9),
        input_enable => buttons(0),
        display_out => Memory_display_out
    );
	 
	 
	 LED <= Memory_display_out(9 downto 0);
	 
    -- Memory Data Register
    MDR: reg32 port map (
        clk => clk,
        reset => reset,
        enable => '1',																																												
        d => Memory_dataOut,
        q => MDR_out
    );

    -- Register A
    RegA: reg32 port map (
        clk => clk,
        reset => reset,
        enable => '1',
        d => RF_rd_data0,
        q => RegA_out
    );

    -- Register B
    RegB: reg32 port map (
        clk => clk,
        reset => reset,
        enable => '1',
        d => RF_rd_data1,
        q => RegB_out
    );

    -- ALU Out Register
    ALUOut: reg32 port map (
        clk => clk,
        reset => reset,
        enable => '1',
        d => ALU_result,
        q => ALUOut_out
    );

    -- LO Register
    LO: reg32 port map (
        clk => clk,
        reset => reset,
        enable => ALUControl_LO_en,
        d => ALU_result,
        q => LO_out
    );

    -- HI Register
    HI: reg32 port map (
        clk => clk,
        reset => reset,
        enable => ALUControl_HI_en,
        d => ALU_result_hi,
        q => HI_out
    );
	 
    -- 2x1 MUX port maps
    MUX2x1_A: mux2x1 port map (
        d0 => PC_out,
        d1 => ALUOut_out,
        sel => IorD,
        y => MUX2x1_A_out
    );

    MUX2x1_B: mux2x1_5 port map (
        d0 => IR_out(20 downto 16),
        d1 => IR_out(15 downto 11),
        sel => RegDst,
        y => MUX2x1_B_out
    );

    MUX2x1_C: mux2x1 port map (
        d0 => MUX3x1_B_out,
        d1 => MDR_out,
        sel => MemToReg,
        y => MUX2x1_C_out																		
    );

    MUX2x1_D: mux2x1 port map (
        d0 => PC_out,
        d1 => RegA_out,
        sel => ALUSrcA,
        y => MUX2x1_D_out
    );

    -- 3x1 MUX port maps
    MUX3x1_A: mux3x1 port map (
        d0 => ALU_result,
        d1 => ALUOut_out,
        d2 => Concat_output,
        sel => PCSource,
        y => MUX3x1_A_out
    );

    MUX3x1_B: mux3x1 port map (
        d0 => ALUOut_out,
        d1 => LO_out,
        d2 => HI_out,
        sel => ALUControl_ALU_LO_HI,
        y => MUX3x1_B_out
    );

    -- 4x1 MUX port map
    MUX4x1_A: mux4x1 port map (
        d0 => RegB_out,
        d1 => X"00000004",
        d2 => SignExtend_output,
        d3 => ShiftLeft2_A_output,
        sel => AluSrcB,
        y => MUX4x1_A_out
    );
	 
    -- Sign Extension instance
    SignExtend_inst: SignExtend port map(
        input => IR_out(15 downto 0),
        isSigned => IsSigned,
        output => SignExtend_output
    );
	 
	 -- Shift Left 2 instances
    ShiftLeft2_A: ShiftLeft2 port map(
        input => SignExtend_output,
        output => ShiftLeft2_A_output
    );

    ShiftLeft2_B: ShiftLeft2_26 port map(
        input => IR_out(25 downto 0),
        output => ShiftLeft2_B_output
    );
	 
	 -- Zero Extend instance
    ZeroExtend_inst: ZeroExtend port map(
        input => switches,
        output => ZeroExtend_output
    );
	 
    -- ALU instance
    ALU_inst: alu port map(
        input1 => MUX2x1_D_out,
        input2 => MUX4x1_A_out,
        shamt => IR_out(10 downto 6),
        alu_control => ALUControl_out,
        result => ALU_result,
        result_hi => ALU_result_hi,
        branch_taken => branch_taken
    );

	 
    -- ALU Control instance
    ALUControl_inst: alu_control port map(
        ALUOp => ALUOp,
        opcode => ALUControl_opcode,
        funct => IR_out(5 downto 0),
        ALU_LO_HI => ALUControl_ALU_LO_HI,
        HI_en => ALUControl_HI_en,
        LO_en => ALUControl_LO_en,
        alu_control_out => ALUControl_out
    );
	 
	 funct <= IR_out(5 downto 0);
	 
	 -- Concatenation instance
    Concat_inst: Concat port map(
        input_28bit => ShiftLeft2_B_output,
        input_4bit => PC_out(31 downto 28),
        output => Concat_output
    );

end Behavioral;