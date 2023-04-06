library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory is
	port
	(
		clk			: in  std_logic;
		rst			: in  std_logic;
		memread			: in  std_logic;
		memwrite		: in  std_logic;
		address1		: in  std_logic_vector (31 downto 0);
		address2		: in  std_logic_vector (31 downto 0);
		writedata		: in  std_logic_vector (31 downto 0);
		instruction		: out std_logic_vector (31 downto 0);
		readdata		: out std_logic_vector (31 downto 0)
	);
end memory;

architecture behavior of memory is
	type ramcell is array (0 to 255) of std_logic_vector (7 downto 0);
	signal ram			: ramcell;
	signal masked1, masked2		: std_logic_vector (7 downto 0);
	signal selector1, selector2	: natural range 0 to 255;
begin
	masked1 <= address1 (7 downto 2) & "00";
	masked2 <= address2 (7 downto 2) & "00";
	selector1 <= to_integer (unsigned (masked1));
	selector2 <= to_integer (unsigned (masked2));

	process (clk, rst, memread, memwrite, address1, address2, writedata)
	begin
		if (rising_edge (clk)) then
			if (rst = '1') then
				ram (  0) <= "11110000"; -- addi $s0,$zero,2032
				ram (  1) <= "00000111";
				ram (  2) <= "00010000";
				ram (  3) <= "00100000";
				ram (  4) <= "00000110"; -- addi $s1,$zero,-250
				ram (  5) <= "11111111";
				ram (  6) <= "00010001";
				ram (  7) <= "00100000";
				ram (  8) <= "10000010"; -- srl $s2,$s0,2
				ram (  9) <= "10010000";
				ram ( 10) <= "00010000";
				ram ( 11) <= "00000000";
				ram ( 12) <= "10000010"; -- srl $s3,$s1,2
				ram ( 13) <= "10011000";
				ram ( 14) <= "00010001";
				ram ( 15) <= "00000000";
				ram ( 16) <= "10000011"; -- sra $s4,$s0,2
				ram ( 17) <= "10100000";
				ram ( 18) <= "00010000";
				ram ( 19) <= "00000000";
				ram ( 20) <= "10000011"; -- sra $s5,$s1,2
				ram ( 21) <= "10101000";
				ram ( 22) <= "00010001";
				ram ( 23) <= "00000000";
				ram ( 24) <= "00000001"; -- addi $t0,$zero,1
				ram ( 25) <= "00000000";
				ram ( 26) <= "00001000";
				ram ( 27) <= "00100000";
				ram ( 28) <= "00100000"; -- add $t1,$zero,$t0
				ram ( 29) <= "01001000";
				ram ( 30) <= "00001000";
				ram ( 31) <= "00000000";
				ram ( 32) <= "00000001"; -- addi $t0,$t0,1
				ram ( 33) <= "00000000";
				ram ( 34) <= "00001000";
				ram ( 35) <= "00100001";
				ram ( 36) <= "00100000"; -- add $t2,$zero,$t0
				ram ( 37) <= "01010000";
				ram ( 38) <= "00001000";
				ram ( 39) <= "00000000";
				ram ( 40) <= "00010000"; -- jal B
				ram ( 41) <= "00000000";
				ram ( 42) <= "00000000";
				ram ( 43) <= "00001100";
				ram ( 44) <= "00000001"; -- addi $t0,$t0,1
				ram ( 45) <= "00000000";
				ram ( 46) <= "00001000";
				ram ( 47) <= "00100001";
				ram ( 48) <= "00100000"; -- add $t3,$zero,$t0
				ram ( 49) <= "01011000";
				ram ( 50) <= "00001000";
				ram ( 51) <= "00000000";
				ram ( 52) <= "00000001"; -- addi $t0,$t0,1
				ram ( 53) <= "00000000";
				ram ( 54) <= "00001000";
				ram ( 55) <= "00100001";
				ram ( 56) <= "00100000"; -- add $t4,$zero,$t0
				ram ( 57) <= "01100000";
				ram ( 58) <= "00001000";
				ram ( 59) <= "00000000";
				ram ( 60) <= "00010101"; -- j end
				ram ( 61) <= "00000000";
				ram ( 62) <= "00000000";
				ram ( 63) <= "00001000";
				ram ( 64) <= "00000001"; -- addi $t0,$t0,1
				ram ( 65) <= "00000000";
				ram ( 66) <= "00001000";
				ram ( 67) <= "00100001";
				ram ( 68) <= "00100000"; -- add $t5,$zero,$t0
				ram ( 69) <= "01101000";
				ram ( 70) <= "00001000";
				ram ( 71) <= "00000000";
				ram ( 72) <= "00000001"; -- addi $t0,$t0,1
				ram ( 73) <= "00000000";
				ram ( 74) <= "00001000";
				ram ( 75) <= "00100001";
				ram ( 76) <= "00100000"; -- add $t6,$zero,$t0
				ram ( 77) <= "01110000";
				ram ( 78) <= "00001000";
				ram ( 79) <= "00000000";
				ram ( 80) <= "00001000"; -- jr $ra
				ram ( 81) <= "00000000";
				ram ( 82) <= "11100000";
				ram ( 83) <= "00000011";
				ram ( 84) <= "00000001"; -- addi $t0,$t0,1
				ram ( 85) <= "00000000";
				ram ( 86) <= "00001000";
				ram ( 87) <= "00100001";
				ram ( 88) <= "00100000"; -- add $t7,$zero,$t0
				ram ( 89) <= "01111000";
				ram ( 90) <= "00001000";
				ram ( 91) <= "00000000";
				for i in 92 to 255 loop
					ram (i) <= std_logic_vector (to_unsigned (0, 8));
				end loop;
			else
				if (memwrite = '1') then
					ram (selector2 + 0) <= writedata (7 downto 0);
					ram (selector2 + 1) <= writedata (15 downto 8);
					ram (selector2 + 2) <= writedata (23 downto 16);
					ram (selector2 + 3) <= writedata (31 downto 24);
				end if;
			end if;
		end if;
	end process;
	instruction <= ram (selector1 + 3) & ram (selector1 + 2) & ram (selector1 + 1) & ram (selector1 + 0);
	with memread select
		readdata <=	std_logic_vector (to_unsigned (0, 32)) when '0',
				ram (selector2 + 3) & ram (selector2 + 2) & ram (selector2 + 1) & ram (selector2 + 0) when others;
end behavior;
