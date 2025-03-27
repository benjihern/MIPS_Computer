library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_control is
    Port ( 
        ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
        opcode : in STD_LOGIC_VECTOR(5 downto 0);
        funct : in STD_LOGIC_VECTOR(5 downto 0);
        ALU_LO_HI : out STD_LOGIC_VECTOR(1 downto 0);
        HI_en : out STD_LOGIC;
        LO_en : out STD_LOGIC;
        alu_control_out : out STD_LOGIC_VECTOR(4 downto 0)
    );
end alu_control;

architecture Behavioral of alu_control is
begin
    process(ALUOp, opcode, funct)
    begin
        -- Default values
        alu_control_out <= "11111";  -- Default to NOP
        ALU_LO_HI <= "00";          -- Default to ALU result
        HI_en <= '0';               -- Default HI register disable
        LO_en <= '0';               -- Default LO register disable

        case ALUOp is
            when "00" =>  -- Load/Store instructions
                ALU_LO_HI <= "00";
                alu_control_out <= "00000";  -- add operation
                
            when "10" =>  -- R-type instructions
                case funct is
                    when "100001" => -- addu
                        alu_control_out <= "00000";
                        
                    when "100011" => -- subu
                        alu_control_out <= "00001";
                        
                    when "011000" => -- mult
                        alu_control_out <= "00010";
                        HI_en <= '1';
                        LO_en <= '1';
                        
                    when "011001" => -- multu
                        alu_control_out <= "00011";
                        HI_en <= '1';
                        LO_en <= '1';
                        
                    when "100100" => -- and
                        alu_control_out <= "00100";
                        
                    when "100101" => -- or
                        alu_control_out <= "00101";
                        
                    when "100110" => -- xor
                        alu_control_out <= "00110";
                        
                    when "000010" => -- srl
                        alu_control_out <= "00111";
                        
                    when "000000" => -- sll
                        alu_control_out <= "01000";
                        
                    when "000011" => -- sra
                        alu_control_out <= "01001";
                        
                    when "101010" => -- slt
                        alu_control_out <= "01010";
                        
                    when "101011" => -- sltu
                        alu_control_out <= "01011";
                        
                    when "010000" => -- mfhi
                        alu_control_out <= "01100";
                        ALU_LO_HI <= "10";  -- Select HI register  

                        
                    when "010010" => -- mflo
                        alu_control_out <= "01101";
                        ALU_LO_HI <= "01";  -- Select LO register
                        
                    when "001000" => -- jr
                        alu_control_out <= "01110";
                        
                    when others =>
                        alu_control_out <= "11111";
                end case;
                
            when "01" => -- Branch instructions
                case opcode is
                    when "000100" => -- beq
                        alu_control_out <= "10000";
                        
                    when "000101" => -- bne
                        alu_control_out <= "10001";
                        
                    when "000110" => -- blez
                        alu_control_out <= "10010";
                        
                    when "000111" => -- bgtz
                        alu_control_out <= "10011";
                        
                    when "000001" => -- bltz/bgez
                        alu_control_out <= "10100";
                        
                    when "000010" => -- j
                        alu_control_out <= "10101";
                        
                    when "000011" => -- jal
                        alu_control_out <= "10110";
                        
                    when others =>
                        alu_control_out <= "11111";
                end case;
                
            when others => -- I-type instructions
                case opcode is
                    when "001001" => -- addiu
                        alu_control_out <= "00000";
                        
                    when "001100" => -- andi
                        alu_control_out <= "00100";
                        
                    when "001101" => -- ori
                        alu_control_out <= "00101";
                        
                    when "001110" => -- xori
                        alu_control_out <= "00110";
                        
                    when "001010" => -- slti
                        alu_control_out <= "01010";
                        
                    when "001011" => -- sltiu
                        alu_control_out <= "01011";
                        
                    when others =>
                        alu_control_out <= "11111";
                end case;
        end case;
    end process;
end Behavioral;