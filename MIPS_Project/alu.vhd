library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    Port ( 
        input1 : in STD_LOGIC_VECTOR(31 downto 0);
        input2 : in STD_LOGIC_VECTOR(31 downto 0);
        shamt : in STD_LOGIC_VECTOR(4 downto 0);
        alu_control : in STD_LOGIC_VECTOR(4 downto 0);
        result : out STD_LOGIC_VECTOR(31 downto 0);
        result_hi : out STD_LOGIC_VECTOR(31 downto 0);
        branch_taken : out STD_LOGIC
    );
end alu;

architecture Behavioral of alu is
begin
    process(input1, input2, shamt, alu_control)
        variable mult_result : std_logic_vector(63 downto 0);
    begin
        -- Default values
        result <= (others => '0');
        result_hi <= (others => '0');
        branch_taken <= '0';

        case alu_control is
            -- Arithmetic & Logic Operations (0xxxx)
            when "00000" =>  -- add unsigned
                result <= std_logic_vector(unsigned(input1) + unsigned(input2));
                
            when "00001" =>  -- sub unsigned
                result <= std_logic_vector(unsigned(input1) - unsigned(input2));
                
            when "00010" =>  -- mult
                mult_result := std_logic_vector(signed(input1) * signed(input2));
                result <= mult_result(31 downto 0);      -- LO
                result_hi <= mult_result(63 downto 32);  -- HI
                
            when "00011" =>  -- mult unsigned
                mult_result := std_logic_vector(unsigned(input1) * unsigned(input2));
                result <= mult_result(31 downto 0);      -- LO
                result_hi <= mult_result(63 downto 32);  -- HI
                
            when "00100" =>  -- and
                result <= input1 and input2;
                
            when "00101" =>  -- or
                result <= input1 or input2;
                
            when "00110" =>  -- xor
                result <= input1 xor input2;
                
            when "00111" =>  -- srl
                result <= std_logic_vector(shift_right(unsigned(input1), to_integer(unsigned(shamt))));
                
            when "01000" =>  -- sll
                result <= std_logic_vector(shift_left(unsigned(input1), to_integer(unsigned(shamt))));
                
            when "01001" =>  -- sra
                result <= std_logic_vector(shift_right(signed(input1), to_integer(unsigned(shamt))));
                
            when "01010" =>  -- slt
                if signed(input1) < signed(input2) then
                    result <= x"00000001";
                else
                    result <= x"00000000";
                end if;
                
            when "01011" =>  -- sltu
                if unsigned(input1) < unsigned(input2) then
                    result <= x"00000001";
                else
                    result <= x"00000000";
                end if;
                
            when "01100" =>  -- mfhi
                result_hi <= input1;
                
            when "01101" =>  -- mflo
                result <= input1;      
                
            when "01110" =>  -- jr
                result <= input1;
                branch_taken <= '1';

            -- Branch Operations (10xxx)
            when "10000" =>  -- beq
                if input1 = input2 then
                    branch_taken <= '1';
                end if;
                result <= std_logic_vector(unsigned(input1) - unsigned(input2));
                
            when "10001" =>  -- bne
                if input1 /= input2 then
                    branch_taken <= '1';
                end if;
                result <= std_logic_vector(unsigned(input1) - unsigned(input2));
                
            when "10010" =>  -- blez
                if signed(input1) <= 0 then
                    branch_taken <= '1';
                end if;
                result <= input1;
                
            when "10011" =>  -- bgtz
                if signed(input1) > 0 then
                    branch_taken <= '1';
                end if;
                result <= input1;
                
            when "10100" =>  -- bltz
                if signed(input1) < 0 then
                    branch_taken <= '1';
                end if;
                result <= input1;

            when "10101" =>  -- j
                result <= input1;
                branch_taken <= '1';

            when "10110" =>  -- jal
                result <= input2;
                branch_taken <= '1';

            when others =>
                result <= (others => '0');
                result_hi <= (others => '0');
                branch_taken <= '0';
        end case;
    end process;
end Behavioral;