library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory_default is
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
end memory_default;

architecture behavior of memory_default is
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
				ram (  0) <= "11111111"; -- lui	$0,-1
				ram (  1) <= "11111111";
				ram (  2) <= "00000000";
				ram (  3) <= "00111100";
				ram (  4) <= "11111111"; -- lui	$1,-1
				ram (  5) <= "11111111";
				ram (  6) <= "00000001";
				ram (  7) <= "00111100";
				ram (  8) <= "11111111"; -- ori	$1,$1,-1
				ram (  9) <= "11111111";
				ram ( 10) <= "00100001";
				ram ( 11) <= "00110100";
				ram ( 12) <= "00000101"; -- j	B
				ram ( 13) <= "00000000";
				ram ( 14) <= "00000000";
				ram ( 15) <= "00001000";
				ram ( 16) <= "00000001"; -- lui	$2,1
				ram ( 17) <= "00000000";
				ram ( 18) <= "00000010";
				ram ( 19) <= "00111100";
				ram ( 20) <= "00101010"; -- addi	$3,$0,42
				ram ( 21) <= "00000000";
				ram ( 22) <= "00000011";
				ram ( 23) <= "00100000";
				ram ( 24) <= "11111010"; -- addiu	$4,$3,-6
				ram ( 25) <= "11111111";
				ram ( 26) <= "01100100";
				ram ( 27) <= "00100100";
				ram ( 28) <= "00001000"; -- jr	$4
				ram ( 29) <= "00000000";
				ram ( 30) <= "10000000";
				ram ( 31) <= "00000000";
				ram ( 32) <= "00001000"; -- j	C
				ram ( 33) <= "00000000";
				ram ( 34) <= "00000000";
				ram ( 35) <= "00001000";
				ram ( 36) <= "00100000"; -- add	$5,$4,$3
				ram ( 37) <= "00101000";
				ram ( 38) <= "10000011";
				ram ( 39) <= "00000000";
				ram ( 40) <= "00100001"; -- addu	$6,$5,$5
				ram ( 41) <= "00110000";
				ram ( 42) <= "10100101";
				ram ( 43) <= "00000000";
				ram ( 44) <= "00100100"; -- and	$7,$6,$3
				ram ( 45) <= "00111000";
				ram ( 46) <= "11000011";
				ram ( 47) <= "00000000";
				ram ( 48) <= "11101001"; -- andi	$8,$1,-23
				ram ( 49) <= "11111111";
				ram ( 50) <= "00101000";
				ram ( 51) <= "00110000";
				ram ( 52) <= "00100111"; -- nor	$9,$8,$6
				ram ( 53) <= "01001000";
				ram ( 54) <= "00000110";
				ram ( 55) <= "00000001";
				ram ( 56) <= "00100101"; -- or	$10,$9,$5
				ram ( 57) <= "01010000";
				ram ( 58) <= "00100101";
				ram ( 59) <= "00000001";
				ram ( 60) <= "00000010"; -- srl	$11,$10,8
				ram ( 61) <= "01011010";
				ram ( 62) <= "00001010";
				ram ( 63) <= "00000000";
				ram ( 64) <= "00000000"; -- sll	$12,$11,4
				ram ( 65) <= "01100001";
				ram ( 66) <= "00001011";
				ram ( 67) <= "00000000";
				ram ( 68) <= "00100010"; -- sub	$13,$12,$3
				ram ( 69) <= "01101000";
				ram ( 70) <= "10000011";
				ram ( 71) <= "00000001";
				ram ( 72) <= "00100011"; -- subu	$14,$12,$13
				ram ( 73) <= "01110000";
				ram ( 74) <= "10001101";
				ram ( 75) <= "00000001";
				ram ( 76) <= "00000111"; -- xori	$15,$14,7
				ram ( 77) <= "00000000";
				ram ( 78) <= "11001111";
				ram ( 79) <= "00111001";
				ram ( 80) <= "00100110"; -- xor	$16,$15,$14
				ram ( 81) <= "10000000";
				ram ( 82) <= "11101110";
				ram ( 83) <= "00000001";
				ram ( 84) <= "11111111"; -- beq	$14,$5,D
				ram ( 85) <= "11111111";
				ram ( 86) <= "11000101";
				ram ( 87) <= "00010001";
				ram ( 88) <= "00000001"; -- beq	$14,$3,F
				ram ( 89) <= "00000000";
				ram ( 90) <= "11000011";
				ram ( 91) <= "00010001";
				ram ( 92) <= "00010111"; -- j	E
				ram ( 93) <= "00000000";
				ram ( 94) <= "00000000";
				ram ( 95) <= "00001000";
				ram ( 96) <= "00000001"; -- bne	$4,$5,H
				ram ( 97) <= "00000000";
				ram ( 98) <= "10000101";
				ram ( 99) <= "00010100";
				ram (100) <= "00011001"; -- j	G
				ram (101) <= "00000000";
				ram (102) <= "00000000";
				ram (103) <= "00001000";
				ram (104) <= "11111111"; -- bne	$3,$14,H
				ram (105) <= "11111111";
				ram (106) <= "01101110";
				ram (107) <= "00010100";
				ram (108) <= "00000001"; -- bgez	$0,J
				ram (109) <= "00000000";
				ram (110) <= "00000001";
				ram (111) <= "00000100";
				ram (112) <= "00011100"; -- j	I
				ram (113) <= "00000000";
				ram (114) <= "00000000";
				ram (115) <= "00001000";
				ram (116) <= "11111111"; -- bgez	$1,J
				ram (117) <= "11111111";
				ram (118) <= "00100001";
				ram (119) <= "00000100";
				ram (120) <= "00000001"; -- bgez	$3,L
				ram (121) <= "00000000";
				ram (122) <= "01100001";
				ram (123) <= "00000100";
				ram (124) <= "00011111"; -- j	K
				ram (125) <= "00000000";
				ram (126) <= "00000000";
				ram (127) <= "00001000";
				ram (128) <= "11111111"; -- bgtz	$0,L
				ram (129) <= "11111111";
				ram (130) <= "00000000";
				ram (131) <= "00011100";
				ram (132) <= "11111111"; -- bgtz	$1,M
				ram (133) <= "11111111";
				ram (134) <= "00100000";
				ram (135) <= "00011100";
				ram (136) <= "00000001"; -- bgtz	$3,O
				ram (137) <= "00000000";
				ram (138) <= "01100000";
				ram (139) <= "00011100";
				ram (140) <= "00100011"; -- j	N
				ram (141) <= "00000000";
				ram (142) <= "00000000";
				ram (143) <= "00001000";
				ram (144) <= "00000001"; -- blez	$0,Q
				ram (145) <= "00000000";
				ram (146) <= "00000000";
				ram (147) <= "00011000";
				ram (148) <= "00100101"; -- j	P
				ram (149) <= "00000000";
				ram (150) <= "00000000";
				ram (151) <= "00001000";
				ram (152) <= "11111111"; -- blez	$3,Q
				ram (153) <= "11111111";
				ram (154) <= "01100000";
				ram (155) <= "00011000";
				ram (156) <= "00000001"; -- blez	$1,S
				ram (157) <= "00000000";
				ram (158) <= "00100000";
				ram (159) <= "00011000";
				ram (160) <= "00101000"; -- j	R
				ram (161) <= "00000000";
				ram (162) <= "00000000";
				ram (163) <= "00001000";
				ram (164) <= "11111111"; -- bltz	$0,S
				ram (165) <= "11111111";
				ram (166) <= "00000000";
				ram (167) <= "00000100";
				ram (168) <= "11111111"; -- bltz	$3,T
				ram (169) <= "11111111";
				ram (170) <= "01100000";
				ram (171) <= "00000100";
				ram (172) <= "00000001"; -- bltz	$1,V
				ram (173) <= "00000000";
				ram (174) <= "00100000";
				ram (175) <= "00000100";
				ram (176) <= "00101100"; -- j	U
				ram (177) <= "00000000";
				ram (178) <= "00000000";
				ram (179) <= "00001000";
				ram (180) <= "11111000"; -- addi	$17,$0,248
				ram (181) <= "00000000";
				ram (182) <= "00010001";
				ram (183) <= "00100000";
				ram (184) <= "11111100"; -- sw	$1,-4($17)
				ram (185) <= "11111111";
				ram (186) <= "00100001";
				ram (187) <= "10101110";
				ram (188) <= "00000000"; -- sw	$3,0($17)
				ram (189) <= "00000000";
				ram (190) <= "00100011";
				ram (191) <= "10101110";
				ram (192) <= "00000100"; -- sw	$4,4($17)
				ram (193) <= "00000000";
				ram (194) <= "00100100";
				ram (195) <= "10101110";
				ram (196) <= "00110100"; -- j	X
				ram (197) <= "00000000";
				ram (198) <= "00000000";
				ram (199) <= "00001000";
				ram (200) <= "11111000"; -- addi	$17,$17,-8
				ram (201) <= "11111111";
				ram (202) <= "00110001";
				ram (203) <= "00100010";
				ram (204) <= "00110111"; -- j	Y
				ram (205) <= "00000000";
				ram (206) <= "00000000";
				ram (207) <= "00001000";
				ram (208) <= "11111100"; -- lw	$18,-4($17)
				ram (209) <= "11111111";
				ram (210) <= "00110010";
				ram (211) <= "10001110";
				ram (212) <= "00000000"; -- lw	$19,0($17)
				ram (213) <= "00000000";
				ram (214) <= "00110011";
				ram (215) <= "10001110";
				ram (216) <= "00110010"; -- j	W
				ram (217) <= "00000000";
				ram (218) <= "00000000";
				ram (219) <= "00001000";
				ram (220) <= "00001100"; -- lw	$20,12($17)
				ram (221) <= "00000000";
				ram (222) <= "00110100";
				ram (223) <= "10001110";
				ram (224) <= "00111000"; -- j	Z
				ram (225) <= "00000000";
				ram (226) <= "00000000";
				ram (227) <= "00001000";
				for i in 228 to 255 loop
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
