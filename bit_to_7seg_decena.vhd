library ieee;
use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_unsigned.ALL;

Entity bit_to_7seg_decena is
	Port(	w: in std_logic_vector(5 downto 0);
			en: in std_logic;
			Q1: out std_logic_vector(6 downto 0));
end bit_to_7seg_decena;

Architecture sol of bit_to_7seg_decena is
Signal F1: std_logic_vector(6 downto 0);

Begin			--gfedcba
	with w select
	F1<="1000000" when "000000" to "001001",--0 a 9
		 "1111001" when "001010" to "010011",--10 a 19
	    "0100100" when "010100" to "011101",--20 a 29
	    "0110000" when "011110" to "100111",--30 a 39
	    "0011001" when "101000" to "110001",--40 a 49
	    "0010010" when "110010" to "111011",--50 a 59
	    "0000010" when "111100",--60
		 "1111111" when others;
	
	Q1<=not(F1) when en='1' else "0000000"; 
end sol;
