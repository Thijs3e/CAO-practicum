library IEEE;
use IEEE.std_logic_1164.all;

entity control is
    port(
        instruction : in  std_logic_vector(5 downto 0);
        funct       : in  std_logic_vector(5 downto 0);
        branch      : out std_logic_vector(2 downto 0);
        regdst      : out std_logic;
        memread     : out std_logic;
        memtoreg    : out std_logic;
        aluop       : out std_logic_vector(3 downto 0);
        memwrite    : out std_logic;
        alusrc      : out std_logic;
        regwrite    : out std_logic
    );
end control;

architecture behavior of control is
begin
    process(instruction, funct)
    begin
        case instruction is
            when "000000" =>            -- add, addu, and, nor, or, sll, srl, sub, subu, xor, jr
                regdst   <= '1';
                if (funct = "001000") then
                    branch <= "010";
                else
                    branch <= "000";
                end if;
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0000";
                memwrite <= '0';
                alusrc   <= '0';
                regwrite <= '1';
            when "000001" =>            -- bgez, bltz
                regdst   <= '0';
                branch   <= "011";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0110";
                memwrite <= '0';
                alusrc   <= '0';
                regwrite <= '0';
            when "000010" =>            -- j
                regdst   <= '0';
                branch   <= "001";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0000";
                memwrite <= '0';
                alusrc   <= '0';
                regwrite <= '0';
            when "000011" =>            -- jal, these values are determined by combining (or) j and add
                regdst   <= '1';
                branch   <= "111";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "1111";
                memwrite <= '0';
                alusrc   <= '1';        -- such that data2 is the extended value that should be written to ra
                regwrite <= '1';
            when "000100" =>            -- beq
                regdst   <= '0';
                branch   <= "011";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0111";
                memwrite <= '0';
                alusrc   <= '0';
                regwrite <= '0';
            when "000101" =>            -- bne
                regdst   <= '0';
                branch   <= "011";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0111";
                memwrite <= '0';
                alusrc   <= '0';
                regwrite <= '0';
            when "000110" =>            -- blez
                regdst   <= '0';
                branch   <= "011";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0111";
                memwrite <= '0';
                alusrc   <= '0';
                regwrite <= '0';
            when "000111" =>            -- bgtz
                regdst   <= '0';
                branch   <= "011";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0111";
                memwrite <= '0';
                alusrc   <= '0';
                regwrite <= '0';
            when "001000" =>            -- addi
                regdst   <= '0';
                branch   <= "000";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0001";
                memwrite <= '0';
                alusrc   <= '1';
                regwrite <= '1';
            when "001001" =>            -- addiu
                regdst   <= '0';
                branch   <= "000";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0001";
                memwrite <= '0';
                alusrc   <= '1';
                regwrite <= '1';
            when "001100" =>            -- andi
                regdst   <= '0';
                branch   <= "000";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0010";
                memwrite <= '0';
                alusrc   <= '1';
                regwrite <= '1';
            when "001101" =>            -- ori
                regdst   <= '0';
                branch   <= "000";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0011";
                memwrite <= '0';
                alusrc   <= '1';
                regwrite <= '1';
            when "001110" =>            -- xori
                regdst   <= '0';
                branch   <= "000";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0100";
                memwrite <= '0';
                alusrc   <= '1';
                regwrite <= '1';
            when "001111" =>            -- lui
                regdst   <= '0';
                branch   <= "000";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0101";
                memwrite <= '0';
                alusrc   <= '1';
                regwrite <= '1';
            when "100011" =>            -- lw
                regdst   <= '0';
                branch   <= "000";
                memread  <= '1';
                memtoreg <= '1';
                aluop    <= "0001";
                memwrite <= '0';
                alusrc   <= '1';
                regwrite <= '1';
            when "101011" =>            -- sw
                regdst   <= '0';
                branch   <= "000";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0001";
                memwrite <= '1';
                alusrc   <= '1';
                regwrite <= '0';
            when others =>
                regdst   <= '0';
                branch   <= "000";
                memread  <= '0';
                memtoreg <= '0';
                aluop    <= "0000";
                memwrite <= '0';
                alusrc   <= '0';
                regwrite <= '0';
        end case;
    end process;
end behavior;

