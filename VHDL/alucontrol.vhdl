library IEEE;
use IEEE.std_logic_1164.all;

entity alucontrol is
    port(
        aluop       : in  std_logic_vector(3 downto 0);
        instruction : in  std_logic_vector(5 downto 0);
        branch1     : in  std_logic;
        branch2     : in  std_logic_vector(1 downto 0);
        aluinstr    : out std_logic_vector(4 downto 0)
    );
end alucontrol;

architecture behavior of alucontrol is
begin
    process(aluop, instruction, branch1, branch2)
    begin
        case aluop is
            when "0000" =>              -- unknown
                case instruction is
                    when "100000" =>    -- add
                        aluinstr <= "00010";
                    when "100001" =>    -- addu
                        aluinstr <= "00010";
                    when "100100" =>    -- and
                        aluinstr <= "00100";
                    when "100111" =>    -- nor
                        aluinstr <= "00110";
                    when "100101" =>    -- or
                        aluinstr <= "00101";
                    when "100110" =>    -- xor
                        aluinstr <= "00111";
                    when "000000" =>    -- sll
                        aluinstr <= "01000";
                    when "000010" =>    -- srl
                        aluinstr <= "01001";
                    when "100010" =>    -- sub
                        aluinstr <= "00011";
                    when "100011" =>    -- subu
                        aluinstr <= "00011";
                    -- Add here the cases for the new instruction i think (sra, sllv or slt)
                    when "000011" =>
                        aluinstr <= "11111"; -- sra
                    --
                    when others =>
                        aluinstr <= "00000";
                end case;
            when "0001" =>              -- add
                aluinstr <= "00010";
            when "0010" =>              -- and
                aluinstr <= "00100";
            when "0011" =>              -- or
                aluinstr <= "00101";
            when "0100" =>              -- xor
                aluinstr <= "00111";
            when "0101" =>              -- lui
                aluinstr <= "00001";
            when "0110" =>              -- bgez, bltz
                aluinstr <= "0101" & branch1;
            when "0111" =>              -- beq, bne, blez, bgtz
                aluinstr <= "011" & branch2;
            when "1111" =>
                aluinstr <= "11011";    -- jal
            when others =>
                aluinstr <= "00000";
        end case;
    end process;
end behavior;

