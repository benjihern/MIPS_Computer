library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_tb is
end alu_tb;

architecture Behavioral of alu_tb is

   component alu
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
   
   signal input1_tb : STD_LOGIC_VECTOR(31 downto 0);
   signal input2_tb : STD_LOGIC_VECTOR(31 downto 0);
   signal shamt_tb : STD_LOGIC_VECTOR(4 downto 0);
   signal alu_control_tb : STD_LOGIC_VECTOR(4 downto 0);
   signal result_tb : STD_LOGIC_VECTOR(31 downto 0);
   signal result_hi_tb : STD_LOGIC_VECTOR(31 downto 0);
   signal branch_taken_tb : STD_LOGIC;
   
begin

   UUT: alu port map (
       input1 => input1_tb,
       input2 => input2_tb,
       shamt => shamt_tb,
       alu_control => alu_control_tb,
       result => result_tb,
       result_hi => result_hi_tb,
       branch_taken => branch_taken_tb
   );
   
   stim_proc: process
   begin

       input1_tb <= (others => '0');
       input2_tb <= (others => '0');
       shamt_tb <= (others => '0');
       alu_control_tb <= (others => '0');
       wait for 100 ns;
       
       -- Test 1: Addition (10 + 15)
       input1_tb <= x"0000000A"; -- 10
       input2_tb <= x"0000000F"; -- 15
       alu_control_tb <= "00000";
       wait for 100 ns;
       
       -- Test 2: Subtraction (25 - 10)
       input1_tb <= x"00000019"; -- 25
       input2_tb <= x"0000000A"; -- 10
       alu_control_tb <= "00001";
       wait for 100 ns;
       
       -- Test 3: Signed Multiplication (10 * -4)
       input1_tb <= x"0000000A"; -- 10
       input2_tb <= x"FFFFFFFC"; -- -4
       alu_control_tb <= "00010";
       wait for 100 ns;
       
       -- Test 4: Unsigned Multiplication (65536 * 131072)
       input1_tb <= x"00010000"; -- 65536
       input2_tb <= x"00020000"; -- 131072
       alu_control_tb <= "00011";
       wait for 100 ns;
       
       -- Test 5: AND (0x0000FFFF AND 0xFFFF1234)
       input1_tb <= x"0000FFFF";
       input2_tb <= x"FFFF1234";
       alu_control_tb <= "00100";
       wait for 100 ns;
       
       -- Test 6: Shift Right Logical (0x0000000F >> 4)
       input1_tb <= x"0000000F";
       shamt_tb <= "00100"; -- shift by 4
       alu_control_tb <= "00111";
       wait for 100 ns;
       
       -- Test 7: Shift Right Arithmetic (0xF0000008 >> 1)
       input1_tb <= x"F0000008";
       shamt_tb <= "00001"; -- shift by 1
       alu_control_tb <= "01001";
       wait for 100 ns;
       
       -- Test 8: Shift Right Arithmetic (0x00000008 >> 1)
       input1_tb <= x"00000008";
       shamt_tb <= "00001"; -- shift by 1
       alu_control_tb <= "01001";
       wait for 100 ns;
       
       -- Test 9: Set Less Than (10 < 15)
       input1_tb <= x"0000000A"; -- 10
       input2_tb <= x"0000000F"; -- 15
       alu_control_tb <= "01010";
       wait for 100 ns;
       
       -- Test 10: Set Less Than (15 < 10)
       input1_tb <= x"0000000F"; -- 15
       input2_tb <= x"0000000A"; -- 10
       alu_control_tb <= "01010";
       wait for 100 ns;
       
       -- Test 11: BLEZ (A = 5)
       input1_tb <= x"00000005"; -- 5
       input2_tb <= x"00000000";
       alu_control_tb <= "10010"; -- BLEZ operation
       wait for 100 ns;
       
       -- Test 12: BGTZ (A = 5)
       input1_tb <= x"00000005"; -- 5
       input2_tb <= x"00000000";
       alu_control_tb <= "10011"; -- BGTZ operation
       wait for 100 ns;
       
       wait;
   end process;
end Behavioral;